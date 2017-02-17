From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC,original PATCH] CSE: let equivalent cast hash & compare identically
Date: Fri, 17 Feb 2017 01:06:08 +0100
Message-ID: <20170217000608.6433-2-luc.vanoostenryck@gmail.com>
References: <20170217000608.6433-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34621 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdBQAGR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 19:06:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so44433wmi.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 16:06:16 -0800 (PST)
In-Reply-To: <20170217000608.6433-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 cse.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/cse.c b/cse.c
index 89812afae..aab6bc7a4 100644
--- a/cse.c
+++ b/cse.c
@@ -34,6 +34,49 @@ static int phi_compare(pseudo_t phi1, pseudo_t phi2)
 	return 0;
 }
 
+// for cast's hashing & comparison
+struct typeinfo {
+	struct symbol *type;
+	unsigned int size;
+	int kind;
+};
+
+static void get_typeinfo(struct symbol *type, struct typeinfo *info)
+{
+	struct symbol *basetype;
+
+redo:
+	basetype = type->ctype.base_type;
+	switch (type->type) {
+	case SYM_NODE:
+		type = basetype;
+		goto redo;
+
+	case SYM_BASETYPE:
+		if (basetype == &int_ctype)
+			break;
+		if (basetype == &fp_type)
+			break;
+		basetype = type;
+		break;
+
+	case SYM_ENUM:
+	case SYM_BITFIELD:
+	case SYM_PTR:
+	case SYM_FN:
+	case SYM_ARRAY:
+		break;
+
+	default:
+		basetype = type;
+		break;
+	}
+
+	info->type = basetype;
+	info->size = type->bit_size;
+	info->kind = type->type;
+	return;
+}
 
 static void clean_up_one_instruction(struct basic_block *bb, struct instruction *insn)
 {
@@ -90,16 +133,16 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 
 	case OP_CAST:
 	case OP_SCAST:
-	case OP_PTRCAST:
-		/*
-		 * This is crap! Many "orig_types" are the
-		 * same as far as casts go, we should generate
-		 * some kind of "type hash" that is identical
-		 * for identical casts
-		 */
-		hash += hashval(insn->orig_type);
+	case OP_PTRCAST: {
+		struct typeinfo info;
+
+		get_typeinfo(insn->orig_type, &info);
+		hash += hashval(info.type);
+		hash += hashval(info.size);
+		hash += hashval(info.kind);
 		hash += hashval(insn->src);
 		break;
+	}
 
 	/* Other */
 	case OP_PHI: {
@@ -234,15 +277,22 @@ static int insn_compare(const void *_i1, const void *_i2)
 
 	case OP_CAST:
 	case OP_SCAST:
-	case OP_PTRCAST:
-		/*
-		 * This is crap! See the comments on hashing.
-		 */
-		if (i1->orig_type != i2->orig_type)
-			return i1->orig_type < i2->orig_type ? -1 : 1;
+	case OP_PTRCAST: {
+		struct typeinfo info1, info2;
+
+		get_typeinfo(i1->orig_type, &info1);
+		get_typeinfo(i2->orig_type, &info2);
+
 		if (i1->src != i2->src)
 			return i1->src < i2->src ? -1 : 1;
+		if (info1.type != info2.type)
+			return info1.type < info2.type ? -1 : 1;
+		if (info1.size != info2.size)
+			return info1.size < info2.size ? -1 : 1;
+		if (info1.kind != info2.kind)
+			return info1.kind < info2.kind ? -1 : 1;
 		break;
+	}
 
 	default:
 		warning(i1->pos, "bad instruction on hash chain");
-- 
2.11.0

