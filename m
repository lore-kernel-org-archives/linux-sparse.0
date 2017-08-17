From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 03/14] cast: prepare finer grained cast instructions
Date: Thu, 17 Aug 2017 06:05:18 +0200
Message-ID: <20170817040529.7289-4-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36665 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEFp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id y67so6172211wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:44 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

As a first step, add a small function classify values into
'machine type:
- signed integer
- unsigned integer
- pointer
- floats
and use this to select the appropriate O_XXXCAST.

Note: this is a preparatory patch and should not introduce
      any changes in the generated IR.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/linearize.c b/linearize.c
index ba76397ea..c77a3c2df 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1109,28 +1109,75 @@ static pseudo_t linearize_postop(struct entrypoint *ep, struct expression *expr)
  * case, since you can't access through it anyway without another
  * cast.
  */
-static struct instruction *alloc_cast_instruction(struct symbol *src, struct symbol *ctype)
+enum mtype {
+	MTYPE_UINT,
+	MTYPE_SINT,
+	MTYPE_PTR,
+	MTYPE_FLOAT,
+	MTYPE_BAD,
+};
+
+static enum mtype get_mtype(struct symbol *s)
+{
+	int sign = (s->ctype.modifiers & MOD_SIGNED) ? 1 : 0;
+
+retry:	switch (s->type) {
+	case SYM_NODE:
+		s = s->ctype.base_type;
+		goto retry;
+	case SYM_PTR:
+		if (s->ctype.base_type == &void_ctype)
+			// handle void pointer like an uint
+			goto case_int;
+		return MTYPE_PTR;
+	case SYM_BITFIELD:
+	case SYM_RESTRICT:
+	case SYM_FOULED:
+	case SYM_ENUM:
+		s = s->ctype.base_type;
+		/* fall-through */
+	case_int:
+		return sign ? MTYPE_SINT : MTYPE_UINT;
+	case SYM_BASETYPE:
+		if (s->ctype.base_type == &fp_type)
+			return MTYPE_FLOAT;
+		if (s->ctype.base_type == &int_type)
+			goto case_int;
+		/* fall-through */
+	default:
+		return MTYPE_BAD;
+	}
+}
+
+static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 {
-	int opcode = OP_CAST;
-	struct symbol *base = ctype;
+	enum mtype stype = get_mtype(src);
+	enum mtype dtype = get_mtype(dst);
 
-	if (src->ctype.modifiers & MOD_SIGNED)
-		opcode = OP_SCAST;
-	if (base->type == SYM_NODE)
-		base = base->ctype.base_type;
-	if (base->type == SYM_PTR) {
-		base = base->ctype.base_type;
-		if (base != &void_ctype)
-			opcode = OP_PTRCAST;
-	} else if (base->ctype.base_type == &fp_type)
-		opcode = OP_FPCAST;
-	return alloc_typed_instruction(opcode, ctype);
+	switch (dtype) {
+	case MTYPE_FLOAT:
+		return  OP_FPCAST;
+	case MTYPE_PTR:
+		return OP_PTRCAST;
+	case MTYPE_UINT:
+	case MTYPE_SINT:
+		switch (stype) {
+		case MTYPE_SINT:
+			return OP_SCAST;
+		default:
+			break;
+		}
+		/* fall through */
+	default:
+		return OP_CAST;
+	}
 }
 
 static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *from, struct symbol *to)
 {
 	pseudo_t result;
 	struct instruction *insn;
+	int opcode;
 
 	if (src == VOID)
 		return VOID;
@@ -1138,7 +1185,8 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 		return VOID;
 	if (from->bit_size < 0 || to->bit_size < 0)
 		return VOID;
-	insn = alloc_cast_instruction(from, to);
+	opcode = get_cast_opcode(to, from);
+	insn = alloc_typed_instruction(opcode, to);
 	result = alloc_pseudo(insn);
 	insn->target = result;
 	insn->orig_type = from;
-- 
2.14.0

