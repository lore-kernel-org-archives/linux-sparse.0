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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44914C433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2E2206D8
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADLe2Ph6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHIUxi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHIUxi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF352C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so7420669ejc.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sROBVrf/B4od4o0cJu0K2fHnIqYEHEOYftCZZrRpOCM=;
        b=ADLe2Ph6E8vGhd8DBKtwRnx9522XXioxEMuFk6rdF5JXkyGxzBFM8tI7OneLZBxrk5
         H2WcsYxOef9ZpdZt878QUYtdJOydmQWA2XDIntSqmAOUrTHhXuclg9YPpfyqkUR2Xhn4
         GOifOEWFGYMfhpGjPjnNV37ZBtqAZQmgIMh2aaSp3oTT7P6MKe1Zy6BeEdVU4EQSin5j
         oeS9cJ2XyTFqhXEGOBKM3vnogabjDSFy4g4MEp4sfGezqWqIUcqYt+zmyhPIrXgMDOcQ
         Egvq/2fkfuSxnKqIvpCPKgUqU0YmRL2uF5FTToaLs8eUmOjuvyiKcZjWpdQ4DsTRod8O
         bkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sROBVrf/B4od4o0cJu0K2fHnIqYEHEOYftCZZrRpOCM=;
        b=rVwEmDLrICe1KodhYIpD954zaNXx5xmiQW/xHWnBMsMcJ9DKkjhYfcpbr5ruVmBl5Y
         hgMa0OFgaXNzO+Xf+A0KIBKzQWH7GzdbHxKyyWG+Zu3xsh4gazKU7NniXHpKJgo+Wb3Q
         +vTw2/QWZrhBj0e2zOOApjETe8ILxtuWnp2JsOew2PzlqZZ+6pOoN5jEBct4DSiViNsr
         PZb6nNz0bESoSDGVFnnbdxFtSiMKs4qMUUFIPSvLynbOh4daKryWIiJQmKqH7ElW75mW
         3oahUSx2DUs549urf+uvll2cz9hYcfs27rkHB8YF2DfsNVUBPntG2nx4sm0Z5SquGwed
         rHNA==
X-Gm-Message-State: AOAM531BwdK2iaYBnyGHb7tliBUEn8kjP1xDA8uT50gvlcD8g9RTJdrZ
        d3u9iThG5PUhNMP+BZPIskQe9JQw
X-Google-Smtp-Source: ABdhPJy3B/lp+r97ehwNl94i5YRQk95A7rsxaIIIOTv3mFT8jr1755Fm5zdfk9JN3pOs0KGXMh11EA==
X-Received: by 2002:a17:906:cb0a:: with SMTP id lk10mr2899335ejb.209.1597006416262;
        Sun, 09 Aug 2020 13:53:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/10] attribute: fold parse_asm_declarator() into handle_asm_name()
Date:   Sun,  9 Aug 2020 22:53:22 +0200
Message-Id: <20200809205329.42811-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

An asm name is not really a declarator, it must only be placed
*after* a declarator and is directly handled by handle_asm_name().
It's thus not needed and possibly confusing to treat it like a
generic declarator.

So, fold parse_asm_declarator() into handle_asm_name() and remove it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/parse.c b/parse.c
index cf897e5d2804..73ec579cfa7f 100644
--- a/parse.c
+++ b/parse.c
@@ -54,7 +54,7 @@ static struct token *handle_attributes(struct token *token, struct decl_state *c
 typedef struct token *declarator_t(struct token *, struct decl_state *);
 static declarator_t
 	struct_specifier, union_specifier, enum_specifier,
-	attribute_specifier, typeof_specifier, parse_asm_declarator,
+	attribute_specifier, typeof_specifier,
 	typedef_specifier, inline_specifier, auto_specifier,
 	register_specifier, static_specifier, extern_specifier,
 	thread_specifier, const_qualifier, volatile_qualifier;
@@ -363,7 +363,6 @@ static struct symbol_op range_op = {
 
 static struct symbol_op asm_op = {
 	.type = KW_ASM,
-	.declarator = parse_asm_declarator,
 	.statement = parse_asm_statement,
 	.toplevel = toplevel_asm_declaration,
 };
@@ -1744,6 +1743,7 @@ static struct token *declarator(struct token *token, struct decl_state *ctx);
 
 static struct token *handle_asm_name(struct token *token, struct decl_state *ctx)
 {
+	struct expression *expr;
 	struct symbol *keyword;
 
 	if (token_type(token) != TOKEN_IDENT)
@@ -1753,7 +1753,12 @@ static struct token *handle_asm_name(struct token *token, struct decl_state *ctx
 		return token;
 	if (!(keyword->op->type & KW_ASM))
 		return token;
-	return keyword->op->declarator(token->next, ctx);
+
+	token = token->next;
+	token = expect(token, '(', "after asm");
+	token = string_expression(token, &expr, "asm name");
+	token = expect(token, ')', "after asm");
+	return token;
 }
 
 static struct token *skip_attribute(struct token *token)
@@ -2181,15 +2186,6 @@ static struct token *parse_asm_statement(struct token *token, struct statement *
 	return expect(token, ';', "at end of asm-statement");
 }
 
-static struct token *parse_asm_declarator(struct token *token, struct decl_state *ctx)
-{
-	struct expression *expr;
-	token = expect(token, '(', "after asm");
-	token = string_expression(token, &expr, "inline asm");
-	token = expect(token, ')', "after asm");
-	return token;
-}
-
 static struct token *parse_static_assert(struct token *token, struct symbol_list **unused)
 {
 	struct expression *cond = NULL, *message = NULL;
-- 
2.28.0

