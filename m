Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4F2C5519F
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F397D20E65
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRs6jVlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgKPW3g (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKPW3g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:36 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80EC0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:35 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id y17so21020064ejh.11
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCzkEW5xYB1muF+vJ/f8y4UbBC3rxlh1rEGtYpd9n+A=;
        b=nRs6jVlBu+PUCiQkJARlS4127ZhkRr5FgC9Y0tCMHi8YkeNXt0Q6N54Wr+P01DIGUZ
         zYaYyOtKChVCuU0f+V9HLHAeYBMzOsQ2V8H2iNCagmjN6OUvh+AmTIXiOj3xJFd+LXQ1
         O6qEhBF4Djq9T4hm9hTtWdtIRsaIRT790UYccvlw/OOMhnwDMtZAkAp8Ug4bcSLOCPVJ
         5GQpeTaWiV+CDM8q2z0zesAgzkamBqeYTcG0My385jz0f1ZoB12gZDol8zuDg3vGUo9v
         pTUyirU2XuV0MY89QnA3AkefWNPAeubN7/nRI8WgsRjlODQzoNQ6HJ82dGz8nfl43YN6
         DbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCzkEW5xYB1muF+vJ/f8y4UbBC3rxlh1rEGtYpd9n+A=;
        b=LEkvXA8OONNaDrYWAoal43f0zPiT0GZypOeZUs5d8sy0XbuPDS5riikXbhnoBpnhjv
         MZAHSK8c/mECvVsi5y7b2u22BClKsJnbdwLIu6DJIWRaKDiGmftkAajCXqJaGL7rdwsj
         z7cNEeGX6HLkzi5lf6qYcXFN5fmTIee69+BoaSgzyUPF0j2Li0jTNQwOsbBLk+wXwHQA
         WaSRu+hinqFd8g7eACwaPyaTRApL7CKA5sV91wUB955FSUBfguh1+qbVxsDuBn690zUe
         s0kbUA+Xa+VwtCweYIYShCHirqAHad9esvMdu96Aw1tQm1GFAwyIs5shBGhX3u4kv9Yb
         VKuQ==
X-Gm-Message-State: AOAM533d8jBvSmz+ir0P7U4NHDUCk0oBvXFVRoQnGhbepULEU7xriPIn
        ZVk8kyXLNeSidPTdUmGQ+SZ0i8xqV0E=
X-Google-Smtp-Source: ABdhPJwfR8j5dJGVWOhSIIabgm3V9RJvKYNcE4FNopozzaQgWI1BpqseasYqwEaWYm88Wcl7R26Wuw==
X-Received: by 2002:a17:906:1804:: with SMTP id v4mr16723142eje.201.1605565774417;
        Mon, 16 Nov 2020 14:29:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:33 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] cfg: add testcase for phi-adjusting during BB merge
Date:   Mon, 16 Nov 2020 23:29:21 +0100
Message-Id: <20201116222927.51939-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When merging BBs, phi-sources from the bottom BB should 'overwrite'
the ones from the top BB which should be ignored.

Add a testcase from the incoming fix.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/merge_bbe-adjust_phi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 validation/optim/merge_bbe-adjust_phi.c

diff --git a/validation/optim/merge_bbe-adjust_phi.c b/validation/optim/merge_bbe-adjust_phi.c
new file mode 100644
index 000000000000..de4c54cc6d49
--- /dev/null
+++ b/validation/optim/merge_bbe-adjust_phi.c
@@ -0,0 +1,24 @@
+extern int array[2];
+
+static inline int stupid_select(int idx)
+{
+	if (idx)
+		idx = 0;
+	return array[idx];
+}
+
+int select(void)
+{
+	int d = stupid_select(-1);
+	return d;
+}
+
+/*
+ * check-name: merge_bbe-adjust_phi
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: phisrc\\.
+ * check-output-excludes: phi\\.
+ */
-- 
2.29.2

