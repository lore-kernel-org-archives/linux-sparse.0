Return-Path: <SRS0=AFCr=BL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A096C433DF
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242F0206F6
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 12:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9KsvtS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHAMUS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 1 Aug 2020 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgHAMUS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Aug 2020 08:20:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CBCC06174A
        for <linux-sparse@vger.kernel.org>; Sat,  1 Aug 2020 05:20:18 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so10415736edv.11
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2020 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/hyQe9AaGPFeyLl0+J6fvGUkHsGwrlagFXgLpeavVY=;
        b=V9KsvtS1gq8rF0a/WCsdEm6GzMVaeEKUl/bX9JzCIxBnk6WJ/TOmpS3ghQneyx+Wbe
         H4a2Rr7CDiTPuV7uRY/wHVujNLpRa1R8JqVyPCJUIFi1bxfw+MVJMxziFb3EyAnfXgSZ
         3vCQneXJLjCAjp0GwbIXGe2f8Hx4Lsw8xu2dKAbQBM+Eo49+rPGnQ5SNLcRQQwL0fQvr
         0KwGzxtCuYV3cSkmfY6wwp6hQXJnoIVgWfWbaF64W3gT0wD7GghIImuY1Hv5+8KeuFvJ
         hiEj/Kb9MP2qU4qv84+Cpg39UwSYGblcK7l4LOYRAZBIHiVI2atkd5mqMqRTG3ShV18z
         nL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/hyQe9AaGPFeyLl0+J6fvGUkHsGwrlagFXgLpeavVY=;
        b=btlkIoCmD/sevh2IGJQ5EAAr3ur3JgkhDr1MMwtAXghFyur+wx3eKp2mtxhhPi2hys
         xeHv4t08bxBODAXjZXHgxraEn8LHcuW8CVlRkMqpKDhViFmpj7H99Pf03uVegies1ytl
         D6fC2jdUzgaKOHCiOuQiU3pr+UEg4LeNEFcimNGCZHVLzDEWTMpb7RUPQyo0aE37h52T
         B1LPGKP4YrdcwIE3Ppc6KbrLAljb0l6K2ZyB7+R9cbEbTz9jFgKEvw7IcZaxell9dbsC
         QGld1p/ZpnHD1tTHOln8krVy1VEtmrAytv5rXP+zXkGgGrKy4vtdZp0akB5RGyUMUrCR
         aLuw==
X-Gm-Message-State: AOAM532kN7yT9OOM+YfpCYFzr0VELbCETEP8xXESYBMDTYotLCy5gULv
        H4bWG46nhTsAJANR+ubbfdShU1NH
X-Google-Smtp-Source: ABdhPJxWLYgwI2sjkexLQGn6VfFcsdnWiFvVLiRirPqIi1B4OlV6VYcFFZs2rdp+9zQxIzs1KI4evg==
X-Received: by 2002:aa7:d818:: with SMTP id v24mr4968789edq.259.1596284415954;
        Sat, 01 Aug 2020 05:20:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:75e4:71f5:294d:53f6])
        by smtp.gmail.com with ESMTPSA id v14sm11324153ejb.63.2020.08.01.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:20:15 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix build on Hurd which doesn't define PATH_MAX
Date:   Sat,  1 Aug 2020 14:20:11 +0200
Message-Id: <20200801122011.40207-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hurd doesn't define PATH_MAX but is needed by pre-process.c
and sindex.c.

pre-process.c had already its local define but sindex doesn't.
So, allow sindex to build on Hurd and avoid possible problems
with some future tools by moving the default define of 4096
for it to lib.h where it will be visible for all code.

Reported-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h         | 4 ++++
 pre-process.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib.h b/lib.h
index e767840c1038..17b17a72f531 100644
--- a/lib.h
+++ b/lib.h
@@ -43,6 +43,10 @@
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
 #endif
 
+#ifndef PATH_MAX
+#define PATH_MAX 4096			// Hurd doesn't define this
+#endif
+
 extern int verbose, optimize_level, optimize_size, preprocessing;
 extern int die_if_error;
 extern int repeat_phase;
diff --git a/pre-process.c b/pre-process.c
index 38167802f465..ca613018720a 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -890,10 +890,6 @@ static void set_stream_include_path(struct stream *stream)
 	includepath[0] = path;
 }
 
-#ifndef PATH_MAX
-#define PATH_MAX 4096	// for Hurd where it's not defined
-#endif
-
 static int try_include(const char *path, const char *filename, int flen, struct token **where, const char **next_path)
 {
 	int fd;

base-commit: b24508f10b9a24b01bd41289f440942ff79b197e
-- 
2.28.0

