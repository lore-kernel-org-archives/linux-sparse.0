From: Alberto Bertogli <albertito@blitiri.com.ar>
Subject: [PATCH] Support the __thread storage class
Date: Sun, 26 Apr 2009 21:44:56 -0300
Message-ID: <1240793096-23090-1-git-send-email-albertito@blitiri.com.ar>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alerce.vps.bitfolk.com ([212.13.194.134]:1238 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbZD0B1k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 26 Apr 2009 21:27:40 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, josh@kernel.org, Alberto Bertogli <albertito@blitiri.com.ar>

GCC supports a __thread storage class, used to indicate thread-local
storage. It may be used alone, or with extern or static.

This patch makes sparse aware of it, but ignores it completely.

Signed-off-by: Alberto Bertogli <albertito@blitiri.com.ar>
---
 parse.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index 14ae25d..e49cb39 100644
--- a/parse.c
+++ b/parse.c
@@ -41,7 +41,7 @@ static declarator_t
 	attribute_specifier, typeof_specifier, parse_asm_declarator,
 	typedef_specifier, inline_specifier, auto_specifier,
 	register_specifier, static_specifier, extern_specifier,
-	const_qualifier, volatile_qualifier;
+	thread_specifier, const_qualifier, volatile_qualifier;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -125,6 +125,11 @@ static struct symbol_op extern_op = {
 	.declarator = extern_specifier,
 };
 
+static struct symbol_op thread_op = {
+	.type = KW_MODIFIER,
+	.declarator = thread_specifier,
+};
+
 static struct symbol_op const_op = {
 	.type = KW_QUALIFIER,
 	.declarator = const_qualifier,
@@ -407,6 +412,7 @@ static struct init_keyword {
 	{ "register",	NS_TYPEDEF, .op = &register_op },
 	{ "static",	NS_TYPEDEF, .op = &static_op },
 	{ "extern",	NS_TYPEDEF, .op = &extern_op },
+	{ "__thread",	NS_TYPEDEF, .op = &thread_op },
 
 	/* Statement */
 	{ "if",		NS_KEYWORD, .op = &if_op },
@@ -1210,6 +1216,12 @@ static struct token *extern_specifier(struct token *next, struct decl_state *ctx
 	return next;
 }
 
+static struct token *thread_specifier(struct token *next, struct decl_state *ctx)
+{
+	/* Ignore __thread */
+	return next;
+}
+
 static struct token *attribute_force(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	set_storage_class(&token->pos, ctx, SForced);
-- 
1.6.2.2.646.gb214

