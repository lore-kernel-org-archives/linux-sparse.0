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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F49C433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D75206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhA0Dpa (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbhAZWFW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701FC06178A
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id s24so2239909wmj.0
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVRsNPLUFnv0MZn5XhUmlbwMAhgVh1ZY6p1pgO0Wh3M=;
        b=QuKA81sq+/HzDsz4vEEMZ2BzycrqGj2SeAgcWXZxtaLJGvjyWWFub5y8ZH6pi8x8vg
         B+LpSFwv+4s37R56Ejd3VoXpB96b378bLVr4w2JB4x1noJ+dpWqIloElLcMYpx/UYfyt
         ilQxxiwhd9DcQL4nEvhN5z6hqyGmk5cnqxKeuuwrvyEkI1Bn/zrpjagZytRv0gqGQIfs
         mQQfi0yEcwjRNHTBtNW80vX7Istp2acLcJOBpG5l05IUxIB55qANteB6MjPYeKrg4KQZ
         0cUVgO1LwKQ+aWMEWHi+LTmyRP2K5rPgAshJ3lc49ZPx5duNMdKnlJKzoNRTx46hY7Gz
         egLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVRsNPLUFnv0MZn5XhUmlbwMAhgVh1ZY6p1pgO0Wh3M=;
        b=XX7NQ/Rwh12ewesuLLNKM0B1I1xXpwI27LEkHUG/LxZFVFkYtBeC8pLUKvp9NeID3U
         lBxqdc+X23W5GV3jnBlm/VbMVsa0FRPlhMZItr/pzD1k2eChRZ6lCf3bzYLfVp3rUZ6L
         0+X7Jqb09EZaHxk6qaOMbPwjOTuOLfkhwmSqexDFU7crLQmZLkKgXggVv/Pcak1xEfBf
         MIeINQZmNyk6W5IJYgurOHwg05Tx7FgxASfGNxvqjbBzP2d8p+ncZW9KXfdT/ctSVIXZ
         yQxkmI7m5F5PLfa/gTaxTH/2P37q9bbcESQzXNyNCTAvH+jDsc1YFD/8Aa19CdOu+Zv7
         TS8A==
X-Gm-Message-State: AOAM532IbwVCI1jnkW6LoLczW19Sj2wKBnk/24TikNWf54Ud9PZ2HCba
        3bbW/V7iqquuHn4aSzNyYRY3oNgpkZk=
X-Google-Smtp-Source: ABdhPJxo+SvaEfMdr0KfWQebT6IUZSuREDIcX4N3YO9kX/cNFm48CvRRpubfwW7bzw+hIFkh4lSyDA==
X-Received: by 2002:a05:600c:3515:: with SMTP id h21mr1423793wmq.179.1611698681152;
        Tue, 26 Jan 2021 14:04:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:40 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/10] cmps: add testcases for simplification of signed compares
Date:   Tue, 26 Jan 2021 23:04:26 +0100
Message-Id: <20210126220432.58265-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed compares miss some simplifications/canonicalizations.
Add some testcases for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/canonical-abs.c         | 12 +++++++++++
 validation/optim/canonical-cmpe-minmax.c | 17 ++++++++++++++++
 validation/optim/canonical-cmps-minmax.c | 17 ++++++++++++++++
 validation/optim/canonical-cmps-sel.c    | 26 ++++++++++++++++++++++++
 validation/optim/canonical-cmps.c        | 17 ++++++++++++++++
 validation/optim/cmps-minmax.c           | 17 ++++++++++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 validation/optim/canonical-abs.c
 create mode 100644 validation/optim/canonical-cmpe-minmax.c
 create mode 100644 validation/optim/canonical-cmps-minmax.c
 create mode 100644 validation/optim/canonical-cmps-sel.c
 create mode 100644 validation/optim/canonical-cmps.c
 create mode 100644 validation/optim/cmps-minmax.c

