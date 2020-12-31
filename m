Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB01EC433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43442158C
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgLaKME (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLaKMD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0EFC0617A1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g185so6897598wmf.3
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvsuPwsxL0b/wkNe56FvL8uVufKWln1fnBpwmsu4ro0=;
        b=Hv0kX6jdEbtc+iQJ5FwK9v2hWSVQpw6nwPD5qbKIOr+0y1FHsCLGzXI0a/KTaCyr9X
         A44AHZLIDkuabWlgxcDAoRfXP88O09DEnOdtmD82vy8rce+GCLkq222cbTpCQTQ9YUWo
         ayuiEwyk7wFSuxcVH6/djT2gt7fL5yR1GOtqQEavAl77Dcci6fHu14Yc73GjNG4qdKw0
         +c0cs78h7ejzCvPCRwWgKdFfoK2/695pJnJdWHCYqWhi+j04nNooqm0Avuprbc9bXcQG
         I3gGUyQRSTozHAeNOxy/W5ltNgtNOGxx9sSlatLDFdx/LJacH3x7an6cwGXVkKc5B6z1
         jLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvsuPwsxL0b/wkNe56FvL8uVufKWln1fnBpwmsu4ro0=;
        b=VvI+U7suJUlrNv7ZhmTRFcdR8uVEZnmkm/Qll7+e0mqfjLUsac1usAqaOJbKfdVznl
         HWI85FY0wArK1YkFQMjXWzm+UY9c3ZSE2vN05dCEWThocpc8LDbdV3ywDtW7E1VZs6/1
         d8HConoD9btKbcdxPugEtdpNZBdRp20XJHCO18THQKRWuKk6ABcXWEHY511jNVEV4TdH
         J/NHm2meOZkun19/O0mgYgn4jUqfIAzC+UPtQZIZ9xzmr4VGkiy2lurY2bmGeycjlotE
         Qwj2JGu7B5MwxYtcYF96tcVLrkVhf9eAyrIFQoFAmG379OxO1hKBbfI7svRSfBVc6TxP
         C3kQ==
X-Gm-Message-State: AOAM533aO/EdOPxntMt1aV/0bmbSw+3uqedWBHr+BMa0dSJZxeb6+3iU
        gUTDxyepo1DrpHKLmTO4PSSGEKLkuOU=
X-Google-Smtp-Source: ABdhPJwtrLQTzugg5IXyYGaxXq9vjWUAVC1l+XP/WfCCp7uejL1Rhfs06cvtvEIxzcXDzDwg8oz8Bg==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr11338063wmh.123.1609409446888;
        Thu, 31 Dec 2020 02:10:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:46 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 08/16] apply_ctype: reverse the order of arguments
Date:   Thu, 31 Dec 2020 11:10:26 +0100
Message-Id: <20201231101034.59978-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

apply_ctype()'s argument order confuse me endlessly as I'm much more
used to have the destination first and the source next (the so called
'assignment order' used for assignments but also in memcpy() and in
many sparse or library functions).

So, change the argument order of apply_ctype() to mimic the order
of memcpy()/assignment, to hopefully reduce my confusion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index 402214212d77..f106444f75d8 100644
--- a/parse.c
+++ b/parse.c
@@ -1043,7 +1043,7 @@ static struct token *enum_specifier(struct token *token, struct symbol *sym, str
 	return ret;
 }
 
-static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst);
+static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src);
 
 static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
@@ -1056,7 +1056,7 @@ static struct token *typeof_specifier(struct token *token, struct symbol *sym, s
 		struct symbol *sym;
 		token = typename(token->next, &sym, NULL);
 		ctx->ctype.base_type = sym->ctype.base_type;
-		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
+		apply_ctype(token->pos, &ctx->ctype, &sym->ctype);
 	} else {
 		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
 		token = parse_expression(token->next, &typeof_sym->initializer);
@@ -1427,7 +1427,7 @@ static struct token *generic_qualifier(struct token *next, struct symbol *sym, s
 	return next;
 }
 
-static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst)
+static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src)
 {
 	unsigned long mod = src->modifiers;
 
@@ -1529,7 +1529,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 				break;
 			seen |= Set_S | Set_T;
 			ctx->ctype.base_type = s->ctype.base_type;
-			apply_ctype(token->pos, &s->ctype, &ctx->ctype);
+			apply_ctype(token->pos, &ctx->ctype, &s->ctype);
 			token = token->next;
 			continue;
 		}
-- 
2.29.2

