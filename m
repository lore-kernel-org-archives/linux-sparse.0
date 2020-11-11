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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8587C388F9
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3349F208B3
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4Z54kLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgKLBdr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgKKXwn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Nov 2020 18:52:43 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA7C0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 15:52:41 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id o20so4198210eds.3
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 15:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCzkEW5xYB1muF+vJ/f8y4UbBC3rxlh1rEGtYpd9n+A=;
        b=p4Z54kLigVmS52pGYYgv0TvzVirM6B8q2pXATV4e3a8lYsBHkU1U2I5SacNdhrbRSn
         yHhGwSXj8zaOf+JXCvyVJE3GNSfXW3avkG82QVpbWyBtKYgXG2Hyim0lQyv91qhxFnCc
         2pd2S+yaPdZ9ZKrvuKumUN57VrbolKnCZJ9GULXeFkWLvTFbrW9uTwHGM3xyyoKLWpQ7
         g3mew3Ju5+KZePzTtDs2CzKCXsayelIvMmtnGXKT37a9cZCnS6YQqDY9kUL+OzRAG6ii
         qKHQL1KuZJ0PTTU54CvqrW82qW0rxPTXcML2mkg+hCHHMvnHDk+MYGpHMBnyztoISm94
         V7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCzkEW5xYB1muF+vJ/f8y4UbBC3rxlh1rEGtYpd9n+A=;
        b=WCwg1yXZbDtCooOq8wP5kYmRXLXQtdGnDndKR019iohd/6B/IMCWo2A/SfC9svmkNI
         YvoZxVuJr6Ne+lD/ArpWlLmcV+kA0bzSjVJDC1VM4TWPnbpUCZ8EyG3NoLbHczNdCrkS
         1kCcMJzZ3rnEox4Riy/PQhnkh5hPaPn9e/T/wImLBPMRsWWXFXqf8nx3klsyWDvFJV5l
         kXiDWKia5g8R7s470Xk8aSc12/gO3PXb29+NPamYsAQgHNvC96T15ok+LUaFIDiNc40e
         57nwMbS5qc3yLr3AwjaT4pvTXAPJqeGypUDc76oT5pofg7x1k4VAjuzel1RfNidDqmN+
         IlNw==
X-Gm-Message-State: AOAM533NWVImkWjPKCNAxSwvR5rTVF41YYiAAaus1K5wvn572XINr6F8
        d89KTtM0V6aRQdBwGKLei8Unc42kJaU=
X-Google-Smtp-Source: ABdhPJzI+ENj4OV2kyS+JQRy49TT1mnH+Li+o7tG8OQf+CWxQSLyPsqtlNGOtpaDTj7YPc05HgecjA==
X-Received: by 2002:a50:a40a:: with SMTP id u10mr2182841edb.16.1605138760481;
        Wed, 11 Nov 2020 15:52:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:28a7:5fc2:f4ab:be33])
        by smtp.gmail.com with ESMTPSA id 1sm1391398ejt.107.2020.11.11.15.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:52:40 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add testcase for phi-adjusting during BB merge
Date:   Thu, 12 Nov 2020 00:52:31 +0100
Message-Id: <20201111235232.78450-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111235232.78450-1-luc.vanoostenryck@gmail.com>
References: <20201111235232.78450-1-luc.vanoostenryck@gmail.com>
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