diff --git a/validation/optim/canonical-abs.c b/validation/optim/canonical-abs.c
new file mode 100644
index 000000000000..0809a52d445b
--- /dev/null
+++ b/validation/optim/canonical-abs.c
@@ -0,0 +1,12 @@
+_Bool abs0(int a) { return (a < 0 ? -a : a) == (a >= 0 ? a : -a); }
+_Bool abs1(int a) { return (a < 0 ? -a : a) == (a >  0 ? a : -a); }
+_Bool abs2(int a) { return (a < 0 ? -a : a) == (a <= 0 ? -a : a); }
+
+/*
+ * check-name: canonical-abs1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/canonical-cmpe-minmax.c b/validation/optim/canonical-cmpe-minmax.c
new file mode 100644
index 000000000000..c72819244b95
--- /dev/null
+++ b/validation/optim/canonical-cmpe-minmax.c
@@ -0,0 +1,17 @@
+#define SMAX __INT_MAX__
+#define SMIN (-__INT_MAX__-1)
+
+int le_smax(int a) { return (a <= (SMAX - 1)) == (a != SMAX); }
+int gt_smax(int a) { return (a >  (SMAX - 1)) == (a == SMAX); }
+
+int lt_smin(int a) { return (a <  (SMIN + 1)) == (a == SMIN); }
+int ge_smin(int a) { return (a >= (SMIN + 1)) == (a != SMIN); }
+
+/*
+ * check-name: canonical-cmpe-minmax
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/canonical-cmps-minmax.c b/validation/optim/canonical-cmps-minmax.c
new file mode 100644
index 000000000000..bab09282d241
--- /dev/null
+++ b/validation/optim/canonical-cmps-minmax.c
@@ -0,0 +1,17 @@
+#define SMAX __INT_MAX__
+#define SMIN (-__INT_MAX__-1)
+
+int lt_smax(int a) { return (a <  SMAX) == (a != SMAX); }
+int ge_smax(int a) { return (a >= SMAX) == (a == SMAX); }
+
+int le_smin(int a) { return (a <= SMIN) == (a == SMIN); }
+int gt_smin(int a) { return (a >  SMIN) == (a != SMIN); }
+
+/*
+ * check-name: canonical-cmps-minmax
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/canonical-cmps-sel.c b/validation/optim/canonical-cmps-sel.c
new file mode 100644
index 000000000000..f0a0effc7954
--- /dev/null
+++ b/validation/optim/canonical-cmps-sel.c
@@ -0,0 +1,26 @@
+_Bool sel_lts(int a, int b, int x, int y)
+{
+	return ((a < b) ? x : y) == ((a >= b) ? y : x);
+}
+_Bool sel_les(int a, int b, int x, int y)
+{
+	return ((a <= b) ? x : y) == ((a > b) ? y : x);
+}
+
+_Bool sel_ltu(unsigned int a, unsigned int b, int x, int y)
+{
+	return ((a < b) ? x : y) == ((a >= b) ? y : x);
+}
+_Bool sel_leu(unsigned int a, unsigned int b, int x, int y)
+{
+	return ((a <= b) ? x : y) == ((a > b) ? y : x);
+}
+
+/*
+ * check-name: canonical-cmps-sel
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/canonical-cmps.c b/validation/optim/canonical-cmps.c
new file mode 100644
index 000000000000..f42664b21e04
--- /dev/null
+++ b/validation/optim/canonical-cmps.c
@@ -0,0 +1,17 @@
+_Bool lt_p(int a) { return (a >  0) == (a >=  1); }
+_Bool ge_p(int a) { return (a <= 0) == (a <   1); }
+
+_Bool lt_m(int a) { return (a <  0) == (a <= -1); }
+_Bool ge_m(int a) { return (a >= 0) == (a >  -1); }
+
+_Bool lt_x(int a) { return (a <= 1234) == (a < 1235); }
+_Bool ge_x(int a) { return (a >= 1234) == (a > 1233); }
+
+/*
+ * check-name: canonical-cmps
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmps-minmax.c b/validation/optim/cmps-minmax.c
new file mode 100644
index 000000000000..ded3286cf752
--- /dev/null
+++ b/validation/optim/cmps-minmax.c
@@ -0,0 +1,17 @@
+#define SMAX __INT_MAX__
+#define SMIN (-__INT_MAX__-1)
+
+int lt_smin(int a) { return (a <  SMIN) == 0; }
+int le_smax(int a) { return (a <= SMAX) == 1; }
+
+int ge_smin(int a) { return (a >= SMIN) == 1; }
+int gt_smax(int a) { return (a >  SMAX) == 0; }
+
+/*
+ * check-name: cmps-minmax
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.30.0

