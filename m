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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A04C6379D
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C332720773
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q14tuRKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKVP1k (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVP1k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:40 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6CDC0613D3
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:39 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 64so2579414wra.11
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3/QE1edvmloZ71nFb9phi4Ljg6NQPZDU9YiAutsAMQ=;
        b=Q14tuRKPqxfaut1N8Bolv0wuhpoET7JRHTjngHv00uYoZPyo1Nc/MWW1VPtYAbWXaq
         MTL8ILI/Zx48f7AMcAFv9/+RGvgzqHfg8+sCIhk7StYJfCB5izilnTlTKiBA8cdb8IUO
         hQRTL81lNv5na48QiDvnCfA4r7oQ8IS1yoCSkL3jx6PvE/k81bHwihNrKLVs0wh18o0T
         2hGpTGkHCmtDFErgtgcMnNWqtHdj0hSqmZvPUghWRdwYfRpGzBZQ1Qm02rzt2Iv/XSVV
         J6BSOGgEtvSN5F4aFjYIU1HYEaERnlXAgTU+Q71jWa0cHN+c/zvEFfFCNLK5RozwpBI+
         appg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3/QE1edvmloZ71nFb9phi4Ljg6NQPZDU9YiAutsAMQ=;
        b=ec4hcp+pBm8mkHqW094osRFX4xOj8prXI5dr3kki4NvEefolWap5P4wQguL7LZX+55
         BOmqfzIlX+iX1tOJf6aijak7+OeDCtTswGF4cgGNAsu/zBbYD3sGSLp7RAHihHkuem3N
         jpcnnhbHhIzZ0f9apgjwoC99wle0XnT705Do7gkwW4rhHewlRqHdCb4Yohx+OsgLUdK7
         BDseO2yS7C5e9El8c2bqS9rU+yrYHnhXHPawpPlLMCe59zXDnDEWjC52nsN9jRBuz7a5
         glcfQewYsA0f/PDs8E3t3+5vrVVhZC5Jn3DCrkWweON7p4lcX0r3Qjs2Ie1gm3de4va8
         SDiw==
X-Gm-Message-State: AOAM532J3CYXYUJWOx3sVRMxxw4jqsyZcazcHv74RMBhfBb7Q7QLZLsJ
        C9SoYTgtK2K5pZ+EVbC39Bqsaz7CmuY=
X-Google-Smtp-Source: ABdhPJxjMFa+u/ZevIaAhufBRKc5QqmerqGf9mwTu5VJg579r4kS/StSF96L8UVUVB8XBuePIxCBeQ==
X-Received: by 2002:adf:f102:: with SMTP id r2mr7786542wro.315.1606058858515;
        Sun, 22 Nov 2020 07:27:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/7] opcode: add helpers opcode_negate() & opcode_swap()
Date:   Sun, 22 Nov 2020 16:27:29 +0100
Message-Id: <20201122152731.10994-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 opcode.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/opcode.h b/opcode.h
index 1524272f0320..b74ba02d94bd 100644
--- a/opcode.h
+++ b/opcode.h
@@ -32,6 +32,16 @@ extern const struct opcode_table {
 } opcode_table[];
 
 
+static inline int opcode_negate(int opcode)
+{
+	return opcode_table[opcode].negate;
+}
+
+static inline int opcode_swap(int opcode)
+{
+	return opcode_table[opcode].swap;
+}
+
 static inline int opcode_float(int opcode, struct symbol *type)
 {
 	if (!type || !is_float_type(type))
-- 
2.29.2

