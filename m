Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA969C433E7
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C5B20897
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UClsNl56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439822AbgJQW4u (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439826AbgJQW4t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4228C0613CE
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so8663905ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mq5L0kJtABgMXj/9u7g8XhvrAug4jR17KlIP0wE1XqY=;
        b=UClsNl56kHUZKMxddhpBVV+4uNXsCUsicFg6b4Dxff7YLr5iG60qocui2jermNphAj
         H8RTMD9DuEvi10a2KT9VJmby1EkchIya/7lNYmKpvmH2LiWN3QDrDmKKEwYtZxeq+W0x
         eejUOfreO+GLLcxsu9FPmBTfy/A/Mcoy17kTTxMX3vBd3BuINxVFn8LDzQSp+EvWM9zT
         U4itiNCtFI9RuKDsQJjzxGKeI2tLPxVRR/Io+jkQeSW6l+yZWavQi94uJ3EZzYtt7xE3
         8haGmjmDUaE3HFDyk8kfWAGNhv3BuOeXYmlXZAqjGXEb2Zz737DBTJId8YuUc4rlT5Ze
         pUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mq5L0kJtABgMXj/9u7g8XhvrAug4jR17KlIP0wE1XqY=;
        b=DD4kRP78OFu99NFQMCSeZBjHff6m+LhydLhcaUUMBWVHRg3qgvwy1d47MZgdYOWEmj
         xfkVN2qIB3SjvnADoCbIAG+7ByacrDJDeJQ2bwL62iiQuXrFl3/No8uE80dAMgtlUVdJ
         Eowxl/LmnC2AQh4sW7ziWYSVFXE4Qm/8QYv4thbL5dMcVoULM9fOZNUMOenGdBbZK7db
         fjrch6TRLiZag1bnwHPzzxuH2zEHfm85DrwBuEwUwqLNMKOtMb+hWhNbwX1ik2YMo1br
         SkAYNR3GKaMY71ylf48rUVlV1JLhmTp4BNZAXu+3P1r0Nr5CcVoRIarFJ9T/BMTcbfdu
         2Pig==
X-Gm-Message-State: AOAM5322dGt0OpoY3joKk/AjfmP2qJTs/zd3fQSXQEhAX3PDagj6FNeV
        Kd5OGNM2iNyizGMWyUmpZllzpjnHspU=
X-Google-Smtp-Source: ABdhPJxEJ2qocYUHdrQmk1NSRzrsIujgRNwoWKwIfBeuzSyThdkZ1SwdQwcZzqiHahM1EHYeOfUDwA==
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr10405116ejb.256.1602975406310;
        Sat, 17 Oct 2020 15:56:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/12] builtin: add support for others generic atomic builtins
Date:   Sun, 18 Oct 2020 00:56:30 +0200
Message-Id: <20201017225633.53274-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reuse the generic method for all these builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin.c b/builtin.c
index a65cfd53ced1..94f86a87c3e2 100644
--- a/builtin.c
+++ b/builtin.c
@@ -409,6 +409,8 @@ static int eval_atomic_common(struct expression *expr)
 			t = ptrtype;
 		} else if (is_dynamic_type(t)) {
 			t = ctype;
+		} else if (t == &ptr_ctype) {
+			t = ptrtype;
 		}
 		add_ptr_list(&types, t);
 		NEXT_PTR_LIST(t);
@@ -481,14 +483,22 @@ static const struct builtin_fn builtins_common[] = {
 #define vol_ptr		&volatile_ptr_ctype
 	{ "__atomic_add_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_and_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_compare_exchange", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctype, &bool_ctype, &int_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_compare_exchange_n", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &dyntype, &bool_ctype, &int_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_exchange", &void_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_exchange_n", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_add", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_and", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_nand",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_or",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_sub", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_xor", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_load", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_load_n", NULL, 0, { vol_ptr, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_nand_fetch",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_or_fetch",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_store", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_store_n", &void_ctype, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_sub_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_xor_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
-- 
2.28.0

