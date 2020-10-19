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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEBFC433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F682225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMrmygWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgJSQMn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgJSQMn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:43 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A2C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so14710964ejg.1
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YexzUdDFqzZbD54XGKhG8iR9or1R4H7mVB2ZiNCe9rM=;
        b=IMrmygWlS3Gi11eDTTbAy9vYXA6VWKYbg8blmtP0suKV2UcicS5BRTwZQZ/tIByMDI
         a52+6HZOEQbV+JuSxEsXW/XSsuBOVAtcBDsvPJfPVwMpe3WN0MNRL8JckF57lP0/GHnX
         8QrDGvmtn+1kS3c2+aK7FcdS+3AGK8RxeX7ul6/OvMEIH1ROExTGodLaiiKKeGQJzD7Z
         fW9h9Beu1q01sQndV70M2Ja90uuVVlgciNAICF2SZ0eCSYWc6S6OefJ4HsojuzUfRmO9
         f7SH4WJdyBa/kzzndkGMOH55m1Ui5/qpTPNVavr70Rpe9+LqFXkNiieb1fFek6AYC9Ir
         AY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YexzUdDFqzZbD54XGKhG8iR9or1R4H7mVB2ZiNCe9rM=;
        b=LTTMCVuGh6Ck2uaed+V/mH0haQMinrunzPFy1DF+qkTiKkC/h+OWv76QywTRjcLXmt
         nGDaWXMoeJiDl1gr3XpYCwtk24SA+GXHe+DngiMKhzBSzit1VHEEtFH6nnUR6Lyji8Fy
         7uliJX6lmqsgBm4s9eMb3xemwjbyUNJ8Ifkb0oIqL03Gd2OwJlZx1OnZzcHtj2DGDUVL
         ulowQndnAaWK+CtOt25GiGaXV0krlop+H7g3PoI7yJk3uFlENLE4OteE8adZOndac7Ii
         YHe9kFyMx4mQV6/uQa97Y5dA8Q9Ja6yyt8DGxEupGBYZSdODW06FtExzCK6Qc061sTyl
         RY9g==
X-Gm-Message-State: AOAM531BOIuOavwk3xSEYR5B2xDLwocQqIySqA2dRZNesF2fDHxgWb4l
        Ngy0JuwPnH0gjLvnTmvtIF1ZqgWsy/4=
X-Google-Smtp-Source: ABdhPJwH17PxVWgq1bFME/8Flv8ea4+2D/Zv+qtYKwNQ2AubR+9J9hyw9KSuyI3rumC8l6fdcZNACg==
X-Received: by 2002:a17:906:3582:: with SMTP id o2mr603321ejb.518.1603123961346;
        Mon, 19 Oct 2020 09:12:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 08/12] builtin: add support for __atomic_add_fetch(), ...
Date:   Mon, 19 Oct 2020 18:12:22 +0200
Message-Id: <20201019161226.97429-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reuse the generic method for all these builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin.c b/builtin.c
index 5477eb64aa95..6573c1deb686 100644
--- a/builtin.c
+++ b/builtin.c
@@ -479,6 +479,18 @@ static const struct builtin_fn builtins_common[] = {
 #define size_t_ctype	&size_t_alias
 #define va_list_ctype	&ptr_ctype
 #define vol_ptr		&volatile_ptr_ctype
+	{ "__atomic_add_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_and_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_add", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_and", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_nand",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_or",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_sub", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_xor", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_nand_fetch",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_or_fetch",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_sub_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_xor_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
 	{ "__builtin_constant_p", NULL, 1, .op = &constant_p_op },
 	{ "__builtin_expect", &long_ctype, 0, { &long_ctype ,&long_ctype }, .op = &expect_op },
-- 
2.28.0

