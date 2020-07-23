Return-Path: <SRS0=/orK=BC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753EAC433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5060420792
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lekz7jFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgGWXqw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgGWXqu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED81C0619E2
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:49 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z17so5750058edr.9
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZwGZy4xjx6tJRmwJ3VpD9EYADjUQzmW52fl4sTPA0E=;
        b=Lekz7jFxjmRvGsxfwXfXnZ2gDUgBdwjF+Y0m5k8W5rhBntpDTAafw+6uVB91twfo57
         a8aX9dGplFR2Ocy8YoydOv26pVLkRePlesM9oOxiaiZ+DgkBsN8dtvSU2WpFyeqia75H
         gX28xoVLJLVjbf9FKS8nR+HJaD3AqCU8wh4t8lrCUbYPogOBQQEE8Vh9znq4mJljf5rB
         utKQn++zAWijAqzwu+HU3wm17msKBIgyUdMqiBPHOJcceI7rFOuYJpOdcGcMyLGLV4MD
         GBgODC2W8zxg2hBqfchTqmhttWOkJGp116RyYZ4tSdzXgOyTTEIiA84GJtcu/jTawOcn
         jzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZwGZy4xjx6tJRmwJ3VpD9EYADjUQzmW52fl4sTPA0E=;
        b=FULX2lCIRxwrCx+MUOQ8UWP7vsX91ebnTrLKiQLmuJlsPSrbo8LX60dFXAuLTWRfN/
         sNq4ziLJaZlCJ2o0NLw8qy0zikZMbvDHplzXTFmr7+toWWOSbVJi06BiyOfXU87TTQD1
         avGEf3gJfbD1WYN3+RHLT2V+uejycsdc83gXoNioirbh+bOj58ypRY+LK20bl+Jb2ccJ
         o8Se5gAkUTNJKV7JEiOENkm0I4pFO540TcDAxlZQAp2MEIqFLNGsMjs4q/so+boVaVTN
         UEstapMtrn0srAKPGpRVaa/OGzszPXt9ekcpglfcoHd60z19MGZHHewIeOiqvznRw+W3
         /NdQ==
X-Gm-Message-State: AOAM533LehKJHGdQf1c/noXWaqGTMm4ho51uDMjxfK00AQGJ5svkmsEB
        tEgTbO84mQ5b1oAMyQMN7oknahTC
X-Google-Smtp-Source: ABdhPJxpqpgnv1G6veux1B0dkCnkoAbjOZ8uF4acpMRaC4sSkUjYtS3Ikx5tmgX2UQAX8pkeRnsV3Q==
X-Received: by 2002:a50:931e:: with SMTP id m30mr6685313eda.341.1595548008311;
        Thu, 23 Jul 2020 16:46:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:a981:5f61:c34f:8c32])
        by smtp.gmail.com with ESMTPSA id bq8sm3086975ejb.103.2020.07.23.16.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:46:47 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] add testcases for C99 array declarators
Date:   Fri, 24 Jul 2020 01:46:38 +0200
Message-Id: <20200723234641.78462-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
References: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

C99 introduced some funky new array declarators, those with
'restrict' or 'static' inside the brackets.

Add some testcases for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/abstract-array-declarator-quals.c | 22 ++++++++++++++++++++
 validation/abstract-array-declarator-star.c  |  9 ++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 validation/abstract-array-declarator-quals.c
 create mode 100644 validation/abstract-array-declarator-star.c

diff --git a/validation/abstract-array-declarator-quals.c b/validation/abstract-array-declarator-quals.c
new file mode 100644
index 000000000000..85a35a2aca7c
--- /dev/null
+++ b/validation/abstract-array-declarator-quals.c
@@ -0,0 +1,22 @@
+#define N 2
+
+void ok1(int []);
+void ok2(int [N]);
+void ok3(int [const volatile restrict]);
+void ok4(int [const volatile restrict N]);
+void ok5(int [static N]);
+void ok6(int [static const volatile restrict N]);
+void ok7(int [const volatile restrict static N]);
+
+void ok1(int a[]);
+void ok2(int a[N]);
+void ok3(int a[const volatile restrict]);
+void ok4(int a[const volatile restrict N]);
+void ok5(int a[static N]);
+void ok6(int a[static const volatile restrict N]);
+void ok7(int a[const volatile restrict static N]);
+
+/*
+ * check-name: abstract-array-declarator-quals
+ * check-known-to-fail
+ */
diff --git a/validation/abstract-array-declarator-star.c b/validation/abstract-array-declarator-star.c
new file mode 100644
index 000000000000..fdbdff19840d
--- /dev/null
+++ b/validation/abstract-array-declarator-star.c
@@ -0,0 +1,9 @@
+void ok8(int [*]);
+
+void ok8(int a[*]);
+void ok9(int a[const volatile restrict *]);
+
+/*
+ * check-name: abstract-array-declarator-star
+ * check-known-to-fail
+ */
-- 
2.27.0

