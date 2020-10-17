Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A90C433E7
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F01320897
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL5UfKfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439830AbgJQW4w (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439827AbgJQW4w (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA81C061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dt13so8663982ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yUCLtFJm276K2BcMTUy4T8wv3RzmVN2aICSpyg0Vfo=;
        b=OL5UfKfnoQ7o3dhSO6g2p09dEACCmYmJFm3H/1anvYxHJKb+oPVeRTzyRcWHbq2Vbl
         BVI6lsat7/nXYq8vdZJBsvvFxA500uDgRp9+bA1w0tIpART4+uIBDV0CcLHe273XwGfY
         LKws6xviuD5xcK9nfZ4MgWRFRKzcZ8sf2oLao4gKbedfLKSJxfhXkHFtTjpXSJzfW0r5
         s3gmYXSqorqGbK+9MHlWTOXkdRgJ37+i+c0GOYafhJteY8QUb8TKa0bGZrc+bg2q50f/
         gT1yIrRjoPpDb7+eZqp2iZq6hKScoy115cn9FyLc4xrHb6QJrfxtMyiikMSK5X/TZC14
         iMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yUCLtFJm276K2BcMTUy4T8wv3RzmVN2aICSpyg0Vfo=;
        b=JmZr31UpA1/UAxCIhIVihbQgjKPKn/un9rKRthy1mr0i+7sLieXemT+sQiVy8SnzG3
         c5dhKPKdX4oJyT7VDYwv7ufI6pp0pY4ukaZpB8Awx1MXkeM+cJp0IZEY4X7jKH4E7ZlF
         NjECQ9+wbt+P64RIQ4cHIRZ0hbwOGfIQl8To0rxTjLKoaw7PM4b5Y3Q1/RzDTbsUFKu8
         0Q+uGpK/aM6l4B2iov2pbMxLP/BECEOnXohRx0DzdLWOPsVVsZQxe0/l5VnglEVuedtE
         aBLdtUPs45+EdFAeYQGJHwufqAH+Sm5xV6ZhoNltrV6oU44HshKZRhXf/LTjRJjThtJ3
         Aqng==
X-Gm-Message-State: AOAM532vOIRbkQqLa2XTtk5j7Db5f8mElJFHAffQQwvrqrAvSk6uF0BF
        4eoxM/DYwEAXK/JbPBXtDF7vQmmnh/c=
X-Google-Smtp-Source: ABdhPJx5Zm/tKgtIsZjVQAdpHvbjlM7t0ZgfjBCixNrd4MUjoM0Gw6I+4EiX70k/wOL8jQbAsgm9VA==
X-Received: by 2002:a17:906:34ce:: with SMTP id h14mr10186702ejb.325.1602975408950;
        Sat, 17 Oct 2020 15:56:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:48 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/12] builtin: add support for remaining atomic builtins
Date:   Sun, 18 Oct 2020 00:56:33 +0200
Message-Id: <20201017225633.53274-13-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
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
index 1c502597315f..bb0f11b9428b 100644
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

