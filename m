Return-Path: <SRS0=VjVX=AZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E27C433E5
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27691208C3
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSCoiY+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGNAAi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNAAh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 20:00:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C8C061794
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bm28so13365532edb.2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3HP0geDyQzZhv6wmrdw0R8pn1aTQ1gs0lsWbVp/iPVY=;
        b=aSCoiY+HRwFy5Q/zBDcZ6jYh4eQv9d+T8mW34R0D/E8aG/vmsnpj8Lss+ScstUx5ay
         d0jAa4DDqAXhcQFXd7V8EdrXOIgtyp952otar7fR7M/ur83VTLDOy6q/Xwu/6BTo2BES
         xV7o4fgpDFCNIOvAQM9z7HpuwnjNH++Zlzj9TmVso4wKoLQgcvmHgbMk+3kdm4x+q/HR
         PCepXDxS8milSUkipPNUXaAbUmqbYxXmuuBNycmZFpiUpSisF3SfJLZbXrZbYJvT/Sjl
         Chl3oejIhpQBkcNQke+cOyrcOOlfj4KVB7vWDKuyWltAX8/eUzCeKMavNuHvJFkXTXLR
         edCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HP0geDyQzZhv6wmrdw0R8pn1aTQ1gs0lsWbVp/iPVY=;
        b=Jxr7EuWG4rTQ+ns0/oqlhRoR+2aPpUfyG7eHCPMQjlWRoeBg+ABwvsr6B5nHGdC4YW
         pny/jEviILx0en4y+cLIZ0TLtuPtkUrSNtiUpUAY15ca1q3g8+yMp44cOUDNAyIwxLZu
         Tj1Gua92BQNDevbXHfG3DidHHYMado4qqDk4y32kEAc+xvizBVt4jFBQOd2KXr2Jbox8
         Z8VCjR2QlC35YKsBHhUUV1BdxbPE6jV5RXueBPfrRuzJb4E0B86EiMqTa2KaCxbi/sSF
         vQc6v67fhcfwHq2yDtYL4m2+86VlhlcKBgqPgf7A2XvpcEkgqMozDP8veeRrLkg96Ll6
         9qSA==
X-Gm-Message-State: AOAM530uaMKGl3BRY1uc9SVqkjYRpbqq0o9v7dDkfHtSg5v4obTvxYJQ
        YHA0yD/pUK9l0qgRpwgaERxOsHin
X-Google-Smtp-Source: ABdhPJwjDYQqngKyT3zr7pAHNExYIGGxJQIE/D4gYcUIOafDNWuQf4rHFgr3D7+xmhHqAXYVtDlEFQ==
X-Received: by 2002:aa7:c54e:: with SMTP id s14mr1846668edr.81.1594684835185;
        Mon, 13 Jul 2020 17:00:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:5931:bb22:b701:e8f6])
        by smtp.gmail.com with ESMTPSA id z5sm7959443ejw.114.2020.07.13.17.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:00:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcase for incorrect empty expressions
Date:   Tue, 14 Jul 2020 02:00:28 +0200
Message-Id: <20200714000030.85886-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714000030.85886-1-luc.vanoostenryck@gmail.com>
References: <20200714000030.85886-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/empty-assign.c      | 14 ++++++++++++++
 validation/empty-initializer.c | 10 ++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 validation/empty-assign.c
 create mode 100644 validation/empty-initializer.c

diff --git a/validation/empty-assign.c b/validation/empty-assign.c
new file mode 100644
index 000000000000..48ac626ddaed
--- /dev/null
+++ b/validation/empty-assign.c
@@ -0,0 +1,14 @@
+static int foo(int a)
+{
+	a = ;			// KO
+	return a;
+}
+
+/*
+ * check-name: empty-assign
+ * check-known-to-fail
+ *
+ * check-error-start
+empty-assign.c:3:11: error: expression expected before ';'
+ * check-error-end
+ */
diff --git a/validation/empty-initializer.c b/validation/empty-initializer.c
new file mode 100644
index 000000000000..0ca763f699a0
--- /dev/null
+++ b/validation/empty-initializer.c
@@ -0,0 +1,10 @@
+static int i = ;		// KO
+
+/*
+ * check-name: empty-initializer
+ * check-known-to-fail
+ *
+ * check-error-start
+empty-initializer.c:1:16: error: expression expected before ';'
+ * check-error-end
+ */
-- 
2.27.0

