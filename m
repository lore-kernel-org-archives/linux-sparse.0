Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B0C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481DE20B80
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLSpV1tL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgGMWdM (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGMWdK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBEC061794
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so19293510ejc.3
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMQe2tqOpAVUKTveFHXq9bnPleopodnl0hV+CX/mlnw=;
        b=mLSpV1tLl1zylf7256kUiFrtqeSIrLCTAMzgyGfjEYcrl1EOuTVD1owyfis1aXppry
         0BM4squmNA95JFckJz7WQ6ts3R61UnG+O3i+qztFuohPpJB4k+BuIBd438JcZAep5BJF
         W5SaCjAasgHEpXCImthJA2NA9nm69TlpMYdystA3X1Eretz3LdWV421VGYb0vVPT7uXV
         ra2zPDSkFLzSwcnAaxEHDJpZyPHW64pUNzGpG0sM6W3GHLsu4GP50L7viyp4jJ9A5zpF
         O+tO+KaDFTQRdD31+4r+gAh9F4/L54TO9rVhh7rmeUhE01ocXI79xajr+5dpFmHAsgTb
         RVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMQe2tqOpAVUKTveFHXq9bnPleopodnl0hV+CX/mlnw=;
        b=o7CA7l1I/eWzvC0IHBhyfQqX+wvDIqeeVoHlu7gHb8Kct4P33nBX+S4i2bSCGiK23x
         7seyZdg/dboW/WCo6wBMtI1n8RJmbuastCHwXCxCYNapQU6cLgtD3G446Ag1ZsyPVXb0
         nhVxN3S0Y6ONWDHohW1wQvk+cZQlk0q0for97jBkwkGep/d/y0NUh4ZxkzWADLEgluYs
         jkxVu9HuWOyP2d2pmQcSP763vC3qox62c/exUOwNfVlS0BaovT256teZQ9Y6WnZG8HV9
         o1htCUCJR4jOjj6LsMPqw0MaHJp7YP1Hnq3D1DShxjA+WviZq1hZj9jOSOuZTU3bSjtc
         RZvw==
X-Gm-Message-State: AOAM530V3v153H2WCiIixTIEdJ7OJ/anH6O2FIraC0DFjtUssBxEHVyp
        P0oegCKr07jO1MfkSkC4RgQy+anQ
X-Google-Smtp-Source: ABdhPJwjTfniHZ6Z20gtjQypyFp3J5qHftXPJkLOmGVJ4eQ5yKZYszWKR3YABzJkpWFDvjKV9vnr7w==
X-Received: by 2002:a17:906:40d7:: with SMTP id a23mr1720819ejk.421.1594679589011;
        Mon, 13 Jul 2020 15:33:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:08 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] sparc: add 'sparcv8' predefines for sparc32
Date:   Tue, 14 Jul 2020 00:32:55 +0200
Message-Id: <20200713223304.83666-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

By default, the architecture version is 'v8' for sparc32
and 'v9' for sparc64.
The predefines were added for sparc64 but not for sparc32.

Fix this by adding a generic 'sparcv%d' together with a
variable to hold the architecture version and initialize
this one accordingly.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-sparc.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/target-sparc.c b/target-sparc.c
index 865dbc8a2180..be4e968ec604 100644
--- a/target-sparc.c
+++ b/target-sparc.c
@@ -3,16 +3,25 @@
 #include "machine.h"
 
 
+static int sparc_version;
+
 static void predefine_sparc(const struct target *self)
 {
 	predefine("__sparc__", 1, "1");
 	predefine("__sparc", 1, "1");
 	predefine_nostd("sparc");
+
+	predefine_weak("__sparc_v%d__", sparc_version);
+	predefine_weak("__sparcv%d__", sparc_version);
+	predefine_weak("__sparcv%d", sparc_version);
 }
 
 
 static void init_sparc32(const struct target *target)
 {
+	if (!sparc_version)
+		sparc_version = 8;
+
 	if (arch_os == OS_SUNOS) {
 		wint_ctype = &long_ctype;
 		wchar_ctype = &long_ctype;
@@ -45,11 +54,14 @@ const struct target target_sparc32 = {
 };
 
 
+static void init_sparc64(const struct target *target)
+{
+	if (!sparc_version)
+		sparc_version = 9;
+}
+
 static void predefine_sparc64(const struct target *self)
 {
-	predefine("__sparc_v9__", 1, "1");
-	predefine("__sparcv9__", 1, "1");
-	predefine("__sparcv9", 1, "1");
 	predefine("__sparc64__", 1, "1");
 	predefine("__arch64__", 1, "1");
 
@@ -65,5 +77,6 @@ const struct target target_sparc64 = {
 
 	.target_32bit = &target_sparc32,
 
+	.init = init_sparc64,
 	.predefine = predefine_sparc64,
 };
-- 
2.27.0

