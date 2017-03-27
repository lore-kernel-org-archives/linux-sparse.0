From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 07/15] fix usage of inlined calls
Date: Mon, 27 Mar 2017 19:33:57 +0200
Message-ID: <20170327173405.11405-8-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34630 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdC0RhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id w43so12462687wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:20 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index 7dccf21d8..4ac570fc0 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1683,7 +1683,7 @@ static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *
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

