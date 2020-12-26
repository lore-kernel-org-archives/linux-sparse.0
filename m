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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2856FC433DB
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC50B20809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgLZRwj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgLZRwj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:52:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1EFC0613C1
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:51:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y23so5686065wmi.1
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rn8kVi3Pl/IgeqSmKaQFydn5Edh0dedaqIMn7SModZg=;
        b=vf/seq+nlFd0+4mHYS+UD7twUdJ9+p5i5AIEmDDKy5vWxju+P27uZU535sGdjMUSk7
         D4jg7f8R+mQrM01HGh3dPDEH6deV7bZvJTc6NEH13mk7RaALUhDJbwVl3lF6Mc4auwQE
         6n/0EbMykVVI5MCCdbpf9zNtDFLznAnSPEIhh0uJYU4A8Tvuxdb7Pdz0Rj+CaVv5qrK6
         mJGzkSMj+HYKOQvoAYG7dV11+TSNihXoBJs5vDqiI4FG3yMG3PWlVkiqXIhOL1PGlEnw
         4261/T8je3U7P06z5jnZq6jt7isYMNxbKpcNgroycoZy1Vsfd5iW/nZTfrmu10Pnyy6e
         QJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rn8kVi3Pl/IgeqSmKaQFydn5Edh0dedaqIMn7SModZg=;
        b=nZz7gWUdu8BGQO/PI7POpY5LS9bpcDcqvlRXtUi+2HK35RoqUw+iqTCW1f0buuB87K
         P6jO1YO87/Wd8a1Q/cw1PAo7xS4nLsv88ehSKGlIEclUCaYltryGN/Oy2v2WfMDGgpvd
         ZwM9MLH7OwpBGOkEiYxn3nNdZVaP1E858NZIvBWTV3SccGwttPRj+zr0TCmUtKH8Asiy
         O7+f8YnEJCcjI2Ioy051e5Wm6G2J2SB+e0XvW6UA5OE/WMETozP3QOL/skx2+7h0Pa7t
         ucQQbcQLJlbvK44SXdKnDTYamp/E9xT5LnNP3Z4GpGBCjnyetVzfz/ktjbgDRDu7JDUR
         ToHg==
X-Gm-Message-State: AOAM530hGQj9e7RUuJCfwHouFIy3zbbPszNfcgFcIRJqzKDU7SMKE/9b
        4VX9R0b9yOHoc6iVBb2HwVHv9M/6Wlk=
X-Google-Smtp-Source: ABdhPJy7Nq+6eJUWygtPLSSTDlVf+459EcExswAIAUA1Vgf7Z4hUAaB9qCcANj0z6ICZvqPbx00E1A==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr13360105wmb.180.1609005117605;
        Sat, 26 Dec 2020 09:51:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:51:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 01/16] add testcases for dubious enum values
Date:   Sat, 26 Dec 2020 18:51:14 +0100
Message-Id: <20201226175129.9621-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
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

