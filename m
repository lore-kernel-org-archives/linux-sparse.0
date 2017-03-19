From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 01/30] fix usage of inlined calls
Date: Sun, 19 Mar 2017 02:41:58 +0100
Message-ID: <20170319014227.8833-2-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34466 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdCSBmk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so8889931wmg.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:38 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_INLINED_CALL are there only as a sort of annotation
for debugging purpose. It is thus wrong to associate
pseudo's usage to them (even if the pseudo are the arguments
of the function now inlined).

Fix this by removing the use_pseudo() for each arguments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c               |  2 +-
 validation/call-inlined.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 validation/call-inlined.c

diff --git a/linearize.c b/linearize.c
index 5199b6b02..5337723e2 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1680,7 +1680,7 @@ static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *
 		concat_symbol_list(args->declaration, &ep->syms);
 		FOR_EACH_PTR(args->declaration, sym) {
 			pseudo_t value = linearize_one_symbol(ep, sym);
-			use_pseudo(insn, value, add_pseudo(&insn->arguments, value));
+			add_pseudo(&insn->arguments, value);
 		} END_FOR_EACH_PTR(sym);
 	}
 
diff --git a/validation/call-inlined.c b/validation/call-inlined.c
new file mode 100644
index 000000000..6fd94edcb
--- /dev/null
+++ b/validation/call-inlined.c
@@ -0,0 +1,58 @@
+static const char messg[] = "def";
+
+static inline int add(int a, int b)
+{
+	return a + b;
+}
+
+int  foo(int a, int b) { return add(a + b, 1); }
+void bar(int a, int b) {        add(a + b, 1); }
+
+
+static inline const char *lstrip(const char *str)
+{
+	return str + 1;
+}
+
+const char *bas(void) { return lstrip("abc"); }
+const char *qus(void) { return lstrip(messg); }
+
+/*
+ * check-name: call-inlined
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	add.32      %r3 <- %arg1, %arg2
+	add.32      %r5 <- %r3, $1
+	# call      %r5 <- add, %r3, $1
+	ret.32      %r5
+
+
+bar:
+.L3:
+	<entry-point>
+	# call      %r12 <- add, %r10, $1
+	ret
+
+
+bas:
+.L6:
+	<entry-point>
+	add.64      %r16 <- "abc", $1
+	# call      %r16 <- lstrip, %r14
+	ret.64      %r16
+
+
+qus:
+.L9:
+	<entry-point>
+	add.64      %r21 <- messg, $1
+	# call      %r21 <- lstrip, %r19
+	ret.64      %r21
+
+
+ * check-output-end
+ */
-- 
2.12.0

