Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF5AC433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048C0206C3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgFYTZ9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHIUxm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgHIUxk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4EC061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:40 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so7416164ejr.1
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQ4lDodNnHvQamP4THPhArr1n2hoR2fxntoVvLwErww=;
        b=kgFYTZ9biJ4GkjdJkCEaN+ZERoIT8A9ueZHUvOP6ohhSFvaMLTxO2cLhjsm9K21bB8
         s2uApn5DWAdlCfm9euucAnHvQ+7dqzAP8Vm3lTOlNEom+lxDzgq8Qh9EfWWr6W7OSA4b
         QEsQ366cQWRymb8nbLKebQtxIIWI7PeLUNcLnrm+nLBHLEWEFh6R25lTFGzKrqmlQi6k
         C3xiK5y4Smdzcw0Frmaz689MNmhMDyvmzgDS21kIbVvyGv6Czjxunyny3WeYqufJypcv
         QwXFfoLEm4yXYuGdNkaYTlaBhW8EB0haaAhygBX9WN1B+ANrIVbGx/9CYDxt/tKBNXpR
         aSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQ4lDodNnHvQamP4THPhArr1n2hoR2fxntoVvLwErww=;
        b=dibarkvV7HD3fsnDnsKvi2YBQynwmJi3vrct9hZnjzksWwIPBlsjPuzuxcogfUOrLc
         F6wBOe8tmV4VAU3lON17n5fuWo1y1uGVcWNJAkmrIzQT2IT+HjpxJCVh1iL4lF7yn7wg
         //5iVNL5QcKh+g98etSrWUB4aaNACI5j6e/j+XNsNEdK7JOb11TdbXfNaBWrk2sCLsuS
         67e1nrnTm/ZXjuCWFp9n28n4TcIKuXj+tve61h7xFrpNE7hDf9CDlD1hWX0895UQu1J+
         6G+WIi8CjxD5MAbQaoZFda472EcVGbjXgdhfrXhM43h7zPGnbergQ6okEuZkz173HTVH
         V4YA==
X-Gm-Message-State: AOAM532V5NL9vTmoPHqbR+E/9GDa2BK5rzVfHQyy58VDMTc45N6KZKfX
        HPijTQQWBiCo4gTdGuW96rSFykTf
X-Google-Smtp-Source: ABdhPJzbMMq1nBB1syEbtUwO4a8l4XmIEH1jnfNGo1CbakBlIBixGcBOWeVtmTzeKwiauaZgpOnIRg==
X-Received: by 2002:a17:906:a3d9:: with SMTP id ca25mr19234268ejb.164.1597006418883;
        Sun, 09 Aug 2020 13:53:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/10] attribute: factorize matching of '__attribute__'
Date:   Sun,  9 Aug 2020 22:53:25 +0200
Message-Id: <20200809205329.42811-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Matching the keyword '__attribute__' (or '__attribute') needs
several tests and this matching is needed to handle attributes
or to skip them.

So, create an helper, match_attribute(), and use it in the loops
to handle and to skip attributes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/parse.c b/parse.c
index 14b1746d38c5..681d98e49641 100644
--- a/parse.c
+++ b/parse.c
@@ -1761,6 +1761,20 @@ static struct token *handle_asm_name(struct token *token, struct decl_state *ctx
 	return token;
 }
 
+///
+// test if @token is '__attribute__' (or one of its variant)
+static bool match_attribute(struct token *token)
+{
+	struct symbol *sym;
+
+	if (token_type(token) != TOKEN_IDENT)
+		return false;
+	sym = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
+	if (!sym || sym->type != SYM_KEYWORD)
+		return false;
+	return sym->op->type & KW_ATTRIBUTE;
+}
+
 static struct token *skip_attribute(struct token *token)
 {
 	token = token->next;
@@ -1782,15 +1796,7 @@ static struct token *skip_attribute(struct token *token)
 
 static struct token *skip_attributes(struct token *token)
 {
-	struct symbol *keyword;
-	for (;;) {
-		if (token_type(token) != TOKEN_IDENT)
-			break;
-		keyword = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
-		if (!keyword || keyword->type != SYM_KEYWORD)
-			break;
-		if (!(keyword->op->type & KW_ATTRIBUTE))
-			break;
+	while (match_attribute(token)) {
 		token = expect(token->next, '(', "after attribute");
 		token = expect(token, '(', "after attribute");
 		while (token_type(token) == TOKEN_IDENT) {
@@ -1807,17 +1813,8 @@ static struct token *skip_attributes(struct token *token)
 
 static struct token *handle_attributes(struct token *token, struct decl_state *ctx)
 {
-	struct symbol *keyword;
-	for (;;) {
-		if (token_type(token) != TOKEN_IDENT)
-			break;
-		keyword = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
-		if (!keyword || keyword->type != SYM_KEYWORD)
-			break;
-		if (!(keyword->op->type & KW_ATTRIBUTE))
-			break;
+	while (match_attribute(token))
 		token = attribute_specifier(token->next, ctx);
-	}
 	return token;
 }
 
-- 
2.28.0

