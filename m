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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE92C433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACFE207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLaKMC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgLaKMC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8DC06179E
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 91so19687595wrj.7
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HciWNsu0XUVwo2wrDpSIyJKTI8j86Rfxagit+VDsIm8=;
        b=jPWDiDLk5ullTB2s0uyd/wQuJsNTm4bcWMX4kWSVMLqSc6uYPq4Kg43FWxEGjFN6vS
         JYJQ20SxoAouiyTDZqB0yYjKQJYq7Z2ZFAeqCrJSAzCi/TpAf4iZbmarKOrBVL3MMNk2
         OFmsBCMgkP9+jZ77XqnQLNtEn6kPb3k9DzQtkgTuzyAXS5wUWj7jdsbxRj8GTiSQzgpa
         MCuwWh+cAfH2WOXiPYh11PjDk7PDh4R5/ioXe3WF0celMAX1181d3nxHnhC3u+tNW3i6
         xaIvgH4oXiouf4BdpFcWtFrV+KJP3KkGMfonT1dQDSl3pGAJMJZC3PDx6wDKniylx/Hx
         3O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HciWNsu0XUVwo2wrDpSIyJKTI8j86Rfxagit+VDsIm8=;
        b=haBeRBM68pS4YpVPgsOVPo5R9lpAcODqXv3arfiDTMcwnW3dDIkeyDMhBHya1NldPG
         7YrTJMrGijLNlXlDi6UAlk6EoT/RVglGPjx6JAqRqPbpwndt1Sens9Tp3EEH4oa+8VoN
         r13Ge9heWUaEGAKlbM60WsweBvgXLGDfx509QWOSjahFJLiDQ/uUC2uBPqO1FgrZYX3o
         LOPirj4T/fpnr7sGrH1gIwL79NvBrOAsL935/TA18fHCDtcgZWHAzx60BNfy8FBJfzXB
         cTM68cMTJkTW1bYljk/BohhZOzKiF1MNU/BeRZbe2wA9Iyi8/vQdwxXWkMc460wQgkbd
         3+ag==
X-Gm-Message-State: AOAM531dgR1Zkpe62bWtg5f6PKb4h4qiRUzHdfnqiG4Pp5SOvGdpe7Uj
        2GkdsU0p4jLATwHSGjmVsmljmmG3VwA=
X-Google-Smtp-Source: ABdhPJwMLNCeL+e5cIuZqvU6NGADyEwqMOe1LZENqdb4HYiK95Drzci+fovbjkzLWY1Ct6d3CIPyjA==
X-Received: by 2002:adf:d085:: with SMTP id y5mr65574413wrh.41.1609409444296;
        Thu, 31 Dec 2020 02:10:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:43 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 05/16] add testcases for packed structures
Date:   Thu, 31 Dec 2020 11:10:23 +0100
Message-Id: <20201231101034.59978-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
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
index 000000000000..e21d11538639
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
+_Static_assert(   sizeof(struct a) == 4, " size struct");
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

