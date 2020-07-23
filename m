Return-Path: <SRS0=/orK=BC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013C4C433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D316420792
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtqjGxc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGWXqs (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGWXqs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A0C0619D3
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b13so3375751edz.7
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VPLXJMLCwrZsIiOmSlN1XKoLOQdHPZmFmTZcKx9yvg=;
        b=HtqjGxc4fU2dmdEMvmS1T2P4lNZVkhem4zQU8bNw1CXzunxPH+qrQ5ACqUyRcOuTrL
         7d01vgoJ0lCmH9fK23ZwH9nTHVAdSb7+TMELw9i2TPPvClJaSjpT+C/QBvSFBmbdvi/+
         blGaFI1Bnuxp1/ZAJ0BULcVdJtlZZSec9kLDob+Nu5Jhl3MKNT+ugujn8lmox78qF9dx
         9WvaBa15v1xRYA2dxRRybqRcFUw7YyI7wmVS0O3KO6hS+M0r5UlUizjJfEbbYZKzupEX
         r/kRImsPTP7Er9AVZnoY4yaNFI3Z6lPEsCkzSBzsle2skz1ex9KjQbs+H6Ogvlv8cwxM
         jasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VPLXJMLCwrZsIiOmSlN1XKoLOQdHPZmFmTZcKx9yvg=;
        b=jCl+P9YVkeznV4/m0wAaADn97nzBP/1SI8RFS3uHxwU02MZSsdZz88h6JWWWAum/GS
         54Jc0ggzY25amhy06K4GMYzYKR/OiORxHpEE7Yw+/2wpMFLpP7QiLcfAio0y8VMvTNG5
         VCUc7ZHI34/rN+b2I2w1YCmvIbN8OBlE7eQX7a1o9jomkrhuHK+vavyDV/X2E1tSGK/K
         19MXrKO/tAYQqC5wSVAvXRpKtk1xZOKNM2dvVezRmkN6rVpUPhFDLhFFBaDtqB5mYMiL
         cL72wm0hK0c5bAyVHvEE6CHRuMSzEF0mVuKK45IwybSQbyUecuJLTjGmjyJKH3pQIIot
         upBw==
X-Gm-Message-State: AOAM5313nUY2MDjkRp3/xsifiS61RpMW6SOyHl6M9E6ioOb5tI929TFy
        6AzHfVrw0gReqICoENIhKZmjbYjQ
X-Google-Smtp-Source: ABdhPJycsjv7l6Obempg9xODFu+f4YL3RkowVsf9hCM7UUJrMjLL3wR+c3ZVPRM/FkIh0GEA2EGppg==
X-Received: by 2002:a05:6402:3099:: with SMTP id de25mr6619895edb.228.1595548006526;
        Thu, 23 Jul 2020 16:46:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:a981:5f61:c34f:8c32])
        by smtp.gmail.com with ESMTPSA id bq8sm3086975ejb.103.2020.07.23.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:46:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] add testcase for comma in array declarator
Date:   Fri, 24 Jul 2020 01:46:36 +0200
Message-Id: <20200723234641.78462-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
References: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Comma expressions are not allowed for the size in an array
declarator. Add a testcase for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/abstract-array-declarator.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 validation/abstract-array-declarator.c

diff --git a/validation/abstract-array-declarator.c b/validation/abstract-array-declarator.c
new file mode 100644
index 000000000000..f230e5862ae9
--- /dev/null
+++ b/validation/abstract-array-declarator.c
@@ -0,0 +1,12 @@
+void f77(int a[1, 2]);
+void c99(int a[(1, 2)]);
+
+/*
+ * check-name: abstract-array-declarator
+ * check-known-to-fail
+ *
+ * check-error-start
+abstract-array-declarator.c:1:17: error: Expected ] in abstract_array_declarator
+abstract-array-declarator.c:1:17: error: got ,
+ * check-error-end
+ */
-- 
2.27.0

