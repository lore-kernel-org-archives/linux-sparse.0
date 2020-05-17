From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] attribute: add helper apply_mod() and use it
Date: Mon, 18 May 2020 01:31:18 +0200
Message-ID: <20200517233122.1872-3-luc.vanoostenryck@gmail.com>
References: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXb3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:31:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A2C061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so7498236wmj.3
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:29 -0700 (PDT)
In-Reply-To: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

to avoid duplicated code checking for ... duplicated modifiers!

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/parse.c b/parse.c
index a29c67c8cf41..974ff7a1961c 100644
--- a/parse.c
+++ b/parse.c
@@ -1127,11 +1127,16 @@ static struct token *attribute_aligned(struct token *token, struct symbol *attr,
 	return token;
 }
 
+static void apply_mod(struct position *pos, unsigned long *mods, unsigned long mod)
+{
+	if (*mods & mod)
+		warning(*pos, "duplicate %s", modifier_string(mod));
+	*mods |= mod;
+}
+
 static void apply_qualifier(struct position *pos, struct ctype *ctx, unsigned long qual)
 {
-	if (ctx->modifiers & qual)
-		warning(*pos, "duplicate %s", modifier_string(qual));
-	ctx->modifiers |= qual;
+	apply_mod(pos, &ctx->modifiers, qual);
 }
 
 static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct decl_state *ctx)
@@ -1142,10 +1147,7 @@ static struct token *attribute_modifier(struct token *token, struct symbol *attr
 
 static struct token *attribute_function(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	unsigned long mod = attr->ctype.modifiers;
-	if (ctx->f_modifiers & mod)
-		warning(token->pos, "duplicate %s", modifier_string(mod));
-	ctx->f_modifiers |= mod;
+	apply_mod(&token->pos, &ctx->f_modifiers, attr->ctype.modifiers);
 	return token;
 }
 
-- 
2.26.2
