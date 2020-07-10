Return-Path: <SRS0=t/C/=AV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCDBC433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2382065F
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sREkKSzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGJAN4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJAN4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Jul 2020 20:13:56 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F5DC08C5CE
        for <linux-sparse@vger.kernel.org>; Thu,  9 Jul 2020 17:13:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d15so3198117edm.10
        for <linux-sparse@vger.kernel.org>; Thu, 09 Jul 2020 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOL8Q1fyd1mMfBqZxN0k86XPezSoFii1BDx7sfPR3m4=;
        b=sREkKSzNBrx9gwNBpp5JLeUQ0bY+Xzn6RTq3jz/t4srxXIy86Fce7diBvwqqcwMdSr
         TEAmDuYB3ujNTYCanTT/rEnWmWE9ZRqGV3hGmRL1ejAAw6NZdZFIzxxjUhfnSPEIk5Qa
         2jtATh2+1znNjfTacAGk8HBn4P+l3wcP3FnAJSp7Rg6G6S7EmV++vqoWKTQTaZExY5Nb
         AqtjXo4Lts0ru02/sYByzn+dEbBqEnZNNKd1F03nhJAqg6+SUHTf/SSxK8RQlEMDpSz+
         GYEJJPxlj3W+tfSdRZWSdvEwEeKgbNVWYwQLOj/NucmyA3z2QthSN4NJi1QGEDZkwSdE
         MNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOL8Q1fyd1mMfBqZxN0k86XPezSoFii1BDx7sfPR3m4=;
        b=KXbPMH9VIdUr8v31EaZSTVaUTIO7BzHOKyZhZ5EO5hpN4Fzus41szXTpGKT5wS7brh
         PZOKk+9V2n1psJgdgZngTz2dzVIpsib3VsIa7KUDHAaIyhbgQX2Sry5QecjLHhfqPoFt
         nrWjtIAQkTXuWRZzp1WISbCVlBe8gjzP50QKlNhWg6AfQJl8gHPNeENRvaYaUEZHuf9E
         AtrMxbZmGjoq9wLzQj8TYS2LWT44273NUVsF1Q51v/cORtDqC4NPTSKjTbjQCn55R/vE
         8oRxiRKhZIvBVw4du0PS6r+Y7ig3cz4SCyC+EaZmX/yh9CP33F06PUoreP4Vylk/18Rq
         Fnwg==
X-Gm-Message-State: AOAM530Dq7KO/2jjB4NZJZgeKpnqwQqDPV4fwIL3MW4EhwXkePPPsCLq
        2dLtyN6a9zJLXwQRi/8PF8RlOXHL
X-Google-Smtp-Source: ABdhPJxED9aXI14FoqhZiDSNIElMFfydyaE5UuKgmVA2MoPBkgE362BYHbdM6T/nOt5SSIjUrh6klA==
X-Received: by 2002:a05:6402:2211:: with SMTP id cq17mr50071301edb.95.1594340034747;
        Thu, 09 Jul 2020 17:13:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c80f:e21c:9480:e854])
        by smtp.gmail.com with ESMTPSA id u8sm2614199ejm.65.2020.07.09.17.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 17:13:54 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] add another testcase  with const array/pointer
Date:   Fri, 10 Jul 2020 02:13:20 +0200
Message-Id: <20200710001322.18391-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
References: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Those are cases that sparse should warn about but doesn't.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/eval/array-quals1.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 validation/eval/array-quals1.c

diff --git a/validation/eval/array-quals1.c b/validation/eval/array-quals1.c
new file mode 100644
index 000000000000..a1c3905826d5
--- /dev/null
+++ b/validation/eval/array-quals1.c
@@ -0,0 +1,50 @@
+typedef const int ci_t;
+typedef       int  ia_t[2];
+typedef const int cia_t[2];
+
+static const int	ci__a[2];
+static ci_t		cit_a[2];
+static const ia_t	c_iat;
+static cia_t		ciat_;
+static cia_t		ciata[2];
+
+static const void *const ok_ci__a = &ci__a;
+static       void *const ko_ci__a = &ci__a;
+static const void *const ok_cit_a = &cit_a;
+static       void *const ko_cit_a = &cit_a;
+static const void *const ok_c_iat = &c_iat;
+static       void *const ko_c_iat = &c_iat;
+static const void *const ok_ciat_ = &ciat_;
+static       void *const ko_ciat_ = &ciat_;
+static const void *const ok_ciata = &ciata;
+static       void *const ko_ciata = &ciata;
+
+static volatile int	vi__a[2];
+static volatile void *const ok_vi__a = &vi__a;
+static          void *const ko_vi__a = &vi__a;
+
+/*
+ * check-name: array-quals1
+ * check-known-to-fail
+ *
+ * check-error-start
+eval/array-quals1.c:12:38: warning: incorrect type in initializer (different modifiers)
+eval/array-quals1.c:12:38:    expected void *static const [toplevel] ko_ci__a
+eval/array-quals1.c:12:38:    got int const ( * )[2]
+eval/array-quals1.c:14:38: warning: incorrect type in initializer (different modifiers)
+eval/array-quals1.c:14:38:    expected void *static const [toplevel] ko_cit_a
+eval/array-quals1.c:14:38:    got int const [usertype] ( * )[2]
+eval/array-quals1.c:16:38: warning: incorrect type in initializer (different modifiers)
+eval/array-quals1.c:16:38:    expected void *static const [toplevel] ko_c_iat
+eval/array-quals1.c:16:38:    got int const ( * )[2]
+eval/array-quals1.c:18:38: warning: incorrect type in initializer (different modifiers)
+eval/array-quals1.c:18:38:    expected void *static const [toplevel] ko_ciat_
+eval/array-quals1.c:18:38:    got int const ( * )[2]
+eval/array-quals1.c:20:38: warning: incorrect type in initializer (different modifiers)
+eval/array-quals1.c:20:38:    expected void *static const [toplevel] ko_ciata
+eval/array-quals1.c:20:38:    got int const [usertype] ( * )[2][2]
+eval/array-quals1.c:24:41: warning: incorrect type in initializer (different modifiers)
+eval/array-quals1.c:24:41:    expected void *static const [toplevel] ko_vi__a
+eval/array-quals1.c:24:41:    got int volatile ( * )[2]
+ * check-error-end
+ */
-- 
2.27.0

