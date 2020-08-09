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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9465C433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5613206D8
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPYo6OtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgHIUxn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgHIUxm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40092C061787
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id kq25so7407723ejb.3
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45mOpsfV/8z5dL/fgRcBxvWR+3JFX0fOxkfrnBhPz8g=;
        b=qPYo6OtLvDVs9UDz5tSL/6moH6luZvxq962OpeNPM40yW3zgIZc4hBRKyRaPAhQqGu
         U9P1a77PWMmiSN7usmOJQKEeL2IwPaCQtHt/FL/U7kanHGMI41cUDGmrD4RICv4GcPdQ
         KsaZjYiJrjkofjGR4Mpk2K4++8mMXoYQu5EOaQK9Ka9X2S3ubbdPv36DuANDyCuai4FL
         7zHRMh0R8bpAwvGJAkHnFRD661TuHqa1M5QhYjZqc3EYsC8NFko2ABbogYSLHu6LOEiM
         rtUe6X6tlMVnj27sUMSbvYU1So9fCbqBusQs8Sxluc3H8F1lL/Pra+NKo47j5sSWHk3F
         03EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45mOpsfV/8z5dL/fgRcBxvWR+3JFX0fOxkfrnBhPz8g=;
        b=I7evF0sZOMw/hPK/HTTlZq1DOpiN0g4j+LXeDEjT1PrVdGmpuJGCfo8+SPcszley+k
         syP7FJ9GfcYDjI5Ba7k+qvvJ1mZyUB/45/20BaDd9XSkE1vdRFaJslAz71yibcO9Bwhy
         8WvP0NGD1KBIiCHFCaYdJwcIgHDMd2PXlkzyETXU+UwcYisiToCvwrjSJU9HVR8F6IYM
         XwfH3AbZPm2JDEUxYEoqse70//O2I3O+ZMAk02Rb22EBQihL38C9wQLm5bQCY0YaY2CN
         yM3TvSi8wfOlZP1qP9xXhtOo0v1TOnhhxGsXEyuLc1uxUShOcy0Qbr2Kf70WwLiSJ1Ny
         djiw==
X-Gm-Message-State: AOAM533F/awvo9g6akGCqWSkcPHHynBLjHULA/okMFNEVGzRcKuUTiAD
        otKMvSPRiyNuNKMCGjVNOIqArc8I
X-Google-Smtp-Source: ABdhPJzkXAP5dj94jhNvxNefVLx4NF4lDi7dC1BBZZhKWc6YBIEnHx8NMr76vsllGnC339G5SfZDbQ==
X-Received: by 2002:a17:906:84cf:: with SMTP id f15mr19689765ejy.259.1597006420804;
        Sun, 09 Aug 2020 13:53:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/10] testing for SYM_KEYWORD is unneeded for lookup_keyword()
Date:   Sun,  9 Aug 2020 22:53:27 +0200
Message-Id: <20200809205329.42811-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

All symbols returned by lookup_keyword() are of type SYM_KEYWORD,
because either:
   1) it's in NS_KEYWORD (and all symbol in NS_KEYWORD are SYM_KEYWORD)
   2) it's in NS_TYPEDEF and all *keywords* in NS_TYPEDEF are reserved
      and so can't be user defined and so must be SYM_KEYWORD.
It's thus unneeded to test it.

So, remove the unneeded test.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index f2fdbc9b5a7b..2b7ef2ae23c4 100644
--- a/parse.c
+++ b/parse.c
@@ -1620,8 +1620,6 @@ static struct token *handle_qualifiers(struct token *t, struct decl_state *ctx)
 		struct symbol *s = lookup_keyword(t->ident, NS_TYPEDEF);
 		if (!s)
 			break;
-		if (s->type != SYM_KEYWORD)
-			break;
 		if (!(s->op->type & (KW_ATTRIBUTE | KW_QUALIFIER)))
 			break;
 		t = t->next;
@@ -1749,7 +1747,7 @@ static struct token *handle_asm_name(struct token *token, struct decl_state *ctx
 	if (token_type(token) != TOKEN_IDENT)
 		return token;
 	keyword = lookup_keyword(token->ident, NS_KEYWORD);
-	if (!keyword || keyword->type != SYM_KEYWORD)
+	if (!keyword)
 		return token;
 	if (!(keyword->op->type & KW_ASM))
 		return token;
@@ -1770,7 +1768,7 @@ static bool match_attribute(struct token *token)
 	if (token_type(token) != TOKEN_IDENT)
 		return false;
 	sym = lookup_keyword(token->ident, NS_TYPEDEF);
-	if (!sym || sym->type != SYM_KEYWORD)
+	if (!sym)
 		return false;
 	return sym->op->type & KW_ATTRIBUTE;
 }
-- 
2.28.0

