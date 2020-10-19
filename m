Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662ABC43467
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6FB222C2
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PExYNnvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgJSQMr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbgJSQMr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD84C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so14706781ejb.3
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGHgOzcoDY71aJFAwhnjrij1nMERNsy9vr1735KGfwo=;
        b=PExYNnvx8qatJFfvjoafBQNp89oHQEXn/OwCeVDw9xU9sM7DisJLRqLnXOTLnc116q
         7Os+n2LWckd3YbhRc4OCUy7cqBgg/wQ5u+vBZDSS+todAdWKR5KR1Ekm3Rt28+u4wc0C
         J1Q37ftk6hBy8Gyvt6RdVntCkLwrkzaQIQcLCwhbZFixPDnlRbmz0MJR8swQTRGkMldR
         mu0pRIq10RLXEP83ay1B7MyPCmIGxSH+EJF6pFW5noycqAQfyMNs41TqHSTuV9Dw1JiU
         PvVWGSeUQTiMoLXATsV2gazVmCp2c26Bjk+lomsdQcME0ZcbvsJI7NTvy06uFerOJJKC
         0eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGHgOzcoDY71aJFAwhnjrij1nMERNsy9vr1735KGfwo=;
        b=ldFoJBxkmTMtJ8h7q4nMMqkQqV2d04wWD/hCX2tIyw9eMsWoW5TTGDvFyEl4o1S94M
         mio/1IUbnGNa0lgcd6NWLjGXZlApfyhREM3ngU9f0skrKWzWYn02/fbxemczzAtAYd+r
         RUTMWNXfOdReD3ZSn4nqlFH/RMKXH5HVFj94Aq334p+Yg1OO8J+Ci6kXHqapgi4LMQnb
         9Dpf42cL8SHiqT4JzhtoHmUtMp3jNLOiAJbq0IoACd3kBbVt0o+4tVRSOAujLoUnSmj9
         d/HuPx2D7BSTBSzn+Z1xs8hi9CnvFecu8LhuVSHFlMEN0Q/ZuyzOSbCsxjJltYykDopM
         E8+A==
X-Gm-Message-State: AOAM531mSSgtAFQRZuJ0M0zvQh9W8CxPPSKNmj31NPuSPgxRDmx0adF+
        3PGMlYVnhb9calzLl4/7UetUyPLht/8=
X-Google-Smtp-Source: ABdhPJx0x0DWIEo4DdDUEQC361BlQ2Ztjdczj7cxhoAo8vaWkRqrpfLTadvB+XybrYfNIQxsGZv3rQ==
X-Received: by 2002:a17:906:4d1:: with SMTP id g17mr646803eja.38.1603123965597;
        Mon, 19 Oct 2020 09:12:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 12/12] builtin: add support for remaining atomic builtins
Date:   Mon, 19 Oct 2020 18:12:26 +0200
Message-Id: <20201019161226.97429-13-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Nothing special for these ones, just plain functions with fixed
types and arity.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin.c b/builtin.c
index b481a8102f38..acc49871644c 100644
--- a/builtin.c
+++ b/builtin.c
@@ -482,6 +482,7 @@ static const struct builtin_fn builtins_common[] = {
 #define va_list_ctype	&ptr_ctype
 #define vol_ptr		&volatile_ptr_ctype
 	{ "__atomic_add_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_always_lock_free", &bool_ctype, 0, { size_t_ctype, vol_ptr }},
 	{ "__atomic_and_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_clear", &void_ctype, 0, { &volatile_bool_ptr_ctype, &int_ctype }},
 	{ "__atomic_compare_exchange", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctype, &bool_ctype, &int_ctype, &int_ctype }, .op = &atomic_op },
@@ -494,13 +495,17 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__atomic_fetch_or",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_sub", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_fetch_xor", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_is_lock_free", &bool_ctype, 0, { size_t_ctype, vol_ptr }},
 	{ "__atomic_load", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_load_n", NULL, 0, { vol_ptr, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_nand_fetch",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_or_fetch",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_signal_fence", &void_ctype, 0, { &int_ctype }},
 	{ "__atomic_store", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_store_n", &void_ctype, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__atomic_sub_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_test_and_set", &bool_ctype, 0, { vol_ptr, &int_ctype }},
+	{ "__atomic_thread_fence", &void_ctype, 0, { &int_ctype }},
 	{ "__atomic_xor_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
 	{ "__builtin_constant_p", NULL, 1, .op = &constant_p_op },
-- 
2.28.0

