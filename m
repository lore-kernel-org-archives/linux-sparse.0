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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC5C433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37429206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svv9MBco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHIQw5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgHIQwx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:53 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6CC06178B
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so7092818ejc.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3jGEjYlLuoC5oiPPhhzdoh4+6E8yvDmRVYxKL7tI38=;
        b=svv9MBco5UadjVc/mtw8iPfM901QVbWIEORr1uv8YJMRvt6oWg3jKuhn0zFWIrDE4k
         ofk4K2lLlyst6EAC64xlG9+2LFdzLhgMl4/tshvm4TzPhVmxsnIPl0aP57CnItwFEGuq
         pLj72+WXfJS+xcdy12D+KzzBJmVQYy8cEguJfu6h4y1FFoYSOX6VWr8uuK7nSHcvNEa3
         GJYQFdQ3Q0VaYdVw/OSpN+K3das1kJtnf1Jx66Ua+yQKAj5EbnbSyvxNvg8GNie5KiFT
         ZKmYnNnFvfdcYLsA2nhM4pwMcxh+NCa7ugPuROEeaxLHIzyZ3ofRYhUFaTPOW+wVw4fQ
         2xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3jGEjYlLuoC5oiPPhhzdoh4+6E8yvDmRVYxKL7tI38=;
        b=FyoJTKHw8zl0b+DiNteH0guSR8SjpKEnzAJ2VvC9buI1fVEFZJPxOzVXVdnvFMNNX3
         GSPs8CDNlutwmcLQ2liBR6pmAFVBZx+PzNw7YHeYbAhvBEpnffiWBZBCzEDZbUcrjn8q
         O8kAng10sphkfrwQDd8m7Z0wWPa/UygTsbDJimm7aSB1G7FkjgTuI/5iC2RnBspx+vdb
         1vwQHNxtt9lmGFGruZsigmTYJMrWHTLqwcp3Dyk4uY2f8XOeElMaevUkt/A4gKMnwmc7
         VMtehE7qNdBqHIvikMbtaEBh74ywvPKJMq8cNIEOTooV+K/NZKSRT2cH0l+KYpgDCp8u
         6BkA==
X-Gm-Message-State: AOAM532ovCrEFVcCbDkla3t8QXJbZ7iTEMDyoHjpUKlNwNJdPUdLP3XX
        bKBnuWPPf63r9Dkk7KDQXUGjWuqF
X-Google-Smtp-Source: ABdhPJyn+csvg69E/9bIpdpZC1cR1cgm7ryVz4YU1Mg1NsXdZwr2XSPsZCZxApBuSwjeU66yK3gOXQ==
X-Received: by 2002:a17:906:c002:: with SMTP id e2mr19102061ejz.244.1596991961286;
        Sun, 09 Aug 2020 09:52:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] parse: let asm_modifier() use the keyword modifier
Date:   Sun,  9 Aug 2020 18:52:27 +0200
Message-Id: <20200809165229.36677-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that 'MOD_INLINE' & 'MOD_VOLATILE' are associated with their
corresponding keyword, a single asm_modifier() method can cover
both cases.

So, replace asm_modifier_inline() & asm_modifier_volatile() by
a single, generic version: asm_modifier().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 16 +++-------------
 symbol.h |  2 +-
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/parse.c b/parse.c
index 37fe90c016fe..fad41d36dda6 100644
--- a/parse.c
+++ b/parse.c
@@ -120,16 +120,6 @@ static void asm_modifier(struct token *token, unsigned long *mods, unsigned long
 	*mods |= mod;
 }
 
-static void asm_modifier_volatile(struct token *token, unsigned long *mods)
-{
-	asm_modifier(token, mods, MOD_VOLATILE);
-}
-
-static void asm_modifier_inline(struct token *token, unsigned long *mods)
-{
-	asm_modifier(token, mods, MOD_INLINE);
-}
-
 static struct symbol_op typedef_op = {
 	.type = KW_MODIFIER,
 	.declarator = storage_specifier,
@@ -138,7 +128,7 @@ static struct symbol_op typedef_op = {
 static struct symbol_op inline_op = {
 	.type = KW_MODIFIER,
 	.declarator = generic_qualifier,
-	.asm_modifier = asm_modifier_inline,
+	.asm_modifier = asm_modifier,
 };
 
 static struct symbol_op noreturn_op = {
@@ -185,7 +175,7 @@ static struct symbol_op const_op = {
 static struct symbol_op volatile_op = {
 	.type = KW_QUALIFIER,
 	.declarator = generic_qualifier,
-	.asm_modifier = asm_modifier_volatile,
+	.asm_modifier = asm_modifier,
 };
 
 static struct symbol_op restrict_op = {
@@ -2076,7 +2066,7 @@ static struct token *parse_asm_statement(struct token *token, struct statement *
 	while (token_type(token) == TOKEN_IDENT) {
 		struct symbol *s = lookup_keyword(token->ident, NS_TYPEDEF);
 		if (s && s->op  && s->op->asm_modifier)
-			s->op->asm_modifier(token, &mods);
+			s->op->asm_modifier(token, &mods, s->ctype.modifiers);
 		else if (token->ident == &goto_ident)
 			asm_modifier(token, &mods, MOD_ASM_GOTO);
 		token = token->next;
diff --git a/symbol.h b/symbol.h
index 657a6e0fb354..4f9dd7417cc3 100644
--- a/symbol.h
+++ b/symbol.h
@@ -131,7 +131,7 @@ struct symbol_op {
 	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
 	struct token *(*attribute)(struct token *token, struct symbol *attr, struct decl_state *ctx);
 	struct symbol *(*to_mode)(struct symbol *);
-	void          (*asm_modifier)(struct token *token, unsigned long *mods);
+	void (*asm_modifier)(struct token *token, unsigned long *mods, unsigned long mod);
 
 	int test, set, class;
 };
-- 
2.28.0

