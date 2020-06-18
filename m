From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] pre-process: add support for __has_feature() & __has_extension()
Date: Thu, 18 Jun 2020 22:47:15 +0200
Message-ID: <20200618204716.3896-5-luc.vanoostenryck@gmail.com>
References: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgFRUtj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Jun 2020 16:49:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BA6C0613EE
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so7898424ejd.0
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:39 -0700 (PDT)
In-Reply-To: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add the trivial methods for the expansion of these macros with:
c_alignas, c_alignof, c_generic_selections and c_static_assert.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h                          |  4 ++
 pre-process.c                         | 54 +++++++++++++++++++++++++++
 validation/preprocessor/has-feature.c |  1 -
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/ident-list.h b/ident-list.h
index 75740b9d9f77..a3a282587c67 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -61,6 +61,10 @@ IDENT(defined);
 IDENT(once);
 IDENT(__has_attribute);
 IDENT(__has_builtin);
+IDENT(c_alignas);
+IDENT(c_alignof);
+IDENT(c_generic_selections);
+IDENT(c_static_assert);
 __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
 __IDENT(__func___ident, "__func__", 0);
diff --git a/pre-process.c b/pre-process.c
index d2e13400711e..7a39b1715f31 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -2003,6 +2003,58 @@ static int handle_nondirective(struct stream *stream, struct token **line, struc
 	return 1;
 }
 
+static bool expand_has_extension(struct token *token, struct arg *args)
+{
+	struct token *arg = args[0].expanded;
+	struct ident *ident;
+	bool val = false;
+
+	if (token_type(arg) != TOKEN_IDENT) {
+		sparse_error(arg->pos, "identifier expected");
+		return false;
+	}
+
+	ident = arg->ident;
+	if (ident == &c_alignas_ident)
+		val = true;
+	else if (ident == &c_alignof_ident)
+		val = true;
+	else if (ident == &c_generic_selections_ident)
+		val = true;
+	else if (ident == &c_static_assert_ident)
+		val = true;
+
+	replace_with_bool(token, val);
+	return 1;
+}
+
+static bool expand_has_feature(struct token *token, struct arg *args)
+{
+	struct token *arg = args[0].expanded;
+	struct ident *ident;
+	bool val = false;
+
+	if (token_type(arg) != TOKEN_IDENT) {
+		sparse_error(arg->pos, "identifier expected");
+		return false;
+	}
+
+	ident = arg->ident;
+	if (standard >= STANDARD_C11) {
+		if (ident == &c_alignas_ident)
+			val = true;
+		else if (ident == &c_alignof_ident)
+			val = true;
+		else if (ident == &c_generic_selections_ident)
+			val = true;
+		else if (ident == &c_static_assert_ident)
+			val = true;
+	}
+
+	replace_with_bool(token, val);
+	return 1;
+}
+
 static void create_arglist(struct symbol *sym, int count)
 {
 	struct token *token;
@@ -2081,6 +2133,8 @@ static void init_preprocessor(void)
 		{ "__TIME__",		expand_time },
 		{ "__COUNTER__",	expand_counter },
 		{ "__INCLUDE_LEVEL__",	expand_include_level },
+		{ "__has_extension",	NULL, expand_has_extension },
+		{ "__has_feature",	NULL, expand_has_feature },
 	};
 
 	for (i = 0; i < ARRAY_SIZE(normal); i++) {
diff --git a/validation/preprocessor/has-feature.c b/validation/preprocessor/has-feature.c
index 3ab7c3e039fa..e0f2e7f63cda 100644
--- a/validation/preprocessor/has-feature.c
+++ b/validation/preprocessor/has-feature.c
@@ -12,7 +12,6 @@ __has_feature()??? Quesako?
 /*
  * check-name: has-feature
  * check-command: sparse -E $file
- * check-known-to-fail
  *
  * check-output-start
 
-- 
2.27.0
