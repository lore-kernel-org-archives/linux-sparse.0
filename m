Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D51C4741F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835AF2076B
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GznDmN8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgI3XSp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgI3XSg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2118C061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so1140640wmi.0
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M710i58RkfmQFQ+xtAJYFUkWitVKVEfpIwfolwAKIqg=;
        b=GznDmN8zhiw6HEmTZKTf5cK0seGXepQH0xm2qHItpRAnODt+UoSndJ7CAA/ptHYpL2
         a4KbXuI78USybHnEd2TzQi3cONRPRO+/jg+yHWPKcI1rWkgdUxRype91FGmsomUBhqUP
         TKt8rJYbASDnPtS9eXm/p/tGclUsflEmLjlWFoxxHYCknYN7rWLtu0yKgqFh/gb66oCw
         Zv8vnxCaP+7M3qnacjI9xXJEyjn3dxXJ4G2sTFlfGJGEPcbP293MijV0f+srsP937eYO
         isq70VfgmSDib6p/at2+HiLlzF2KnrWvMHmNNMi8ODi6sJTi+sGc+XUCqyP6zsxurmJz
         rsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M710i58RkfmQFQ+xtAJYFUkWitVKVEfpIwfolwAKIqg=;
        b=g4iPIwK+F8CgunAXwD6rKmeAqzgkc5DWb68EFDNTkMnGg//C2SrgxiJ4oR7zurJjys
         /rpJcRAeO10MOW/v7PPSSPH6OKLj0x7piRcOzq3viU4uWEsqeN5G19d5pKQDcfGYRSTp
         xW4et6XJvbrSHEFtszw263/NRfSsV2xS7j3rGNtEmG0+PvxLwslhTJ6LYcooN1I875UH
         NtP5sjBYNs3IlBzumOKy5a8ZuECxvNNJWJ672oT/5bwT2oQmj5Wss2qZKeu8ZhWnNi3o
         V2nJOUcO2Y/6phN88/ywijlWZZCDAmrlt3AmEV7LBegCwffUXhDMy4QG5utzL3epjd3J
         Rrmw==
X-Gm-Message-State: AOAM532vjwi0eCysbvNmmIvfy5cbOz6SVSwrhMRSmgqGhMdo98EsQ6eq
        J70c0nhnqFZBg/JQ36J/3P0MW8iPAx4=
X-Google-Smtp-Source: ABdhPJxRuT5x32Zb5KubRbZnY+xfuuqi4CFy0KO9MZXkYRE3Bw5lrJm6ARsEVOEt1WM6qMybU7WzCg==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr4714524wmh.21.1601507914030;
        Wed, 30 Sep 2020 16:18:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:33 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/13] flex-array: add testcases
Date:   Thu,  1 Oct 2020 01:18:16 +0200
Message-Id: <20200930231828.66751-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/flex-array-align.c   | 19 +++++++++++++++++++
 validation/flex-array-array.c   | 16 ++++++++++++++++
 validation/flex-array-error.c   | 27 +++++++++++++++++++++++++++
 validation/flex-array-nested.c  | 30 ++++++++++++++++++++++++++++++
 validation/flex-array-padding.c | 22 ++++++++++++++++++++++
 validation/flex-array-sizeof.c  | 19 +++++++++++++++++++
 6 files changed, 133 insertions(+)
 create mode 100644 validation/flex-array-align.c
 create mode 100644 validation/flex-array-array.c
 create mode 100644 validation/flex-array-error.c
 create mode 100644 validation/flex-array-nested.c
 create mode 100644 validation/flex-array-padding.c
 create mode 100644 validation/flex-array-sizeof.c

