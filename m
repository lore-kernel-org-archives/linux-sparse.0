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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6771C433ED
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B188C610CB
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhDRPdT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 11:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhDRPdQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 11:33:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA37C061761
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so49127300ejo.13
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwX/4OayGePcRu0I3LIpEbeLTjaI1qAIASJxYZHJl8k=;
        b=S48vTDJ4X2fgZ8a3QKdDMy2rzIYWEgMWocZTgmaUgz6MeA3bD00OIMj5zD3JdRDFnP
         5h3gamPb9gbeypkNhdXCAGnEpiTLQmzwOEDMWb2I6xpe6MOv0KvfSujudcsB3jqP0TB9
         cq+4wS09n7FBapwHz1adnZThmoPtp37T08cMx04k06GCOmBDiu5817inSzBhTFmX/QRv
         YZsM/7ZnoISrAd6soy2OGBpKt8u9KZ5eVfEavothNyHztNWH9wq1a0SGQpWpuHQ7QDHK
         2gwaLeG/g/bUYmtj2IlHujqBNvGFkXaW+LG5KaBqwTzoxGVkx2xuhCYPdEEkRQNd/gV7
         Zkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwX/4OayGePcRu0I3LIpEbeLTjaI1qAIASJxYZHJl8k=;
        b=cGwG9aCGqqnt2imKuWMN/nqtPmveuwrvZEF2B/r3rn9ZO6nYpLZAZyjleTAfHLt2Ca
         oIuOJqfZcfDM8g/udnR02xQU7Dck4pFgnflnF8Ri2p9uMZtBKX44HBU5sHp7ctXnAxso
         OMFYX/0HCux8rOClIT7/08uwrjds/F5mWlcgvLdVFIs2UqILRFQkLuTpO7oKf/Mh//Ah
         Jd5lCw6+2DneH0g/ySeYo254WMpEg2NG/LAXxiMWKARvn6w0Jl1OCZKA/+LNA7I/CaqW
         qM8IiEn50UV8bX+/3MKOsz2Xgc6Z5tLL5AQp258utiBshX0yoRMeQnowdduErZ5dgwry
         IPOQ==
X-Gm-Message-State: AOAM531+CzTrD/N5LA2zglGPGQOCo0apND2QCMoEdcINDUhRWDQ4k8Ew
        onWhr0NCozI1Ieq9QnkIG3Ub2Vz7FMY=
X-Google-Smtp-Source: ABdhPJwGSZ/CkDHq4xcpc6IDgKEuHx4g0AXnDLSS9ZZc/jvT7hh83IH80dO+RNOGoahrWEwDFoaCvw==
X-Received: by 2002:a17:907:20f2:: with SMTP id rh18mr17805260ejb.466.1618759966067;
        Sun, 18 Apr 2021 08:32:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id k9sm8632888eje.102.2021.04.18.08.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:32:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE 3/4] add helper is_positive()
Date:   Sun, 18 Apr 2021 17:32:32 +0200
Message-Id: <20210418153233.45234-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
References: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add a small helper to test if a pseudo is a positive (= non-negative)
constant (for a given bitsize).

It's meant to make some conditions more readable.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linearize.h b/linearize.h
index 7909b01f29c5..65f54c28a7d6 100644
--- a/linearize.h
+++ b/linearize.h
@@ -58,6 +58,11 @@ static inline bool is_nonzero(pseudo_t pseudo)
 	return pseudo->type == PSEUDO_VAL && pseudo->value != 0;
 }
 
+static inline bool is_positive(pseudo_t pseudo, unsigned size)
+{
+	return pseudo->type == PSEUDO_VAL && !(pseudo->value & sign_bit(size));
+}
+
 
 struct multijmp {
 	struct basic_block *target;
-- 
2.31.1

