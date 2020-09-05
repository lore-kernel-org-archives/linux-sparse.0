Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB22C433E2
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC02074B
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYmC09K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgIELM2 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIELMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 07:12:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462DFC061246
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 04:12:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l63so8364506edl.9
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVrIHyAXQ1SLiiV8C9LWNogRBbUIjq8pdftnJ8yMazE=;
        b=CYmC09K6Oc2cEQhg4dI7tH7fuzNrnrOuKTg/60LnfnrCoxqvSOIW09PsmKgM7eJmDP
         bXI+ME5VZFL1Hz7mhXLnGKBlaCWOpz9iNDruGzgrJEQluq07xZoh7uX0Cep8g4xSsS1W
         B0Fvi0a4ul0BMtYDRa3TmlNxxKfZsqC5Rxnnai/mZKzPW82x12POEPIVNVQfUVyu/sp5
         tbno3254m6PG719yT32BndfyqVpBbl0tNTfsmkADa29OAUQFxiADTBQb4nxhiCBuAYdk
         3Px4VFpO9CAWE2JsyH14ltf2JOskyhGFC0bK9EnhJDtHwdA0hx+fPl9/+nGadv/hn4Pl
         KSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVrIHyAXQ1SLiiV8C9LWNogRBbUIjq8pdftnJ8yMazE=;
        b=mJlaFZu5VqDKD2zoz1PUsVlLqUHqtrIsQsV0xcK/hU22QEHeksKwsH0BviZXdmOSZu
         INWMXdaEevGQzZfLJmwSp/HN3/L+dYdSNd3qKE0VrYESiF8XkRzyOvG4LkR5iD56PVKd
         DJf5LjXueZKZJV01OZpisDzVehl8zCe8S+nncE2GpZJQP4EIBAtFbBSwwEO0F2xgkPmh
         KiPZUgXbulGrihj9S9AUqz0k3K8xi1/cSmFsrfCf+wALD7KX59iJQG2/eSznRIIB1THe
         1+Q7alk6sgAu3GajtKTK6RSr16U4YrH7plEqVjXQ7BQ5+OPa4AkJYk8Zq2nTOAI1LLOy
         CkLg==
X-Gm-Message-State: AOAM533Y0jX1/c/XpE8y4VfwKEvkLBSvmOy7Jq1yCGicUo+u4yekQQn+
        AFMgFsjt23Bn+9t2R9kG84WCRJ4a5fM=
X-Google-Smtp-Source: ABdhPJz5/o+FyK3n3qL+QInpMIGhgEOAAGWrieX7x3hVCioyxhlhMZpw81kpOORS1Oms1d08UCgtdA==
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr13158151edt.158.1599304339622;
        Sat, 05 Sep 2020 04:12:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id u15sm8319506edj.69.2020.09.05.04.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 04:12:19 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] builtin: add declaration for __builtin_fma{,f,l}()
Date:   Sat,  5 Sep 2020 13:12:10 +0200
Message-Id: <20200905111211.82199-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
References: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The motivation for this is to experiment with adding infrastructure
for the linearization of builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin.c b/builtin.c
index 2e9be8be8adb..26b612dc401b 100644
--- a/builtin.c
+++ b/builtin.c
@@ -490,6 +490,9 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__builtin_ffs", &int_ctype, 0, { &int_ctype }, .op = &ffs_op },
 	{ "__builtin_ffsl", &int_ctype, 0, { &long_ctype }, .op = &ffs_op },
 	{ "__builtin_ffsll", &int_ctype, 0, { &llong_ctype }, .op = &ffs_op },
+	{ "__builtin_fma", &double_ctype, 0, { &double_ctype, &double_ctype, &double_ctype }},
+	{ "__builtin_fmaf", &float_ctype, 0, { &float_ctype, &float_ctype, &float_ctype }},
+	{ "__builtin_fmal", &ldouble_ctype, 0, { &ldouble_ctype, &ldouble_ctype, &ldouble_ctype }},
 	{ "__builtin_frame_address", &ptr_ctype, 0, { &uint_ctype }},
 	{ "__builtin_free", &void_ctype, 0, { &ptr_ctype }},
 	{ "__builtin_huge_val", &double_ctype, 0 },
-- 
2.28.0

