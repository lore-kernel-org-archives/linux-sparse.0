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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2691CC433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01FE20809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgLZRxT (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLZRxT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A9CC061794
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t16so6688261wra.3
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icXzXvx3BT11l6tSnQMP4QrYjTiQHGS0ErGys3blexM=;
        b=ibGtxwvURXZsy65MSrIJgfNLckQu6Vu3k89Nf0RBqAJq12ryy+FWxnypTtRy2dMoIL
         d5a9tkeRja/sZKtgZTyY8xumE5NnaL82xlK2n3tnPRoli6o6w5GmCfvCUzNFnx5gGxd1
         70N/8jmnOwfsQ4WEtMo3WehuDvcD6G/KiTvXT4WynsSFGWhCdxrOe4y3fCyLbVK/RX5t
         +2keljsyhu14Yv11HA1dn8ddim+6Hj+i7+2MATVo2KEo1bF7Zgc7mm0na4WMjiM5U+WK
         sYgIL61z/oi7zUUe/GW8Xal6qbloGisIn9BjL0MKQSHGvJlWpRsP1AOaWKn7a+++6TYn
         REaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icXzXvx3BT11l6tSnQMP4QrYjTiQHGS0ErGys3blexM=;
        b=sJYswFhAPWNH2PNzXb0YNha+IUog7NhrFfb2O+59gP9BmnUOyst6/vqXoHP7XLTLqm
         28WARHD+m0VEC0wSucJSh2X5L8pSEHdhb47pysdzERCpBgBpD1D8d8aN8EIM1038cYF6
         8nv5hUCjhK9PUlQa/8CfEAbNwHgTy/GMA1dCHYwTXsLKH/d0VfzpPyEX1B/DWZelpvQA
         RAD1se609n39YKn9Fs94WLOdIygHLukO70u9qFGHquMrsGOL+dr5Hhzeolqv4TWbgB1Z
         oOGFnd0v4ZaRNySJUHNB0z6hn/nenzS9vUHjqcvFyOLQTuj2/QTHUgUFpqkyYFoxxyud
         bu1w==
X-Gm-Message-State: AOAM533FA7MKF6I4Sfv77BvCNbRx4AgeFcoW7scfHTWUt3lHa9wqGcwc
        jIbYAsFYN4g58vDPxrQ6Hw43z2Me1HE=
X-Google-Smtp-Source: ABdhPJzzpZUgl43V4NNivJ08Ck3G3zWn0s6GtEUI29T81IeZLUJOL8LpeO1G2GhiNV9DRHcDi+X63Q==
X-Received: by 2002:adf:ef06:: with SMTP id e6mr42845117wro.231.1609005120808;
        Sat, 26 Dec 2020 09:52:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 05/16] add testcases for packed structures
Date:   Sat, 26 Dec 2020 18:51:18 +0100
Message-Id: <20201226175129.9621-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, packed structs are not handled correctly.

Add some testcases for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/packed-deref0.c | 24 ++++++++++++++++++++++++
 validation/packed-struct.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 validation/packed-deref0.c
 create mode 100644 validation/packed-struct.c

diff --git a/validation/packed-deref0.c b/validation/packed-deref0.c
new file mode 100644
index 000000000000..865ad68a4f37
--- /dev/null
+++ b/validation/packed-deref0.c
@@ -0,0 +1,24 @@
+#define	__packed	__attribute__((packed))
+
+typedef struct {
+	__INT8_TYPE__	a;
+	__INT16_TYPE__	b;
+	__INT32_TYPE__	c;
+} __packed obj_t;
+
+_Static_assert(sizeof(obj_t) == 7, "sizeof packed struct");
+
+static void foo(obj_t *ptr, int val)
+{
+	ptr->c = val;
+}
+
+static void bar(obj_t o)
+{
+	foo(&o, 0);
+}
+
+/*
+ * check-name: packed-deref0
+ * check-known-to-fail
+ */
diff --git a/validation/packed-struct.c b/validation/packed-struct.c
new file mode 100644
index 000000000000..5039be4d0b45
--- /dev/null
+++ b/validation/packed-struct.c
@@ -0,0 +1,33 @@
+#define __packed __attribute__((packed))
+
+typedef unsigned char   u8;
+typedef __UINT16_TYPE__ u16;
+typedef __UINT32_TYPE__ u32;
+typedef __UINT64_TYPE__ u64;
+
+struct a {
+	u8 a;
+	u8 b;
+	u16 c;
+} __packed;
+_Static_assert(__alignof(struct a) == 1, "align struct");
+_Static_assert(   sizeof(struct a) == sizeof(u32), " size struct");
+
+struct b {
+	u32	a;
+	u32	b;
+} __packed;
+_Static_assert(__alignof(struct b) == 1, "align struct");
+_Static_assert(   sizeof(struct b) == 8, "size struct");
+
+struct c {
+	u16	a;
+	u32	b;
+} __packed;
+_Static_assert(__alignof(struct c) == 1, "align struct");
+_Static_assert(   sizeof(struct c) == 6, "size struct");
+
+/*
+ * check-name: packed-struct
+ * check-known-to-fail
+ */
-- 
2.29.2

