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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F3C433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D396C2158C
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgLaKMC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgLaKMC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A3CC06179F
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v14so6990287wml.1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSMbSIKTnRV9WGZmjxMKLs9z1Fl3BYZ/dX1qJ9TdcSM=;
        b=IxiWamIIrbHPJdyfUrRC6NZQKlCXgin7mtnEuAemLEATs6ElBRz264dMksz7gZmWkV
         tlospVu+r0VXC/CRBUfCZV8AsXmoHer0WCy4qaPE9fM0ss4kJhwu9zPVmyJrhcGNbT4b
         /DcB/J4gglkyNNyH9cY3FfWIwqdtcu82AQLt9Ylmxfb+PJamw3yYN1/yWkn1aCpUEW4P
         zBFFXiuNS0GpR9rQRIvxH7o+wtDVAZ18gX24jU8avH+/hKilnqfLZ24ZeMKAb22RyX87
         etL+dVlbXd6yXMsltTYEkifn3gdU5zlEIliNK+ykykVuYJRmDpZEh5wlu5kX6x6MdoXv
         6IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSMbSIKTnRV9WGZmjxMKLs9z1Fl3BYZ/dX1qJ9TdcSM=;
        b=fxVhkNar4RTuZT0/nX+GuieJuGTGS5QTL5icSBGRzXCboAXeNd53KLE+JNcuSHD0sU
         9YkgxqgLpMbfjFQUi69PvvdMUTLSzh6y+UwtmeXH8id1m7a8G1vBNN1qMOn43GqfQsib
         BNvKLJTPK/dAilHLzMXey4EaOf1Wxwt+kEb6GVxfOr+CY/AN+Wg/eZwZac0X8i46wAai
         YBeiF0ImQ13iGakptTPfN4rNTk1/CDw8n/vTSQvo8lYMgKj7Ig8FApeUBm+s1jpFyD9h
         1seQFR2qjO4G4uxWH4i2+CXVsvVgS2BOWKm6675W44xzfy8mCsPUXXhJFYBEgViV/7TE
         JGSw==
X-Gm-Message-State: AOAM531IIgwcYhJaVQUPVHPjavB9WrOdkKumjVmvGRK50jwOJLOKGTzn
        cTScUkL7++kGFsRRIlKGrqM/47nA8iY=
X-Google-Smtp-Source: ABdhPJxeOV1/N3XV6s6kqFYaIqPC3tgtRpJYcDLD6RyM0JHHdmqF+mD4cXj/zVwNJI5PApCh5fLPZQ==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr11157710wmb.76.1609409445233;
        Thu, 31 Dec 2020 02:10:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:44 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 06/16] add testcases for packed bitfields
Date:   Thu, 31 Dec 2020 11:10:24 +0100
Message-Id: <20201231101034.59978-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, packed bitfields are not handled correctly.

Add some testcases for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/packed-bitfield0.c | 59 +++++++++++++++++++++++++++++++++++
 validation/packed-bitfield1.c | 28 +++++++++++++++++
 validation/packed-bitfield2.c | 16 ++++++++++
 validation/packed-bitfield3.c | 29 +++++++++++++++++
 validation/packed-bitfield4.c | 19 +++++++++++
 validation/packed-bitfield5.c | 21 +++++++++++++
 6 files changed, 172 insertions(+)
 create mode 100644 validation/packed-bitfield0.c
 create mode 100644 validation/packed-bitfield1.c
 create mode 100644 validation/packed-bitfield2.c
 create mode 100644 validation/packed-bitfield3.c
 create mode 100644 validation/packed-bitfield4.c
 create mode 100644 validation/packed-bitfield5.c

