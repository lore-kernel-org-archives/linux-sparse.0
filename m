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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048FDC4727D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B016820757
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqulwyJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJECAN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJECAN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB4C0613CE
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so7715641wrs.5
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keH3L0wzalXZ10eUs6TPOk0xur2Z4Lt0B/mMQOdREuE=;
        b=QqulwyJEQsXtzX19scsAMYMJVmDnbzKFWdwSaSHQrAPabVW3EA5DnPUCDx3+p7O4fz
         BiiH5HupGtj7oqjGwddEg0NfJDBleU8ZIJIa878fUNATsUPCFjFJtmgab7tnzgoep5gu
         V3W2YCBVTAxyYa+kn91kO2vG8Afl4+VBn0D95Ttf9rysxZKdBtJv0uEQd1enDVjnSVJB
         hkmaV3pJBCzRICVnbPbGO3i8sSaWKJDkCRl5bp8AfPrTBEYnOveoKKLuOnXM1xECVi3Y
         zJPtgE+hvRZ6SfTvItg8gc7M6Zimn3Mq52AqsYw2p33Wpk7jYRu9s5WFTR8RUlm5V4Qh
         gt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keH3L0wzalXZ10eUs6TPOk0xur2Z4Lt0B/mMQOdREuE=;
        b=ty5jXbqEROjUd9K2T/BSzMmXDJermyQ6b0jGqQeQ9l28T3adV9F57IfJTvbjkgyH49
         5+yIOR4Zrj31ahgCw85OvZL8vzDTpEF94b4XyckO2LbiPCjjmncfYKBzmixaLAQ27QSn
         QQO/0hN6NStu/MXk8U7yhj48HvvguCWl8CqQmsoyx1NL6T6H1zWQ3h0kg32FDyaSqIIf
         c8kvbV5If2SJHU3+8ec0xs8AsZYs5+NXJ0bOhpLeCeXIxQhP2pIwTv7Zps0W4SDc2ZpQ
         aJ3R6Q05WfrR7UyVrh06IBjobWK+RXBze2QTpNxiYKacuB2EUn05+IW5mOPl30WGsmmS
         5P+A==
X-Gm-Message-State: AOAM5306j2DgtcJiV8Yp37+rIv60BpxuMj36gQLS7rDJhRzq8vrhnLyN
        gwIo9b7A8v3B59k5NqL52w+WQuXMGko=
X-Google-Smtp-Source: ABdhPJzp5qeuZb32hx5PcVgHhrTwdC1HivK1xcD7ejLY6RdpD+r06y5obnf0aiKpKLqvlaCNsy93yw==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr8419954wro.146.1601863209498;
        Sun, 04 Oct 2020 19:00:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] add helper get_nth_expression()
Date:   Mon,  5 Oct 2020 03:59:56 +0200
Message-Id: <20201005020002.1108-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This will be used for -Wformat.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h           | 5 +++++
 verify-format.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib.h b/lib.h
index b35debc83288..957586dbd80a 100644
--- a/lib.h
+++ b/lib.h
@@ -199,6 +199,11 @@ static inline struct expression *first_expression(struct expression_list *head)
 	return first_ptr_list((struct ptr_list *)head);
 }
 
+static inline struct expression *get_nth_expression(struct expression_list *head, unsigned int n)
+{
+	return ptr_list_nth_entry((struct ptr_list *)head, n);
+}
+
 static inline pseudo_t first_pseudo(struct pseudo_list *head)
 {
 	return first_ptr_list((struct ptr_list *)head);
diff --git a/verify-format.c b/verify-format.c
index ba6cb5646dba..939605f55ef5 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -113,11 +113,6 @@ static struct format_type printf_fmt_ptr_ref = {
 	.test = printf_fmt_pointer,
 };
 
-static struct expression *get_nth_expression(struct expression_list *args, int nr)
-{
-	return ptr_list_nth_entry((struct ptr_list *)args, nr);
-}
-
 static int is_float_spec(char t)
 {
 	return t == 'f' || t == 'g' || t == 'F' || t == 'G';
-- 
2.28.0

