From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 05/14] cast: handle NO-OP casts
Date: Thu, 17 Aug 2017 06:05:20 +0200
Message-ID: <20170817040529.7289-6-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34588 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEFu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id x43so6181332wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:49 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some casts, the ones which deosn't chnage the size or the resulting
'machine type', are no-op.

Directly simplify away such casts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c             |  8 ++++++++
 validation/cast-kinds.c | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/linearize.c b/linearize.c
index 7f8dbc64a..3f8d955c5 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1161,6 +1161,8 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 	case MTYPE_FLOAT:
 		switch (stype) {
 		case MTYPE_FLOAT:
+			if (dst->bit_size == src->bit_size)
+				return OP_NOP;
 			return OP_FCVTF;
 		case MTYPE_UINT:
 			return OP_UCVTF;
@@ -1198,6 +1200,12 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 	if (from->bit_size < 0 || to->bit_size < 0)
 		return VOID;
 	opcode = get_cast_opcode(to, from);
+	switch (opcode) {
+	case OP_NOP:
+		return src;
+	default:
+		break;
+	}
 	insn = alloc_typed_instruction(opcode, to);
 	result = alloc_pseudo(insn);
 	insn->target = result;
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index 34bf685d2..0312bc92b 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -50,6 +50,9 @@ static double long_2_double(long a) { return (double)a; }
 static double ulong_2_double(ulong a) { return (double)a; }
 static double float_2_double(float a) { return (double)a; }
 
+static float float_2_float(float a) { return a; }
+static double double_2_double(double a) { return a; }
+
 /*
  * check-name: cast-kinds
  * check-command: test-linearize -m64 $file
@@ -383,5 +386,17 @@ float_2_double:
 	ret.64      %r143
 
 
+float_2_float:
+.L96:
+	<entry-point>
+	ret.32      %arg1
+
+
+double_2_double:
+.L98:
+	<entry-point>
+	ret.64      %arg1
+
+
  * check-output-end
  */
-- 
2.14.0

