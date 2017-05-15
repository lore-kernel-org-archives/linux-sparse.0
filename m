From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix missing reload
Date: Mon, 15 May 2017 17:52:16 +0200
Message-ID: <20170515155216.23400-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36033 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755171AbdEOPyW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 May 2017 11:54:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id y128so17926877qka.3
        for <linux-sparse@vger.kernel.org>; Mon, 15 May 2017 08:54:22 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In dominates() there is the following comment:
  "We don't think two explicitly different symbols ever alias"
but the corresponding test only check if the storage in the
potentialy dominating instruction is a symbol and if so returns 0
meaning that it can't dominate.

But that's without taking in account that a pointer can point
to this symbol and thus that a store via this symbol can dominate
a store via a pointer.

Fix this by changing the test more in accordance to the comment:
return 0 only if the 2 concerned location correspond to 2 *distinct*
symbols (and thus do not return 0 if one of the location is not a symbol).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                      | 11 ++++++++++-
 validation/alias-distinct.c | 17 +++++++++++++++++
 validation/alias-mixed.c    | 30 ++++++++++++++++++++++++++++++
 validation/alias-same.c     | 17 +++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 validation/alias-distinct.c
 create mode 100644 validation/alias-mixed.c
 create mode 100644 validation/alias-same.c

diff --git a/flow.c b/flow.c
index 94a8ec746..4b32f5cc8 100644
--- a/flow.c
+++ b/flow.c
@@ -314,6 +314,15 @@ static inline int same_memop(struct instruction *a, struct instruction *b)
 	return	a->offset == b->offset && a->size == b->size;
 }
 
+static inline int distinct_symbols(pseudo_t a, pseudo_t b)
+{
+	if (a->type != PSEUDO_SYM)
+		return 0;
+	if (b->type != PSEUDO_SYM)
+		return 0;
+	return a->sym != b->sym;
+}
+
 /*
  * Return 1 if "dom" dominates the access to "pseudo"
  * in "insn".
@@ -332,7 +341,7 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 		if (local)
 			return 0;
 		/* We don't think two explicitly different symbols ever alias */
-		if (dom->src->type == PSEUDO_SYM)
+		if (distinct_symbols(insn->src, dom->src))
 			return 0;
 		/* We could try to do some alias analysis here */
 		return -1;
diff --git a/validation/alias-distinct.c b/validation/alias-distinct.c
new file mode 100644
index 000000000..42937b24b
--- /dev/null
+++ b/validation/alias-distinct.c
@@ -0,0 +1,17 @@
+extern int g;
+extern int h;
+
+static int foo(void)
+{
+	g = 1;
+	h = 2;
+	return g == 1;
+}
+
+/*
+ * check-name: alias distinct symbols
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-contains: ret\\..* *\\$1
+ */
diff --git a/validation/alias-mixed.c b/validation/alias-mixed.c
new file mode 100644
index 000000000..429304774
--- /dev/null
+++ b/validation/alias-mixed.c
@@ -0,0 +1,30 @@
+extern int g;
+
+
+static int foo(int *p)
+{
+	*p = 1;
+	g = 2;
+	return *p == 1;
+}
+
+static int bar(int *p)
+{
+	g = 1;
+	*p = 2;
+	return g == 1;
+}
+
+static test(void)
+{
+	foo(&g);
+	bar(&g);
+}
+
+/*
+ * check-name: alias symbol/pointer
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: ret\\..* *\\$1
+ */
diff --git a/validation/alias-same.c b/validation/alias-same.c
new file mode 100644
index 000000000..55cf42445
--- /dev/null
+++ b/validation/alias-same.c
@@ -0,0 +1,17 @@
+extern int g;
+
+
+static int foo(void)
+{
+	g = 1;
+	g = 2;
+	return g != 1;
+}
+
+/*
+ * check-name: alias same symbols
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-contains: ret\\..* *\\$1
+ */
-- 
2.12.2

