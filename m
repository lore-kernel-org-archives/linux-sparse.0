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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D19C433DB
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D1B217A0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgLZRxT (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgLZRxT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308BC061795
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c133so5767444wme.4
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FsgSSJ3L+SQlgN20WsY0uEPVgxCYkCt7Sgya9wWuCy8=;
        b=h1Z2CUTBPf8uJwFje3ROMuDSDofKBgWr8/8zPJi8iIBGO1/00WoA+MTkjhWPvlfLBv
         ao03ZCqYnXGQ5DE8wKI/KbZv3Bd3P3FcG8eztsHGLsHoOssvFQLXJHRE26+Zd8o9U6bj
         N8dG3LO/48Zj60Tqimd6lflTvRpBkXjlPcCzKUJ+RzwP8ALTall7Q7bZHNnmajexDapf
         yCbCVNpEY0vSwMlqIO/zNicHWLv7Rteu8Aw+KsO/AV57D6QCOwg+65Y2rqHKRaZnf6wb
         FEpKo3S0yb6lJYqpNtTqR9hYOhV/WadTeq3xtvM53NPWOPYCsOdykJSefJflbmRe5RoI
         petw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FsgSSJ3L+SQlgN20WsY0uEPVgxCYkCt7Sgya9wWuCy8=;
        b=UZb3T6c7X1zigUcGdeuxy4v/EKIHhgC9vPpCUa0J/oLxUsAgigIbosJW7VDKRY+TSG
         4lhFHB1PzbO72bZ5U2l10Gw+rl6SlYfWciz89bjKRychs3oaBvjiF9ylwxJwkQoBqt7B
         6PDmOIjnEMIxJmtrFrQ8m7P5VuvLZVIB/lbDEl5Q1LFx3Gjtqa+UTvOKJ9H7gqTioV6w
         sEVmbJbArL2he+yyM9h7trAYovXZ/ctniVMdrNgI0WTzmOW+B5H2eqEXgLUdgZotu+lR
         D6FrVSWK18mBz6ZS8kO6cC56NwMqaYEhdFQqE+y7JeyEEUg7EKuRwmHud1yJhwcG+i3q
         UrLg==
X-Gm-Message-State: AOAM531CL6/lSaRL5wUhOIaOIFgPb4V77QjbFY4DvE7k9UIS/uQWlSpb
        TzZqwj5OQbafKSdO9i8eKdFLB7tSAec=
X-Google-Smtp-Source: ABdhPJz8q2Rhf/YBbLso5CV2CpPDK4P9TkeCDPHMm4OyCn1NDpa/IGdxeI4RNPzHj7NG5Y2LBRmmCA==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr13603106wmh.185.1609005121740;
        Sat, 26 Dec 2020 09:52:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:01 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 06/16] add testcases for packed bitfields
Date:   Sat, 26 Dec 2020 18:51:19 +0100
Message-Id: <20201226175129.9621-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, packed bitfields are not handled correctly.

Add some testcases for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/packed-bitfield0.c | 67 +++++++++++++++++++++++++++++++++++
 validation/packed-bitfield1.c | 28 +++++++++++++++
 validation/packed-bitfield2.c | 16 +++++++++
 validation/packed-bitfield3.c | 29 +++++++++++++++
 validation/packed-bitfield4.c | 19 ++++++++++
 validation/packed-bitfield5.c | 21 +++++++++++
 6 files changed, 180 insertions(+)
 create mode 100644 validation/packed-bitfield0.c
 create mode 100644 validation/packed-bitfield1.c
 create mode 100644 validation/packed-bitfield2.c
 create mode 100644 validation/packed-bitfield3.c
 create mode 100644 validation/packed-bitfield4.c
 create mode 100644 validation/packed-bitfield5.c

diff --git a/validation/packed-bitfield0.c b/validation/packed-bitfield0.c
new file mode 100644
index 000000000000..907500dedbf0
--- /dev/null
+++ b/validation/packed-bitfield0.c
@@ -0,0 +1,67 @@
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
+struct __packed sb {
+	int a:7;
+	int c:10;
+	int b:2;
+};
+_Static_assert(alignof(struct sb) == 1, "alignof(struct sb)");
+_Static_assert( sizeof(struct sb) == 3,  "sizeof(struct sb)");
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
index 000000000000..6acff875299f
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
+_Static_assert(   sizeof(struct b) == sizeof(u32));
+
+struct c {
+	u8	a;
+	u8	b;
+	u64	c:48;
+} __packed;
+_Static_assert(__alignof(struct c) == 1);
+_Static_assert(   sizeof(struct c) == sizeof(u64));
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

