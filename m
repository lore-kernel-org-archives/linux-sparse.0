From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] make -Wbitwise operational again
Date: Sat, 18 Feb 2017 22:14:03 +0100
Message-ID: <20170218211403.39019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34034 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbdBRVQR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Feb 2017 16:16:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so8156593wmi.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Feb 2017 13:16:14 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Edward Cree <ecree@solarflare.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The flag -Wbitwise have no effect since patch 02a886bfa
("Introduce keyword driven attribute parsing"): the corresponding
checks are now always done.

Fix that by reintroducing it in the same way as it was:
ignore the bitwise attribute if the flag is not set.
It's less invasive that checking the flag at each place
an corresponding warning is emitted.
Also, to not perturb the current situation the flag is now
enabled by default.

Reported-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c   |  2 +-
 parse.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index d47325243..cce027c96 100644
--- a/lib.c
+++ b/lib.c
@@ -216,7 +216,7 @@ static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
 
 int Waddress_space = 1;
-int Wbitwise = 0;
+int Wbitwise = 1;
 int Wcast_to_as = 0;
 int Wcast_truncate = 1;
 int Wcontext = 1;
diff --git a/parse.c b/parse.c
index a4a126720..d07b27a21 100644
--- a/parse.c
+++ b/parse.c
@@ -79,6 +79,7 @@ typedef struct token *attr_t(struct token *, struct symbol *,
 
 static attr_t
 	attribute_packed, attribute_aligned, attribute_modifier,
+	attribute_bitwise,
 	attribute_address_space, attribute_context,
 	attribute_designated_init,
 	attribute_transparent_union, ignore_attribute,
@@ -339,6 +340,10 @@ static struct symbol_op attr_mod_op = {
 	.attribute = attribute_modifier,
 };
 
+static struct symbol_op attr_bitwise_op = {
+	.attribute = attribute_bitwise,
+};
+
 static struct symbol_op attr_force_op = {
 	.attribute = attribute_force,
 };
@@ -496,8 +501,8 @@ static struct init_keyword {
 	{ "noderef",	NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
 	{ "safe",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
 	{ "force",	NS_KEYWORD,	.op = &attr_force_op },
-	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_mod_op },
-	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_mod_op },
+	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
+	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
@@ -1105,6 +1110,13 @@ static struct token *attribute_modifier(struct token *token, struct symbol *attr
 	return token;
 }
 
+static struct token *attribute_bitwise(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	if (Wbitwise)
+		attribute_modifier(token, attr, ctx);
+	return token;
+}
+
 static struct token *attribute_address_space(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	struct expression *expr = NULL;
-- 
2.11.0

