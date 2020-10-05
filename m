Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019FC4727D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AC320757
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkc0cJSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgJECAP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJECAN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C96C0613E9
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so7165913wmi.0
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hu98vzIkNm3yxy0wFUENMtNDO91sLHD/IdNSpdq23q0=;
        b=bkc0cJSJe1d3OEdSp3l07H4Nxa+LLTaQvGP7TT3twSCPv3hl3z4UiUiCHebH8m+M8e
         Fqv8FUHT7yCjU5ufUhR+COAxns+l0xXLgSRlHXKUvnb0uKrREMZbsz7p3AJT52b79zwL
         QMIBQQ8U4bm6Fr20BGtuD3xo915/2UCvcEr9jYl1Hx/orhf6GUV4t6D/FVqIAErrcTz/
         cQC8mN8iID5MbKP8tdoqbHrUObh3Csg1GuO74QI7SgZZj5xwW+ON9gZEBX652fOiDe1t
         mJGhY8fZtPl/KAvIbhumQoTAWr9eKDz62ErM1ChNgi+s9WKpZXpsf4a5Z2JfGdOwBa4o
         9pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hu98vzIkNm3yxy0wFUENMtNDO91sLHD/IdNSpdq23q0=;
        b=Gn2YJSTg1uRVbW8eQCOs9Y320vBpSq4D3gTFSxjzECWSweAleSkHusjfjhxvPDNG0o
         ZkBFTPbxGl4WRh4+BvNq9153M+LN1DtG7olCkMUwp2hcPUKgFWFzqmmIQ1Umt52rl/Oi
         HToNn48JhJsZeK6zJ3Ve/QQkmwi4oL8uioynzCuiPUzBxrA97djDzQ8Gd2hdsuAFVCJT
         A09gBrRuVXH0UaVEDU4NtBPN5hw14fe97geq7aJKcUrM/b2bwMGZBa/9ZvgW1c0a0ZRM
         NPDPn9oDIZZevXxkRW8OcrsEGc2Vxiik9hMzbytYBgU9X5ICo/wV07DycqWLDYpoRNbA
         yHAA==
X-Gm-Message-State: AOAM5332xxiZcbRknFdwJblu0DYzwJbp7DVqjghb73iCtLgxjAEvRznr
        vS9ieNZfdEvLtUeQoXDwJkP4vhroatU=
X-Google-Smtp-Source: ABdhPJzbFgQpmXI8RpywoL5wiPcfY8/2GhNHFNM76zRV7xiOJkqrorQ6rwF3+LEK1os5+Jk/JqoEFw==
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr14037833wmf.119.1601863210240;
        Sun, 04 Oct 2020 19:00:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] move the definition of FMT_{PRINTF,SCANF}
Date:   Mon,  5 Oct 2020 03:59:57 +0200
Message-Id: <20201005020002.1108-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Move these from parse.c to symbol.h so that they can be reused
when verifying the format.

Also, add a definition for unknown format type: FMT_UNKNOWN

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 6 ------
 symbol.h | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/parse.c b/parse.c
index 1b021b87549e..c2d29318149f 100644
--- a/parse.c
+++ b/parse.c
@@ -120,12 +120,6 @@ static void asm_modifier(struct token *token, unsigned long *mods, unsigned long
 	*mods |= mod;
 }
 
-/* the types of formatting from __attribute__((format)) */
-enum {
-	FMT_PRINTF = 0,
-	FMT_SCANF,
-};
-
 static struct symbol_op typedef_op = {
 	.type = KW_MODIFIER,
 	.declarator = storage_specifier,
diff --git a/symbol.h b/symbol.h
index 55c7e3330ec3..0d5439ee93f7 100644
--- a/symbol.h
+++ b/symbol.h
@@ -95,6 +95,13 @@ extern struct context *alloc_context(void);
 
 DECLARE_PTR_LIST(context_list, struct context);
 
+/* the types of formatting from __attribute__((format)) */
+enum {
+	FMT_UNKNOWN,
+	FMT_PRINTF,
+	FMT_SCANF,
+};
+
 struct attr_format {
 	unsigned short index;	/* index in argument list for format string */
 	unsigned short first;	/* where first variadic argument is */
-- 
2.28.0

