From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] add warning option '-Wtautological-compare'
Date: Wed,  7 Dec 2016 17:32:57 +0100
Message-ID: <20161207163257.22287-3-luc.vanoostenryck@gmail.com>
References: <20161207163257.22287-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35257 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbcLGQdg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 11:33:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so28989636wme.2
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 08:33:08 -0800 (PST)
In-Reply-To: <20161207163257.22287-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that we optimize away expressions like 'x == x' or 'x < x',
also add a warning for it (but disabled by default).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                             |  2 ++
 lib.h                             |  1 +
 simplify.c                        |  4 ++++
 validation/tautological-compare.c | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 validation/tautological-compare.c

diff --git a/lib.c b/lib.c
index e5b0bb63..6b7a0817 100644
--- a/lib.c
+++ b/lib.c
@@ -236,6 +236,7 @@ int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
 int Wshadow = 0;
 int Wsizeof_bool = 0;
+int Wtautological_compare = 0;
 int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
@@ -471,6 +472,7 @@ static const struct warning {
 	{ "return-void", &Wreturn_void },
 	{ "shadow", &Wshadow },
 	{ "sizeof-bool", &Wsizeof_bool },
+	{ "tautological-compare", &Wtautological_compare },
 	{ "transparent-union", &Wtransparent_union },
 	{ "typesign", &Wtypesign },
 	{ "undef", &Wundef },
diff --git a/lib.h b/lib.h
index 15b69fa2..130e5b6c 100644
--- a/lib.h
+++ b/lib.h
@@ -122,6 +122,7 @@ extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
 extern int Wshadow;
 extern int Wsizeof_bool;
+extern int Wtautological_compare;
 extern int Wtransparent_union;
 extern int Wtypesign;
 extern int Wundef;
diff --git a/simplify.c b/simplify.c
index fde72f0a..b29b3ebb 100644
--- a/simplify.c
+++ b/simplify.c
@@ -494,6 +494,8 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 	case OP_SET_NE:
 	case OP_SET_LT: case OP_SET_GT:
 	case OP_SET_B:  case OP_SET_A:
+		if (Wtautological_compare)
+			warning(insn->pos, "self-comparison always evaluates to false");
 	case OP_SUB:
 	case OP_XOR:
 		return replace_with_pseudo(insn, value_pseudo(0));
@@ -501,6 +503,8 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 	case OP_SET_EQ:
 	case OP_SET_LE: case OP_SET_GE:
 	case OP_SET_BE: case OP_SET_AE:
+		if (Wtautological_compare)
+			warning(insn->pos, "self-comparison always evaluates to true");
 		return replace_with_pseudo(insn, value_pseudo(1));
 
 	case OP_AND:
diff --git a/validation/tautological-compare.c b/validation/tautological-compare.c
new file mode 100644
index 00000000..55a2b463
--- /dev/null
+++ b/validation/tautological-compare.c
@@ -0,0 +1,35 @@
+typedef unsigned int u32;
+
+int seq(int a) { return a == a; }
+int sne(int a) { return a != a; }
+int slt(int a) { return a < a; }
+int sgt(int a) { return a > a; }
+int sle(int a) { return a <= a; }
+int sge(int a) { return a >= a; }
+
+u32 ueq(u32 a) { return a == a; }
+u32 une(u32 a) { return a != a; }
+u32 ult(u32 a) { return a < a; }
+u32 ugt(u32 a) { return a > a; }
+u32 ule(u32 a) { return a <= a; }
+u32 uge(u32 a) { return a >= a; }
+
+/*
+ * check-name: tautological-compare
+ * check-command: sparse -Wno-decl -Wtautological-compare $file
+ *
+ * check-error-start
+tautological-compare.c:3:30: warning: self-comparison always evaluates to true
+tautological-compare.c:4:30: warning: self-comparison always evaluates to false
+tautological-compare.c:5:29: warning: self-comparison always evaluates to false
+tautological-compare.c:6:29: warning: self-comparison always evaluates to false
+tautological-compare.c:7:30: warning: self-comparison always evaluates to true
+tautological-compare.c:8:30: warning: self-comparison always evaluates to true
+tautological-compare.c:10:30: warning: self-comparison always evaluates to true
+tautological-compare.c:11:30: warning: self-comparison always evaluates to false
+tautological-compare.c:12:29: warning: self-comparison always evaluates to false
+tautological-compare.c:13:29: warning: self-comparison always evaluates to false
+tautological-compare.c:14:30: warning: self-comparison always evaluates to true
+tautological-compare.c:15:30: warning: self-comparison always evaluates to true
+ * check-error-end
+ */
-- 
2.10.2

