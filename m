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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6042AC433E9
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B64C6511F
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhCIXmr (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhCIXmj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 Mar 2021 18:42:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83281C06174A
        for <linux-sparse@vger.kernel.org>; Tue,  9 Mar 2021 15:42:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w9so24046476edc.11
        for <linux-sparse@vger.kernel.org>; Tue, 09 Mar 2021 15:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wz7JQ0OrzzITtZbsc9a+g1KoRJ0GXqBxQR5f1BRXLF4=;
        b=RB59b/O8KSlS51Y8wJas3TebtsoHmatibtjAxVfS8v8dlAez5xri3Ee9xTeBnN/6rQ
         WLQcIaERWvFUd/NhNR8f4O3VsYoyVNIjNfT1vDqFTnBL2yLxzITjSWQ3tV2lbBETEjtX
         7Iq1GUyQl6KxJDrV44TlKF+fYNX0ladLd53nlmGNAckNbXZqhpMxep4o4vxNhmvXcYLX
         9MVHHXqbTpDBqe5t1Yk8Mk8ZXTY0MejhdFbdUzYVQDyrJU9Smz++YPczZWqsqcnSaltA
         UwyUNHkddS6Q64yIuqO4KUZF1RsByb++EtVZ2nUTI7mhx+gvIKxdJVFlt9ZfEShcx/sG
         NibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wz7JQ0OrzzITtZbsc9a+g1KoRJ0GXqBxQR5f1BRXLF4=;
        b=cSpD9I62r7ExQFn46k8Hg4ZQNox/9YQ07j7JcozCb97PaVlkpZonGmEg+TTUuIALIb
         A8xATXktaK16ollvXC/aQG1Cs2VJ8m8cyIoB5IaoR81QfIwwedEO5Op9BdooE39OhlGz
         0BLBnBy2zZWYHKF3Nvrt1YRibzgDEeYaxP9qS3xHkdzKZB8tGiKK8jq5i3ZVxPpo7xXF
         vsCCkiro0CzgmDB5IPMHU6EWjNMltPCglQ3ak2/0vA2q5NpPJC4mtJz0pSpy3uNF9jYS
         1Hq6rKb2PTsRrRShoDhzYhmW95ZFutFj8co8R1DELyUnbBfJYHeJ+/YWUCaxi1mXBdbm
         C+wQ==
X-Gm-Message-State: AOAM533iyh4i1FoblkB6qODtKz2lWH/SZFOo9UoeHUoiiTd3WkgUeKIO
        m8VbTd0IK/LEdBhfcjMwBoWvtULEQKk=
X-Google-Smtp-Source: ABdhPJw5ZxCfR5s6YwgDNT+RR8HJa1AVVWMD7wxsFhPW77MmotckvT+AL/Dr4xDS9mX1qmHEG2Zg7w==
X-Received: by 2002:a05:6402:1c98:: with SMTP id cy24mr159823edb.296.1615333358320;
        Tue, 09 Mar 2021 15:42:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:1dad:50b9:7959:c788])
        by smtp.gmail.com with ESMTPSA id cw14sm10147984edb.8.2021.03.09.15.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 15:42:37 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] ssa: add some testcases for mismatched memops
Date:   Wed, 10 Mar 2021 00:42:29 +0100
Message-Id: <20210309234232.50889-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
References: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The SSA conversion is incorrect when the size or offset of the
memory operations doesn't match. It shouldn't be done at all.

So, add a few testcases for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/mem2reg/not-same-memop0.c | 49 ++++++++++++++++++++++++++++
 validation/mem2reg/packed-bitfield.c | 36 ++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 validation/mem2reg/not-same-memop0.c
 create mode 100644 validation/mem2reg/packed-bitfield.c

diff --git a/validation/mem2reg/not-same-memop0.c b/validation/mem2reg/not-same-memop0.c
new file mode 100644
index 000000000000..7a84ddce4efc
--- /dev/null
+++ b/validation/mem2reg/not-same-memop0.c
@@ -0,0 +1,49 @@
+struct s {
+	int:16;
+	short f:6;
+};
+
+static short local(struct s s)
+{
+	return s.f;
+}
+
+static void foo(struct s s)
+{
+	while (s.f) ;
+}
+
+/*
+ * check-name: not-same-memop0
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-known-to-fail
+ *
+ * check-output-start
+local:
+.L0:
+	<entry-point>
+	store.32    %arg1 -> 0[s]
+	load.16     %r1 <- 2[s]
+	trunc.6     %r2 <- (16) %r1
+	sext.16     %r3 <- (6) %r2
+	ret.16      %r3
+
+
+foo:
+.L2:
+	<entry-point>
+	store.32    %arg1 -> 0[s]
+	br          .L6
+
+.L6:
+	load.16     %r5 <- 2[s]
+	trunc.6     %r6 <- (16) %r5
+	setne.1     %r7 <- %r6, $0
+	cbr         %r7, .L6, .L5
+
+.L5:
+	ret
+
+
+ * check-output-end
+ */
diff --git a/validation/mem2reg/packed-bitfield.c b/validation/mem2reg/packed-bitfield.c
new file mode 100644
index 000000000000..4eaf0befeaf5
--- /dev/null
+++ b/validation/mem2reg/packed-bitfield.c
@@ -0,0 +1,36 @@
+struct s {
+	int:16;
+	int f:16;
+} __attribute__((__packed__));
+
+static void foo(struct s s)
+{
+	while (s.f)
+		;
+}
+
+/*
+ * check-name: packed-bitfield
+ * check-command: test-linearize -fmem2reg $file
+ * check-known-to-fail
+ *
+ * check-output-contains: store.32
+ * check-output-contains: load.16
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	store.32    %arg1 -> 0[s]
+	br          .L4
+
+.L4:
+	load.16     %r1 <- 2[s]
+	cbr         %r1, .L4, .L3
+
+.L3:
+	ret
+
+
+ * check-output-end
+ */
-- 
2.30.0

