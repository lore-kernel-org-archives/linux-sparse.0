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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27E2C433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C2720709
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6KMmRDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHIUxg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHIUxf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71259C061786
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so7403811ejb.4
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=300mLR/hT1DTtQCp0kyJLjEskTuTZ+JPobkzYQkCKJs=;
        b=V6KMmRDvkBK1Kf89HHD6HwxrC6t+Iy7F8YWpUcMsJbutIZ3pgcDhyL35pO/lJQMzyG
         unj3kRHRmMr39o/UQTFsN+/s6Oplz97714dxWqmjXUe4hLqdTv5lxItkXSZVz7swiQbo
         sT+PbdbAajQdsqd++FKGLgqCihCe1u6nJe9oYlAaFXRJr9JqaRibyo4pk9c+WCg+qaca
         sgswInjQj4yV2X/vd7SOzhogtO3Mn4tPLsTshqi4kwsmf/dhtmBhp9LNFAXWGXbESBwQ
         KGYnrqoZ+KamnSdNSXdBEE5vqjRxg2PzK+6U4i8wLN0Sa4TOSzSIhCUH5vP8LyttQp+i
         lDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=300mLR/hT1DTtQCp0kyJLjEskTuTZ+JPobkzYQkCKJs=;
        b=DramswIj+C+XH6zgLsYuWmmg0bf0Q6sQLaAnpV/CO8sxR/BYLDfpprDKC3OI/pHfyf
         oHvhiXqQMfXafv3g1Gdt4+co6VCKOaiuqyesS1n30MzNbnTxedkxxsNR4TlRzX3ZJ582
         Aa459B19l2xpcYxZscTdbEbBCDK7GNRu81NItfS6lwULtNpAroySFbZUr/DJ74b+1gdD
         9aaDfTY+5DhYNfJAbAD+hs4Sft7kWUGjVkVXg/Te/rlufPOln0uv4AePf6CU/ndrsXJH
         /oaxn+LdOM/I66UmV6WvXeqaLLh8zuf8Dk+kKO8DLhgviWXDUitnQt0LyOgvyXGw5axu
         weXQ==
X-Gm-Message-State: AOAM531nZ1mAVXjMOyR3L86okixqSd5YOUAjfkmrPJl4JWuRtc8AIo8P
        BZKhRF0lXvb02Nf08B0qAnPpqxfJ
X-Google-Smtp-Source: ABdhPJxvVTytsnkxVeCr9+ZTR2yf3G8OQFK0G07HvcBdS+4qB0sQliCvPH1YTJ31QMdqJ1cZ7h8wmA==
X-Received: by 2002:a17:906:7798:: with SMTP id s24mr18713308ejm.45.1597006413877;
        Sun, 09 Aug 2020 13:53:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:33 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/10] use lookup_keyword() for qualifiers
Date:   Sun,  9 Aug 2020 22:53:20 +0200
Message-Id: <20200809205329.42811-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When handling qualifiers, the corresponding symbol is looked-up with
lookup_symbol() then it's checked if the symbol's type is SYM_KEYWORD.

But, only if the identifier is a keyword (struct ident::keyword) can
the symbol be a SYM_KEYWORD. Thus, non-keyword can be filtered-out
early by using lookup_keyword().

So change the call to lookup_symbol() by a call to lookup_keyword().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index b07237eee0bf..19520eaebf38 100644
--- a/parse.c
+++ b/parse.c
@@ -1618,7 +1618,7 @@ struct symbol *ctype_integer(int size, int want_unsigned)
 static struct token *handle_qualifiers(struct token *t, struct decl_state *ctx)
 {
 	while (token_type(t) == TOKEN_IDENT) {
-		struct symbol *s = lookup_symbol(t->ident, NS_TYPEDEF);
+		struct symbol *s = lookup_keyword(t->ident, NS_TYPEDEF);
 		if (!s)
 			break;
 		if (s->type != SYM_KEYWORD)
-- 
2.28.0