diff --git a/validation/flex-array-align.c b/validation/flex-array-align.c
new file mode 100644
index 000000000000..0cc67ab36997
--- /dev/null
+++ b/validation/flex-array-align.c
@@ -0,0 +1,19 @@
+struct s {
+	__INT32_TYPE__ x;
+	__INT16_TYPE__ y;
+	unsigned char f[];
+};
+
+static int foo(struct s *s)
+{
+	return (sizeof(*s) << 16) | __builtin_offsetof(typeof(*s), f);
+}
+
+/*
+ * check-name: flex-array-align
+ * check-command: test-linearize -Wno-flexible-array-sizeof $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$0x80006
+ */
diff --git a/validation/flex-array-array.c b/validation/flex-array-array.c
new file mode 100644
index 000000000000..bda80d7a0a20
--- /dev/null
+++ b/validation/flex-array-array.c
@@ -0,0 +1,16 @@
+struct s {
+	int i;
+	long f[];
+};
+
+static struct s a[2];
+
+/*
+ * check-name: flex-array-array
+ * check-command: sparse -Wflexible-array-array $file
+ * check-known-to-fail
+ *
+ * check-error-start
+flex-array-array.c:6:18: warning: array of flexible structures
+ * check-error-end
+ */
diff --git a/validation/flex-array-error.c b/validation/flex-array-error.c
new file mode 100644
index 000000000000..89601e42daf6
--- /dev/null
+++ b/validation/flex-array-error.c
@@ -0,0 +1,27 @@
+struct s {
+	int i;
+	long f[];
+	int j;
+};
+
+union u {
+	int i;
+	long f[];
+};
+
+// trigger the examination of the offending types
+static int foo(struct s *s, union u *u)
+{
+	return    __builtin_offsetof(typeof(*s), i)
+		+ __builtin_offsetof(typeof(*u), i);
+}
+
+/*
+ * check-name: flex-array-error
+ * check-known-to-fail
+ *
+ * check-error-start
+flex-array-error.c:3:14: error: flexible array member 'f' is not last
+flex-array-error.c:9:14: error: flexible array member 'f' in a union
+ * check-error-end
+ */
diff --git a/validation/flex-array-nested.c b/validation/flex-array-nested.c
new file mode 100644
index 000000000000..3503c329d7c3
--- /dev/null
+++ b/validation/flex-array-nested.c
@@ -0,0 +1,30 @@
+struct f {
+	int i;
+	long f[];
+};
+
+struct s {
+	struct f f;
+};
+
+union u {
+	struct f f;
+};
+
+// trigger the examination of the offending types
+static int foo(struct s *s, union u *u)
+{
+	return    __builtin_offsetof(typeof(*s), f)
+		+ __builtin_offsetof(typeof(*u), f);
+}
+
+/*
+ * check-name: flex-array-nested
+ * check-command: sparse -Wflexible-array-nested $file
+ * check-known-to-fail
+ *
+ * check-error-start
+flex-array-nested.c:6:8: warning: nested flexible arrays
+flex-array-nested.c:10:7: warning: nested flexible arrays
+ * check-error-end
+ */
diff --git a/validation/flex-array-padding.c b/validation/flex-array-padding.c
new file mode 100644
index 000000000000..2ba77971266e
--- /dev/null
+++ b/validation/flex-array-padding.c
@@ -0,0 +1,22 @@
+struct s {
+	__INT32_TYPE__ x;
+	__INT16_TYPE__ y;
+	unsigned char f[];
+};
+
+static int foo(struct s *s)
+{
+	return __builtin_offsetof(typeof(*s), f);
+}
+
+/*
+ * check-name: flex-array-padding
+ * check-command: test-linearize -Wflexible-array-padding $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ *
+ * check-error-start
+flex-array-padding.c:4:23: warning: flexible array member has padding
+ * check-error-end
+ */
diff --git a/validation/flex-array-sizeof.c b/validation/flex-array-sizeof.c
new file mode 100644
index 000000000000..3359509d0084
--- /dev/null
+++ b/validation/flex-array-sizeof.c
@@ -0,0 +1,19 @@
+struct s {
+	int i;
+	long f[];
+};
+
+static int foo(struct s *s)
+{
+	return sizeof(*s);
+}
+
+/*
+ * check-name: flex-array-sizeof
+ * check-command: sparse -Wflexible-array-sizeof $file
+ * check-known-to-fail
+ *
+ * check-error-start
+flex-array-sizeof.c:8:16: warning: using sizeof on a flexible structure
+ * check-error-end
+ */
-- 
2.28.0

