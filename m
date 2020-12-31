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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5297AC433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280B7207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLaKLX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgLaKLX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:11:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C269C061575
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:42 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r7so19702143wrc.5
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rn8kVi3Pl/IgeqSmKaQFydn5Edh0dedaqIMn7SModZg=;
        b=M5u3ALe11S7ja5+ERI9qPF0Z0b8GODI7DTsExsXyFB7EMEkvLWCHRTWx903sOQ8XRQ
         xZyt8D5LkZzwOxQhuK1qH9wVEzpZxdsITSkNZ9cI5hiUnbNZCF19G8lbFJHq8PhLeRfj
         oxBqrj0LIrzCm6KIzcQTSdSaCTsHIMMFzf2542Bv+dnWuofA7gzIfZeGuEo5Uzlnsukr
         XB+XqyD9DJ493bWpYZNVtK/wCm4w9aVx6QDg8bpl4plV8Ox71NOMqzRE3Gsvi2hkH3kk
         glSKLcgAB7624/JI2dQhv+i832fw5e65Ra40S2yoQoKz7/sHK1732d59kyWRGQ+6poki
         Slhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rn8kVi3Pl/IgeqSmKaQFydn5Edh0dedaqIMn7SModZg=;
        b=mmj94Om+1udlbOWTu6mxtmFkgGuo9L2AcDqFzGaUbRNj3DnFBDzHYikrd5QOfRwxig
         +QmhhC04ntKToBM0/7eAdXW98RpYYDjJiox+Vw92wf/1+lhABG51gytMzSsCljwpcoip
         Yatgvmz11kJrsyz4gXo0XvuN5dSUMM6ulWmevGzIZZ0UJvb9QLIgzlMGBtaU8q7L3bqi
         hZUF8LmAEkFNZ+YN/eQFd/h/ubHsqC3e97Ra8Y9EZs91ntlDfQZX0h0D5isbtwfPhEzL
         EYOxhrY/ggqgch1j3hmME97rfncsQGZ3llc1wMtpwdDz25NgIhz5aIVFj6kaCuanZoH8
         DrZA==
X-Gm-Message-State: AOAM530xgOELfn8IqKwfVq6Y9mrQEoyeRhP2FXUVUyPZ98M8VNb9jM1D
        O7tpfbd6Hv3PGsFJyAZkfugXka3Dv/U=
X-Google-Smtp-Source: ABdhPJw51kQffid9SeB/zx9d2LfGViEAukzGSZa9dYW20S+1e59/GgrpgEqRt1MYWFq3tN5zEe2YFA==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr62789102wrx.34.1609409440982;
        Thu, 31 Dec 2020 02:10:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:40 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 01/16] add testcases for dubious enum values
Date:   Thu, 31 Dec 2020 11:10:19 +0100
Message-Id: <20201231101034.59978-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

sparse accept any type of integral value for enumerators
but address constants are also accepted, which is 'strange'.

Add a testcase for such 'enums'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/enum-type-dubious.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 validation/enum-type-dubious.c

diff --git a/validation/enum-type-dubious.c b/validation/enum-type-dubious.c
new file mode 100644
index 000000000000..f2cb39fcdbff
--- /dev/null
+++ b/validation/enum-type-dubious.c
@@ -0,0 +1,18 @@
+enum foobar {
+	FOO = (void*)0,
+	BAR = (void*)1,
+	BAZ = (int*)0,
+	QUX = (int*)123,
+};
+
+/*
+ * check-name: enum-type-dubious
+ * check-known-to-fail
+ *
+ * check-error-start
+validation/enum-type-dubious.c:2:8: error: enumerator value for 'FOO' is not an integer constant
+validation/enum-type-dubious.c:3:8: error: enumerator value for 'BAR' is not an integer constant
+validation/enum-type-dubious.c:4:8: error: enumerator value for 'BAZ' is not an integer constant
+validation/enum-type-dubious.c:5:8: error: enumerator value for 'QUX' is not an integer constant
+ * check-error-end
+ */
-- 
2.29.2

