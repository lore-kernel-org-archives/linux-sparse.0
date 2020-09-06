Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914A3C433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E8420C09
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn0BNdgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIFMlN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgIFMlI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 08:41:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A7DC061573
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 05:40:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so10049417edk.6
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKOOwWUHAHq3BdSfYEjSQTKHFN7u8QKMUwhamgd6olU=;
        b=kn0BNdgBg7M9syUGCjUdjkgsdRASuBAFk85Tlph6OvuK9a6oH7ecRQubjkHhQ4K/St
         BKzQgDtvwKIiO5SnFUPEmIFeIDQXAUAXUlqweFDafr/fGpCJy+aZ0smi1jRrNFvU3424
         lXpMc4cPX0w1PXpEP/NrsAEl0wzbVyF3VwczCyQ6cUnZ37cIxcbIx30Y2v3W9DEi0nsS
         RpUcqIionyczAaE3234c8jH+43MYOJ4PvDm2BvrAtO03zKYHQ6CCyRILTZ70xZksT1+l
         Pqi9TJ8luJE7CX4uYOy5opYUeWE3RMUdy3CJ3HOyQQofGSC6kNZDL12z0amrid8bu4XE
         +D1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKOOwWUHAHq3BdSfYEjSQTKHFN7u8QKMUwhamgd6olU=;
        b=cJVhKO1mKv3Ztxq114HJCnX1UaKsFfODcg2OQY/PTs5Ke/Ngx/G7c3NEPYo6ohVkyT
         myB76z6BmNBYJfYYfSOVSCp4wh/oEb4IA0fGQRIDrioPqCb6WpQsAZkN3/zj9Vxsq9qf
         7CTRMV4XHxUwnce3kfaC2JuA9ktMp77priSRpZv3YsvjNtZUYWTNwdfwdJEF0ebeyemP
         v1olIvtDI1PdP3wc3Drddb3m8G/lcNCBzbmbAzOEPBEd37OT6QCTc+AbOgtypRlnJ06Y
         2rN18BhX4UoRqmfMDUcTphqeuk5Jz3FAE80imp2CYsBvWkQxGa9SHi5vbnsrvV3FK5Gh
         voew==
X-Gm-Message-State: AOAM531EsH0S/jqI0T1wN7qpyv1Bz0oHmys0fxKbpqzi7NMn/aqawzqV
        Mms3rzxpiWrNyfFvb9NnlMlOAAV0OeM=
X-Google-Smtp-Source: ABdhPJxkgQpURlQctBcSymW9HxgrUM2Z/i7D+gJKTMLm0QULePBt7FCeZIsmgXVAdexwUXFGSuFeiA==
X-Received: by 2002:a05:6402:644:: with SMTP id u4mr16889814edx.182.1599396044112;
        Sun, 06 Sep 2020 05:40:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:6c5d:e4e0:a162:77b6])
        by smtp.gmail.com with ESMTPSA id b6sm11591124eds.46.2020.09.06.05.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 05:40:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add more testcases for existing AND/OR simplifications
Date:   Sun,  6 Sep 2020 14:40:36 +0200
Message-Id: <20200906124038.46786-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add a few more testcases to catch possible future regressions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/and-shl-or-and0.c  | 13 +++++++++++++
 validation/optim/lsr-or-and0.c      | 23 +++++++++++++++++++++++
 validation/optim/shl-or-constant0.c | 12 ++++++++++++
 validation/optim/shl-or-constant1.c | 12 ++++++++++++
 validation/optim/shl-or-constant2.c | 12 ++++++++++++
 5 files changed, 72 insertions(+)
 create mode 100644 validation/optim/and-shl-or-and0.c
 create mode 100644 validation/optim/lsr-or-and0.c
 create mode 100644 validation/optim/shl-or-constant0.c
 create mode 100644 validation/optim/shl-or-constant1.c
 create mode 100644 validation/optim/shl-or-constant2.c

diff --git a/validation/optim/and-shl-or-and0.c b/validation/optim/and-shl-or-and0.c
new file mode 100644
index 000000000000..ea08d2622a95
--- /dev/null
+++ b/validation/optim/and-shl-or-and0.c
@@ -0,0 +1,13 @@
+unsigned and_shl_or_and0(unsigned a, unsigned b)
+{
+	return (((a & 0xfff00000) | b) << 12) & 0xfff00000;
+}
+
+/*
+ * check-name: and-shl-or-and0
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: or\\.
+ * check-output-excludes: lsr\\.
+ */
diff --git a/validation/optim/lsr-or-and0.c b/validation/optim/lsr-or-and0.c
new file mode 100644
index 000000000000..3c369cb9497e
--- /dev/null
+++ b/validation/optim/lsr-or-and0.c
@@ -0,0 +1,23 @@
+#define	S	12
+
+//	((x & M) | b) >> S;
+// ->	((x >> S) & (M >> S)) | (b >> S)
+// 0a:  (M >> S) == 0
+// 0b:  (x >> S) == 0
+// 0c:  (b >> S) == 0
+
+int lsr_or_and0a(unsigned int x, unsigned int b)
+{
+	return ((x & 0x00000fff) | b) >> S;
+}
+
+/*
+ * check-name: lsr-or-and0
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-pattern(1): lsr\\.
+ * check-output-excludes: %arg1\\.
+ * check-output-excludes: and\\.
+ * check-output-excludes: or\\.
+ */
diff --git a/validation/optim/shl-or-constant0.c b/validation/optim/shl-or-constant0.c
new file mode 100644
index 000000000000..25347b4b3b20
--- /dev/null
+++ b/validation/optim/shl-or-constant0.c
@@ -0,0 +1,12 @@
+unsigned shl_or_constant0(unsigned a)
+{
+	return (a | 0xfff00000) << 12;
+}
+
+/*
+ * check-name: shl-or-constant0
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: or\\.
+ */
diff --git a/validation/optim/shl-or-constant1.c b/validation/optim/shl-or-constant1.c
new file mode 100644
index 000000000000..cd3ea8bb011b
--- /dev/null
+++ b/validation/optim/shl-or-constant1.c
@@ -0,0 +1,12 @@
+unsigned shl_or_constant1(unsigned a)
+{
+	return (a | 0x000fffff) << 12;
+}
+
+/*
+ * check-name: shl-or-constant1
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$0xfffff000
+ */
diff --git a/validation/optim/shl-or-constant2.c b/validation/optim/shl-or-constant2.c
new file mode 100644
index 000000000000..9dbde3b574d7
--- /dev/null
+++ b/validation/optim/shl-or-constant2.c
@@ -0,0 +1,12 @@
+unsigned shl_or_constant1(unsigned a)
+{
+	return (a | 0x00ffff0f) << 12;
+}
+
+/*
+ * check-name: shl-or-constant2
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: or\\..*\\$0xfff0f
+ */
-- 
2.28.0

