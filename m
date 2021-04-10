Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B9C433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8274A61106
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhDJWbP (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhDJWbO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 18:31:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B545C06138B
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so14189489ejc.4
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oxTn68I0PL9raL5wwogcYdhxb94zet/WC/d5B/Uq/8=;
        b=c5fIbPtxQFBCIelUn/rqMETyQHNhQSrZhD4z/t02/wO11/OYPeLf/UTLQSsf2zbQES
         /iEqqFJIR8DyRF6ft7ofmlJcswRo/Dx+pdt7Jh87QuX7gtuXPeU5LZ2B6U//5gQrzcI+
         dqBmcCbN68Xe4en3+iawXfQBy3zq6OszxgNxZMUTeFUzmZwAyO8iT6WWr7pstA/pH4yO
         9OpdgY07dscxcqeN17jrf1fEH3lCETPa5Jo8/pX2ZppYWLq5EZH+5o24pXfBKzloeHK7
         Vu1TiVIoWM8kQZuUFMsgY5z8oolZ5G3DN89CboYu2Hw8NXXs1H/2pWLde3EhqiMbBUXE
         4fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oxTn68I0PL9raL5wwogcYdhxb94zet/WC/d5B/Uq/8=;
        b=PG39BoVG/Doszzr+p5ihf/5AmyYX1CHVkiU8KOn2Y1hmS/KdA3+IczgjOFhul3p1S6
         5yOJTdg3sXgOPLYYEuPI5qIBxD/IStYbyp5HDXdAKglv4+/fUAJN5PvQo6ugUBU9UGyD
         crwhbKcSeVEFvA2DOlxsGVWTVS6XkiA291AMa/obb2Fndt1Yg8ZWzV/mV/ydVPGmZ8YF
         fq+n+p+nKVriMsSllhhrWPe8CBqY4vJzS0VaQj7+8nHhlf5LMUc77eur70kNi9iEDOrS
         o9/PLDWGuGMpRqOR1E0Ohsi9/heRLMFMjddga3nTbFOY2QVqyxOC8HmQD17BvI+Jg/uR
         m1fA==
X-Gm-Message-State: AOAM5300oGIUMOiSgLg8cAcLLHh7sXx5LVRn7V1y+CKyyGofp01KPNwV
        2SA8Fe8C5sy95C44JYYOrRAQqxarwYw=
X-Google-Smtp-Source: ABdhPJyjk8KGchJlP7PFDMmimsmoo8Y23oEw/7jiiwffH31miTmHsFqhcvk/o2ebBnHfRWt7EV5PKA==
X-Received: by 2002:a17:906:48c4:: with SMTP id d4mr1812818ejt.548.1618093856842;
        Sat, 10 Apr 2021 15:30:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9597:4a1:b5b6:4666])
        by smtp.gmail.com with ESMTPSA id q18sm3701372edr.26.2021.04.10.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 15:30:56 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] add testcases for stores simplifications
Date:   Sun, 11 Apr 2021 00:30:40 +0200
Message-Id: <20210410223044.86100-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
References: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/memops/kill-dead-store-parent0.c | 15 ++++++++++++
 validation/memops/kill-dead-store-parent2.c | 26 +++++++++++++++++++++
 validation/memops/kill-redundant-store0.c   | 14 +++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 validation/memops/kill-dead-store-parent0.c
 create mode 100644 validation/memops/kill-dead-store-parent2.c
 create mode 100644 validation/memops/kill-redundant-store0.c

diff --git a/validation/memops/kill-dead-store-parent0.c b/validation/memops/kill-dead-store-parent0.c
new file mode 100644
index 000000000000..1413134b8c23
--- /dev/null
+++ b/validation/memops/kill-dead-store-parent0.c
@@ -0,0 +1,15 @@
+void foo(int *ptr, int p)
+{
+	if (p)
+		*ptr = 1;
+	*ptr = 0;
+}
+
+/*
+ * check-name: kill-dead-store-parent0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(1): store
+ */
diff --git a/validation/memops/kill-dead-store-parent2.c b/validation/memops/kill-dead-store-parent2.c
new file mode 100644
index 000000000000..b563fd31b669
--- /dev/null
+++ b/validation/memops/kill-dead-store-parent2.c
@@ -0,0 +1,26 @@
+int ladder02(int *ptr, int p, int x)
+{
+	*ptr = x++;
+	if (p)
+		goto l11;
+	else
+		goto l12;
+l11:
+	*ptr = x++;
+	goto l20;
+l12:
+	*ptr = x++;
+	goto l20;
+l20:
+	*ptr = x++;
+	return *ptr;
+}
+
+/*
+ * check-name: kill-dead-store-parent2
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(1): store
+ */
diff --git a/validation/memops/kill-redundant-store0.c b/validation/memops/kill-redundant-store0.c
new file mode 100644
index 000000000000..e911166dd953
--- /dev/null
+++ b/validation/memops/kill-redundant-store0.c
@@ -0,0 +1,14 @@
+void foo(int *ptr)
+{
+	int i = *ptr;
+	*ptr = i;
+}
+
+/*
+ * check-name: kill-redundant-store0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: store
+ */
-- 
2.31.1