diff --git a/validation/packed-bitfield0.c b/validation/packed-bitfield0.c
new file mode 100644
index 000000000000..f84e7b904a82
--- /dev/null
+++ b/validation/packed-bitfield0.c
@@ -0,0 +1,59 @@
+#define alignof(X)	__alignof__(X)
+#define __packed	__attribute__((packed))
+
+struct sa {
+	int a:7;
+	int c:10;
+	int b:2;
+} __packed;
+_Static_assert(alignof(struct sa) == 1, "alignof(struct sa)");
+_Static_assert( sizeof(struct sa) == 3,  "sizeof(struct sa)");
+
+
+static int get_size(void)
+{
+	return sizeof(struct sa);
+}
+
+static void chk_align(struct sa sa, struct sa *p)
+{
+	_Static_assert(alignof(sa) == 1, "alignof(sa)");
+	_Static_assert(alignof(*p) == 1, "alignof(*p)");
+}
+
+static int fp0(struct sa *sa)
+{
+	return sa->c;
+}
+
+static int fpx(struct sa *sa, int idx)
+{
+	return sa[idx].c;
+}
+
+static int fglobal(void)
+{
+	extern struct sa g;
+	return g.c;
+}
+
+static struct sa l;
+static int flocal(void)
+{
+	return l.c;
+}
+
+
+int main(void)
+{
+	extern void fun(struct sa *);
+	struct sa sa = { 0 };
+
+	fun(&sa);
+	return 0;
+}
+
+/*
+ * check-name: packed-bitfield0
+ * check-known-to-fail
+ */
diff --git a/validation/packed-bitfield1.c b/validation/packed-bitfield1.c
new file mode 100644
index 000000000000..208a3dc5127c
--- /dev/null
+++ b/validation/packed-bitfield1.c
@@ -0,0 +1,28 @@
+#define __packed	__attribute__((packed))
+
+struct s {
+	unsigned int f0:1;
+	unsigned int f1:1;
+	unsigned int pad:6;
+} __packed;
+_Static_assert(sizeof(struct s) == 1,  "sizeof(struct s)");
+
+extern struct s g;
+
+static int foo(struct s *ptr)
+{
+	int f = 0;
+
+	f += g.f0;
+	f += g.f1;
+
+	f += ptr->f0;
+	f += ptr->f1;
+
+	return f;
+}
+
+/*
+ * check-name: packed-bitfield1
+ * check-known-to-fail
+ */
diff --git a/validation/packed-bitfield2.c b/validation/packed-bitfield2.c
new file mode 100644
index 000000000000..4587ebec5c90
--- /dev/null
+++ b/validation/packed-bitfield2.c
@@ -0,0 +1,16 @@
+struct bf2 {
+	unsigned p1:2;
+	unsigned i1:32;
+	unsigned p2:2;
+	unsigned s9:9;
+	unsigned s9:9;
+	unsigned s9:9;
+	unsigned b1:1;
+} __attribute__((packed));
+
+_Static_assert(sizeof(struct bf2) == 8);
+
+/*
+ * check-name: packed-bitfield2
+ * check-known-to-fail
+ */
diff --git a/validation/packed-bitfield3.c b/validation/packed-bitfield3.c
new file mode 100644
index 000000000000..c06e7c41cbcd
--- /dev/null
+++ b/validation/packed-bitfield3.c
@@ -0,0 +1,29 @@
+#define __packed __attribute__((packed))
+
+typedef unsigned char   u8;
+typedef __UINT16_TYPE__ u16;
+typedef __UINT32_TYPE__ u32;
+typedef __UINT64_TYPE__ u64;
+
+struct b {
+	u32	a:1;
+	u32	b:2;
+	u32	c:4;
+	u32	d:8;
+	u32	e:16;
+} __packed;
+_Static_assert(__alignof(struct b) == 1);
+_Static_assert(   sizeof(struct b) == 4);
+
+struct c {
+	u8	a;
+	u8	b;
+	u64	c:48;
+} __packed;
+_Static_assert(__alignof(struct c) == 1);
+_Static_assert(   sizeof(struct c) == 8);
+
+/*
+ * check-name: packed-bitfield3
+ * check-known-to-fail
+ */
diff --git a/validation/packed-bitfield4.c b/validation/packed-bitfield4.c
new file mode 100644
index 000000000000..0342b2414b6e
--- /dev/null
+++ b/validation/packed-bitfield4.c
@@ -0,0 +1,19 @@
+#define __packed __attribute__((packed))
+
+typedef __UINT32_TYPE__ u32;
+
+struct s {
+	u32	f:24;
+} __packed;
+_Static_assert(sizeof(struct s) == 3);
+
+static int ld(struct s *s)
+{
+	return s->f;
+}
+
+/*
+ * check-name: packed-bitfield4
+ * check-description: Is check_access() OK with short packed bitfields?
+ * check-known-to-fail
+ */
diff --git a/validation/packed-bitfield5.c b/validation/packed-bitfield5.c
new file mode 100644
index 000000000000..8f44d4c2c277
--- /dev/null
+++ b/validation/packed-bitfield5.c
@@ -0,0 +1,21 @@
+#define __packed __attribute__((packed))
+
+typedef __UINT32_TYPE__ u32;
+
+struct s {
+	u32	a:5;
+	u32	f:30;
+	u32	z:5;
+} __packed;
+_Static_assert(sizeof(struct s) == 5);
+
+static int ld(struct s *s)
+{
+	return s->f;
+}
+
+/*
+ * check-name: packed-bitfield5
+ * check-description: is check_access() OK with 'overlapping' packed bitfields?
+ * check-known-to-fail
+ */
-- 
2.29.2

