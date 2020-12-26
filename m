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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34CC43381
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC98620809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgLZRxU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgLZRxU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E847C061799
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w5so6645712wrm.11
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyQF353lYq1izEYPKpY3ieFNMCf34amRJhpkdo3ktuA=;
        b=HwDpxD9g2Fw2z5k+PWU8UwIqbnlFbhoVL+VkCuoyx2l5pShQWSnOl/GF6LlEtshfPU
         jg6k2Nk9OHHWCppvUvRvobSXFxhPCPbih2CJExJaA6fyoZYf3HuDGUNrfxfUhvIeSvfg
         CdJy5Wvroi0kX8fbI6LudjAM1QNJXJLuPd+5VTEtE6v6wKNIqbdb+I6MmuOswwlYrv4X
         AKXWXX4GHIOSSqSvVa7Yj4ZKu2tJeIsrgs09Yldk69rD41Gkl0StJGyT8XLcJStZYRxF
         2KK3DfVJBWUxb849eqfe6ypzwmsJouDRN5RrHDC0RxBIQB8NI714ExmK212oWRirOEVw
         kR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyQF353lYq1izEYPKpY3ieFNMCf34amRJhpkdo3ktuA=;
        b=WZVZ+mLYrUA1gz3zUcxOXilbNBC8RLfSezfC2Y8CIG/feBgX3a35X1L1cd4e7Y5kmk
         K+H1AakIPVEyEuyKimrN4xG/ms6X6ov+q9ooFoMzNTMpzHJ5KDvAn4XJf0rgMvGc+XEi
         PCnlQcnQU0kC+BYb9+zbJz22KxC94dYQunjdM77Wbf7JZ9b6QvAbeRr0XOSAy13C/VCd
         uQRv6UPcNSdh+/4eLZpTpp3WUKQ2yVudWfMV1uV4NYQVe8JWBYGzANRWUH3HegzMHNC9
         u1znLZ1ekTNf9a4uH6rN1FqDHLwqOrNynyyB4W4+RFiscQIlqnAAhQfctHSRuVQlwG5z
         6AJw==
X-Gm-Message-State: AOAM532CmnKMY+RqcDKgkJjX4+mVvCZafNEV1DPP52IMWlBYRDY/u2z8
        Iqh0ph37tANTpFG78M3kGypB/I58C+0=
X-Google-Smtp-Source: ABdhPJxvReHJAPSfkGOF5E3XaRdnZbwxevhkciXYjusB7McU+Zx4t1I4W6ForQevWsvyjETnNc5IZQ==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr44643262wru.334.1609005125045;
        Sat, 26 Dec 2020 09:52:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:04 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 09/16] apply_ctype: move up its declaration
Date:   Sat, 26 Dec 2020 18:51:22 +0100
Message-Id: <20201226175129.9621-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

apply_ctype() will be needed earlier in the code.
So, move it's prototype up.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index f106444f75d8..d6343f0e48bf 100644
--- a/parse.c
+++ b/parse.c
@@ -669,6 +669,8 @@ struct statement *alloc_statement(struct position pos, int type)
 
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list);
 
+static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src);
+
 static void apply_modifiers(struct position pos, struct decl_state *ctx)
 {
 	struct symbol *ctype;
@@ -1043,8 +1045,6 @@ static struct token *enum_specifier(struct token *token, struct symbol *sym, str
 	return ret;
 }
 
-static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src);
-
 static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 
-- 
2.29.2

