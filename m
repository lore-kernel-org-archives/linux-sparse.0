Return-Path: <SRS0=/orK=BC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2614C433E4
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8645220792
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na4d6EvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgGWXqw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgGWXqv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7365C0619E3
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so5755581edv.6
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzwBVD/Z06tfecBn7ZNH+Tj6HQy0ne9RDaKa5mpt0rA=;
        b=Na4d6EvLL76spa4NbWN2pveD9OqImCP1nHUTRyw4QD/rYWCvotokPvFiJcLSwnbHTz
         LzEpjNn488f2m77OCo7jFVzkevMuIOFnO6yullyQRyJ5jzeffreGHzryLW0f76YAxDkK
         iO0CK4jQekFFcq0oZoNmFFbxrRRScdRW/5FfaL9Df099W/eXr1Xf3JC+XLnjiXDZ5c6Y
         VUOa8vYLF82UePXr/1tO9tF0nYBMUiCFIUCF0/GiZdciO+tSRMncqetMTtg9tTyoOlX1
         1o0RS25qSsxnNpj09/2YNIX65J25QOP8zeWmvOMU7stUaEUYAJbrS6R+Ns4ZSr3e3bKb
         +SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzwBVD/Z06tfecBn7ZNH+Tj6HQy0ne9RDaKa5mpt0rA=;
        b=VQ+nD7oNGxqm2/avuNoJd5aL5fs/k840ehttJdndW9fG7Sxfk605BWS835wvvM1MV/
         uUNtuPzpPA56UF7CQQe7HrspVye3OHPp+8eHv9KDBdJ0/GSDI2kTS7X0AxRPCkgTUv+w
         kDEJF/M4moMTOSNJBSCVDbOa+wwop8g7X2R28lD8Rn0t0qi7zveb1Xdp0Fua+EW4QOtz
         NGNMd26/W0tZbNPAVDPXLTmd8yuGbXanLkcGrDHu4BqPDXwMXgIQ+xEh/QFN9hZp8jKb
         YqajEPulQMIXpG2K4k8BiFvpXebMbCqpt/f5E0kOysH+uVMlUdcfeOPZY8rN3feBnH+l
         uiGg==
X-Gm-Message-State: AOAM532ZJNM3LDuPsQeCcZ22ui1rzyUGnJVGG/co95Nppm6y3aC7c+I5
        eapfqbQgPK8O2eqclf1LBDH6ZSmE
X-Google-Smtp-Source: ABdhPJz8Ie+lvu1/CGz+MU9tDEbLf6+rUTPYOcrLuXohnYc/Y/hJI1Pn2fk0HIdsfPLqlTRXxr+iYQ==
X-Received: by 2002:a50:d8c2:: with SMTP id y2mr6459893edj.114.1595548009160;
        Thu, 23 Jul 2020 16:46:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:a981:5f61:c34f:8c32])
        by smtp.gmail.com with ESMTPSA id bq8sm3086975ejb.103.2020.07.23.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:46:48 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] simplify & fix parsing of array declarators
Date:   Fri, 24 Jul 2020 01:46:39 +0200
Message-Id: <20200723234641.78462-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
References: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Any type qualifier is valid inside an abstract-array-declarator
but currently only 'restrict' is accepted. Also the parsing of
this is somehow more complex than needed and done by comparing
the identifiers instead of being driven by the keyword table.

So, simplify & fix the parsing of these declarators by:
1) using the keyword type KW_QUALIFIER to identify all type
   qualifier at once.
2) add a new keyword type just for 'static'
3) folding the helper abstract_array_static_declarator() into
   the main function: abstract_array_declarator().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                                      | 28 +++++++-------------
 symbol.h                                     |  2 +-
 validation/abstract-array-declarator-quals.c |  1 -
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/parse.c b/parse.c
index 182f4ad30b9c..ec69e0c6e9ca 100644
--- a/parse.c
+++ b/parse.c
@@ -171,7 +171,7 @@ static struct symbol_op register_op = {
 };
 
 static struct symbol_op static_op = {
-	.type = KW_MODIFIER,
+	.type = KW_MODIFIER|KW_STATIC,
 	.declarator = static_specifier,
 };
 
@@ -1721,28 +1721,20 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 	return token;
 }
 
-static struct token *abstract_array_static_declarator(struct token *token, int *has_static)
-{
-	while (token->ident == &static_ident) {
-		if (*has_static)
-			sparse_error(token->pos, "duplicate array static declarator");
-
-		*has_static = 1;
-		token = token->next;
-	}
-	return token;
-
-}
-
 static struct token *abstract_array_declarator(struct token *token, struct symbol *sym)
 {
 	struct expression *expr = NULL;
 	int has_static = 0;
 
-	token = abstract_array_static_declarator(token, &has_static);
-
-	if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
-		token = abstract_array_static_declarator(token->next, &has_static);
+	while (token_type(token) == TOKEN_IDENT) {
+		struct symbol *sym = lookup_keyword(token->ident, NS_TYPEDEF);
+		if (!sym || !(sym->op->type & (KW_STATIC|KW_QUALIFIER)))
+			break;
+		if (has_static && (sym->op->type & KW_STATIC))
+			sparse_error(token->pos, "duplicate array static declarator");
+		has_static |= (sym->op->type & KW_STATIC);
+		token = token->next;
+	}
 	token = assignment_expression(token, &expr);
 	sym->array_size = expr;
 	return token;
diff --git a/symbol.h b/symbol.h
index c2b60ce91c27..147306481c20 100644
--- a/symbol.h
+++ b/symbol.h
@@ -81,7 +81,7 @@ enum keyword {
 	KW_BUILTIN	= 1 << 4,
 	KW_ASM		= 1 << 5,
 	KW_MODE		= 1 << 6,
-     // KW UNUSED	= 1 << 7,
+	KW_STATIC	= 1 << 7,
      // KW UNUSED	= 1 << 8,
 	KW_EXACT	= 1 << 9,
 };
diff --git a/validation/abstract-array-declarator-quals.c b/validation/abstract-array-declarator-quals.c
index 85a35a2aca7c..e69df902b895 100644
--- a/validation/abstract-array-declarator-quals.c
+++ b/validation/abstract-array-declarator-quals.c
@@ -18,5 +18,4 @@ void ok7(int a[const volatile restrict static N]);
 
 /*
  * check-name: abstract-array-declarator-quals
- * check-known-to-fail
  */
-- 
2.27.0

