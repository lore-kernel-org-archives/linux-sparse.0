From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cpp: sanitize redefining a macro during its own expansion
Date: Thu, 12 Mar 2020 21:30:52 +0100
Message-ID: <20200312203052.52764-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgCLUc6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Mar 2020 16:32:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id l18so9198738wru.11
        for <linux-sparse@vger.kernel.org>; Thu, 12 Mar 2020 13:32:56 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Oleg Nesterov <oleg@redhat.com>

The presence of preprocessor directives within the arguments
of a macro invocation is Undefined Behaviour. Some of these
directives, like the conditionals, are harmless.

OTOH, the redefinition of a macro during its own expansion
is really nasty. However, it can be given a reasonable meaning:
* use the initial definition for the macro body
* use the new defintion for its arguments, in text order.
It's what gcc & clang do. But Sparse can't handle this
because during the expansion, a reference to the initial
macro's body is not kept. What is used instead is the
'body currently associated with the macro'.

Fix this by always using the body associated with the
macro at the time of its invocation.

Testcase-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c                          |  4 ++--
 validation/preprocessor/expand-redef.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 validation/preprocessor/expand-redef.c

diff --git a/pre-process.c b/pre-process.c
index 2893c3ab65d4..6670fb0cd557 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -756,7 +756,7 @@ static int expand(struct token **list, struct symbol *sym)
 	struct token *last;
 	struct token *token = *list;
 	struct ident *expanding = token->ident;
-	struct token **tail;
+	struct token **tail, *expansion = sym->expansion;
 	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
 	struct arg args[nargs];
 
@@ -776,7 +776,7 @@ static int expand(struct token **list, struct symbol *sym)
 	expanding->tainted = 1;
 
 	last = token->next;
-	tail = substitute(list, sym->expansion, args);
+	tail = substitute(list, expansion, args);
 	/*
 	 * Note that it won't be eof - at least TOKEN_UNTAINT will be there.
 	 * We still can lose the newline flag if the sucker expands to nothing,
diff --git a/validation/preprocessor/expand-redef.c b/validation/preprocessor/expand-redef.c
new file mode 100644
index 000000000000..4ca13e661fa4
--- /dev/null
+++ b/validation/preprocessor/expand-redef.c
@@ -0,0 +1,15 @@
+#define f(x) x x
+f(1
+#undef  f
+#define f 2
+  f)
+
+/*
+ * check-name: expand-redef
+ * check-command: sparse -E -Wno-directive-within-macro $file
+ *
+ * check-output-start
+
+1 2 1 2
+ * check-output-end
+ */
-- 
2.25.1
