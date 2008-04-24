From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Simplify (and warn about) right shifts that result in
 zero
Date: Thu, 24 Apr 2008 14:54:53 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk> <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41504 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753688AbYDXVzO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 17:55:14 -0400
In-Reply-To: <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Thu, 24 Apr 2008 14:47:04 -0700

..due to limited source sizes.

Yeah, should do this for left shifts too.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Again, not a lot of testing, but it _looks_ fairly sane.

The constant value case of "operand_size()" is not actually ever used 
(because a totally constant right shift will be optimized in other 
places), but I wrote the code so that perhaps other cases could use this. 
Whatever. 

The "do the same for left shifts" could do a similar check, but based 
purely on the size of the operation, not the size of the operand value. 
Which makes it not very interesting.

 simplify.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/simplify.c b/simplify.c
index 94e14d2..8200584 100644
--- a/simplify.c
+++ b/simplify.c
@@ -256,6 +256,59 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	return REPEAT_CSE;
 }
 
+static unsigned int value_size(long long value)
+{
+	value >>= 8;
+	if (!value)
+		return 8;
+	value >>= 8;
+	if (!value)
+		return 16;
+	value >>= 16;
+	if (!value)
+		return 32;
+	return 64;
+}
+
+/*
+ * Try to determine the maximum size of bits in a pseudo.
+ *
+ * Right now this only follow casts and constant values, but we
+ * could look at things like logical 'and' instructions etc.
+ */
+static unsigned int operand_size(struct instruction *insn, pseudo_t pseudo)
+{
+	unsigned int size = insn->size;
+
+	if (pseudo->type == PSEUDO_REG) {
+		struct instruction *src = pseudo->def;
+		if (src && src->opcode == OP_CAST && src->orig_type) {
+			unsigned int orig_size = src->orig_type->bit_size;
+			if (orig_size < size)
+				size = orig_size;
+		}
+	}
+	if (pseudo->type == PSEUDO_VAL) {
+		unsigned int orig_size = value_size(pseudo->value);
+		if (orig_size < size)
+			size = orig_size;
+	}
+	return size;
+}
+
+static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long value)
+{
+	unsigned int size = operand_size(insn, pseudo);
+
+	if (value >= size) {
+		warning(insn->pos, "right shift by bigger than source value");
+		return replace_with_pseudo(insn, value_pseudo(0));
+	}
+	if (!value)
+		return replace_with_pseudo(insn, pseudo);
+	return 0;
+}
+
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value = insn->src2->value;
@@ -272,10 +325,12 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_OR: case OP_XOR:
 	case OP_OR_BOOL:
 	case OP_SHL:
-	case OP_LSR: case OP_ASR:
+	case OP_LSR:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src1);
 		return 0;
+	case OP_ASR:
+		return simplify_asr(insn, insn->src1, value);
 
 	case OP_MULU: case OP_MULS:
 	case OP_AND_BOOL:
-- 
1.5.5.1.92.ga5bdc

