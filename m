From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] pre-process: rename 'expander' into 'expand_simple'
Date: Thu, 18 Jun 2020 22:47:13 +0200
Message-ID: <20200618204716.3896-3-luc.vanoostenryck@gmail.com>
References: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFRUth (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Jun 2020 16:49:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FEFC0613EE
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so7866568ejj.5
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:36 -0700 (PDT)
In-Reply-To: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse support the expansion of one-symbol-builtin macros like
__FILE__ or the pre-processor operator 'defined'. It also supports the
expansion of builtin macros with arguments, like __has_attribute()
but only inside a pre-processor conditional expression.

In preparation of adding the general expansion of these macros,
rename the method 'expander' into 'expand_simple'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c | 8 ++++----
 symbol.h      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index e6becf233eba..059a7c1d9b7b 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -229,8 +229,8 @@ static int expand_one_symbol(struct token **list)
 	sym = lookup_macro(token->ident);
 	if (!sym)
 		return 1;
-	if (sym->expander) {
-		sym->expander(token);
+	if (sym->expand_simple) {
+		sym->expand_simple(token);
 		return 1;
 	} else {
 		int rc;
@@ -2040,7 +2040,7 @@ static void init_preprocessor(void)
 	};
 	static struct {
 		const char *name;
-		void (*expander)(struct token *);
+		void (*expand_simple)(struct token *);
 	} dynamic[] = {
 		{ "__LINE__",		expand_line },
 		{ "__FILE__",		expand_file },
@@ -2066,7 +2066,7 @@ static void init_preprocessor(void)
 	for (i = 0; i < ARRAY_SIZE(dynamic); i++) {
 		struct symbol *sym;
 		sym = create_symbol(stream, dynamic[i].name, SYM_NODE, NS_MACRO);
-		sym->expander = dynamic[i].expander;
+		sym->expand_simple = dynamic[i].expand_simple;
 	}
 
 	counter_macro = 0;
diff --git a/symbol.h b/symbol.h
index a16a27c24afe..6b483101548a 100644
--- a/symbol.h
+++ b/symbol.h
@@ -160,7 +160,7 @@ struct symbol {
 			struct token *expansion;
 			struct token *arglist;
 			struct scope *used_in;
-			void (*expander)(struct token *);
+			void (*expand_simple)(struct token *);
 		};
 		struct /* NS_PREPROCESSOR */ {
 			int (*handler)(struct stream *, struct token **, struct token *);
-- 
2.27.0
