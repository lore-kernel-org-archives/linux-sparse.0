Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E8C43461
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAA4208B3
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwujrLMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgIFMlW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgIFMlI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 08:41:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196EDC061755
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 05:40:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so10049458edk.6
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CW5HfaKL0MFm8iN7hro8u/5xiWhgqjY5+LgqtEBVOSc=;
        b=UwujrLMrl+h7OWAcewMFLeH+bYm2eNDUMsPafpAe7npwG2kPfgcwnjTerKXzGJDJym
         jz69lwRnL2I6GE5oQ7hE2OgD0xaewFfcArNlA1gJiz/L5/xlcYguSt9UUVGQv32iq/iv
         QtVinIX6n4zxQx82ncuZLFNE+SAvO9Vt1yFOCESdqe3je5y/zhVKmK0GyZLfbkDN68ra
         GyXT/vw5qi98KsFhCJ6zWQFsZkqs7nL1SHUM6kyXD9WzODi48UW92/pgS1haHp1F6xEu
         4rCVMz2AExrkdqrlYhS1R5yW/++x3j97WS90bbOcywZUnZUKVpCoiSBWteJfyBsoZD5m
         3dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CW5HfaKL0MFm8iN7hro8u/5xiWhgqjY5+LgqtEBVOSc=;
        b=bg9OUhWYI52QXZ43TeR6/ZT50hMAkNPFrhSV3l5mAytkKLCrwU7gtO9CMzP67eZzuX
         AJ6WW2M7fCH5io56J5HxmSAeT8muiFy3aexxyeQLNlU0T2W/JtIrM1lUB3zx1ATZkd3v
         8W8LdCD8M4KsbuKwd+arWhJWZyQmdmL9kWDhYQ2F0k0BWYly0Sm/U1QTJOK1/+q79o6p
         ddmJem+QEk05TEe/RMQ0ogpmx9TDEERqZ6sJyxQsFzwZX9SzZTj4bg5T52mprV3weA7Q
         /SVThKWYHM3lrQvpWVtnYdmFsEFKxgMJzhxXylF8CClDuDclGmDEAB4Un7VcOdCh4cof
         DgIQ==
X-Gm-Message-State: AOAM533dkxjDa2ZNXmGycgSwvYRMVQWstpkuBpJtREhLePZn0/GtRoIh
        CFbl20ypYV7Xmj71n1ZMKgey1a0XGLE=
X-Google-Smtp-Source: ABdhPJzpAbrvADM5ZGxXrXphxVS/cW27dqDavEMEgC4ffJH05/mdtaNQm4zPCmJsqRskVMqB1pSFzg==
X-Received: by 2002:aa7:cb83:: with SMTP id r3mr16818547edt.35.1599396046325;
        Sun, 06 Sep 2020 05:40:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:6c5d:e4e0:a162:77b6])
        by smtp.gmail.com with ESMTPSA id b6sm11591124eds.46.2020.09.06.05.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 05:40:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] optim: fix some testcases related to bitfield manipulation
Date:   Sun,  6 Sep 2020 14:40:38 +0200
Message-Id: <20200906124038.46786-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The patterns used here were based on looser semantic for OP_{SEXT,TRUNC}.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/sext.c         | 7 +++----
 validation/optim/trunc-or-shl.c | 4 +++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/validation/optim/sext.c b/validation/optim/sext.c
index 719730d50739..a3aa14945f11 100644
--- a/validation/optim/sext.c
+++ b/validation/optim/sext.c
@@ -6,10 +6,9 @@ int sext(int x)
 /*
  * check-name: sext
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
- * check-output-contains: sext\\.$27
- * check-output-excludes: asr\\.
- * check-output-excludes: shl\\.
+ * check-output-pattern(3): \\.32
+ * check-output-contains: shl\\.
+ * check-output-contains: asr\\.
  */
diff --git a/validation/optim/trunc-or-shl.c b/validation/optim/trunc-or-shl.c
index 70d8bd1de5bb..52b4f041b010 100644
--- a/validation/optim/trunc-or-shl.c
+++ b/validation/optim/trunc-or-shl.c
@@ -9,5 +9,7 @@ char foo(int a, int b)
  * check-known-to-fail
  *
  * check-output-ignore
- * check-output-contains: ret\\..*%arg2
+ * check-output-contains: trunc\\..*%arg2
+ * check-output-excludes: or\\.
+ * check-output-excludes: shl\\.
  */
-- 
2.28.0

