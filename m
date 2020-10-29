Return-Path: <SRS0=Z4Q2=EE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0AC4741F
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Oct 2020 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2AB20791
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Oct 2020 22:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r46kzC38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ2W7M (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Oct 2020 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2W7M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Oct 2020 18:59:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C2C0613CF
        for <linux-sparse@vger.kernel.org>; Thu, 29 Oct 2020 15:59:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p5so6091638ejj.2
        for <linux-sparse@vger.kernel.org>; Thu, 29 Oct 2020 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3P61tOKnoY6cdZ41IxNSoJvKedhYuMiWCEn8xHIGMAE=;
        b=r46kzC38knsHeDSFkfupuozjZujEWdw5vEMTDy638IIPMibuZvCwRiwKTeuEzR3lg/
         Dil9X3430IwfZGB62VX9CWWVBRzOCyoMuwWiKUHtFgTO6rEDjomUGgHVXJOoDs0RzITq
         Mp0aW8lnEMhQkrzv8Ub8NRPbeZrRSzYqSL4mwkluIZRSIuxSbC9b5yqNNwxP8RRFxMdU
         f6kNBP61O41fBGo/h0dQb58W65XvAWTHpmqiG4se/GJoPgXjRGslUTZ7WllkPhPZXPyj
         rg/vlOTikvBTYzuddNjpP5ZebfINqhVR738QviUx41SSW3JFqJMJyzruaUerDdqlSgz3
         ddbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3P61tOKnoY6cdZ41IxNSoJvKedhYuMiWCEn8xHIGMAE=;
        b=VZiTOeoot/BQGVaQAO3iwRokne+wfnl9PNAdxq6LojV4Lx5yjv0ZThJ4VRD8hVDeEm
         /h06r1aFheP1wq1ZZeetCxI6cNpH9UdI6jz5dVH0J952VGkUknAdrt3dOhDtfRwn5K67
         OwMrbO8e9IMBXCJ/ItPJkrjxUWGq56MBoZ5pzUWyi0rSOJna8TBzee0rks1oV6kfbu4d
         1Gd++yiPLYpVibu4D5qb0mgaqAFiEYQpQjyf5HEQMcJIyIGgQvwr+F/jRZZSnz5rUmY2
         2WrKOP7VUFSQLmIcd/ehmEv8IUxoilvOi1eTCFgPC8D+YkV5AO8cwXZBFH84hRjaAObY
         DlTw==
X-Gm-Message-State: AOAM53329TzBg5DTHE9YbZDJSpficP0uuo3TJvt37bKg0thFmrscU/an
        iVuDdW15XP6XvnVtFC3vq4zgfBtHGpk=
X-Google-Smtp-Source: ABdhPJx6c5dCCNVHpdNpY13S+3f3iDSYvqlcyruF+swT0IxklEAVMzWWlVOsN0hmPD0PKAaRjCKtYg==
X-Received: by 2002:a17:906:2b44:: with SMTP id b4mr6266400ejg.73.1604012350787;
        Thu, 29 Oct 2020 15:59:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d5b9:9762:e6d6:4f40])
        by smtp.gmail.com with ESMTPSA id v21sm2175224edt.80.2020.10.29.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:59:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] eval_insn: add testcases for incorrect type in OP_SET_*
Date:   Thu, 29 Oct 2020 23:59:04 +0100
Message-Id: <20201029225905.85037-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029225905.85037-1-luc.vanoostenryck@gmail.com>
References: <20201029225905.85037-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Because of the lack of type information, compare instruction are
not always handled correctly. So, add some testcases for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/cmp-op-type.c | 18 ++++++++++++++++++
 validation/optim/cmp-type0.c   | 13 +++++++++++++
 validation/optim/cmp-type1.c   | 16 ++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 validation/optim/cmp-op-type.c
 create mode 100644 validation/optim/cmp-type0.c
 create mode 100644 validation/optim/cmp-type1.c

diff --git a/validation/optim/cmp-op-type.c b/validation/optim/cmp-op-type.c
new file mode 100644
index 000000000000..037272f84465
--- /dev/null
+++ b/validation/optim/cmp-op-type.c
@@ -0,0 +1,18 @@
+extern int get(void);
+
+static int array[8192];
+
+static int foo(void)
+{
+	int n = -1;
+	if (n < 0)
+		n = get();
+	return array[n];
+}
+
+/*
+ * check-name: cmp-op-type
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ */
diff --git a/validation/optim/cmp-type0.c b/validation/optim/cmp-type0.c
new file mode 100644
index 000000000000..695d082b6aed
--- /dev/null
+++ b/validation/optim/cmp-type0.c
@@ -0,0 +1,13 @@
+static int foo(long long a)
+{
+	return 0LL < (0x80000000LL + (a - a));
+}
+
+/*
+ * check-name: cmp-type0
+ * check-command: test-linearize $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret.*\\$1
+ */
diff --git a/validation/optim/cmp-type1.c b/validation/optim/cmp-type1.c
new file mode 100644
index 000000000000..2fb78a0bb86a
--- /dev/null
+++ b/validation/optim/cmp-type1.c
@@ -0,0 +1,16 @@
+int foo(void)
+{
+	int r;
+	long n;
+	n = 0;
+	return n < 2147483648U;
+}
+
+/*
+ * check-name: cmp-type1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
-- 
2.29.0

