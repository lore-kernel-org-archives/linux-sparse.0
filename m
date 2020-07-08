Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B075C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE49620775
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN4KxaWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgGHXmB (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgGHXmB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BCC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:42:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so290058ejb.4
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWrDCZEz3T9JwfRoOmoWHcDsRZzaJrqs9bYrVl8ZG3c=;
        b=WN4KxaWeQx/sRA0OoEnCLELrlwP/dJIsE8jFg80jGlJVIOI0E/u3YYnN4dijZKjKyI
         o4n5wQRhOuFgwciUyyFffxfOAR1RMFBo/aserY8a21oZDOSUk6V1cq7ptwZsgdEZKcj1
         fDMEw8jaAd97IqX/VLKu9ii+6UIpMkO8cRM33KNm9QyslMrUIMnZARa87wLsI/sFzCMa
         MrU+NCywSgi0wh91FIFRxreVgkdwLaWhy/qEU2OTxhV1zZLUiKJpo1Rxf903a/GJfFVE
         Q5mKInege5Ii5JBURUIFm6tsPe62PJb6b4jqOQzqKRnki9ZlQwv3tddLJqSDT7nsoGTO
         TAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWrDCZEz3T9JwfRoOmoWHcDsRZzaJrqs9bYrVl8ZG3c=;
        b=KKu0hNoy/X2o8rbRylyrFWU31Lx4HnOw+o5c7aq/R0rfL8DG4VuVHBs/lHAkmH70NF
         eFODpSQqtC5knGfGzO8+32PSZxf/uSOzgKH/uyMz3Rwxu+nV8fFjEMWbHsYSNlUkh/61
         Nl9B1nbR7cDGaT6g5mof61iLJHB8oqWCvREeb9jrEnx5btfaZpmyfk1IEguJ8ph1R5f9
         otwr4ZiASk2iTFD2S0qxtEjy0jtATQcwEQwW5oPCxfisY7iHWlB6C7YKZYwGHfU35Uec
         nJLnrnNJX5CHTryDGVwWwZW0q5U2/FiXnXPdFFw56xR7Udc9/G0LdOh4khZTs69Zi0OL
         N4cw==
X-Gm-Message-State: AOAM533bs2n+JoeN7CMPXQXTCwsZQiFm4Fg2LhnAgNZ64i6AP5uRa6Ts
        rTKObhiYapGGtPmEtLjEFoRVFB0U
X-Google-Smtp-Source: ABdhPJyo/Rxr5HMbmOlDnCSvPHqssux4x34agVva7o4iyIGkyaeljNzTWAEjX2/daQ1k0suU5v+7Fg==
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr45202767eje.2.1594251719509;
        Wed, 08 Jul 2020 16:41:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:41:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] predefine: add __linux__ & __linux
Date:   Thu,  9 Jul 2020 01:41:45 +0200
Message-Id: <20200708234151.57845-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These are already defined in cgcc but not yet by sparse
itself. So, add them now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/predefine.c b/predefine.c
index d05b1018fdce..0e9f73eb2340 100644
--- a/predefine.c
+++ b/predefine.c
@@ -216,10 +216,16 @@ void predefined_macros(void)
 		predefine_nostd("unix");
 	}
 
-	if (arch_os == OS_SUNOS) {
+	switch (arch_os) {
+	case OS_LINUX:
+		predefine("__linux__", 1, "1");
+		predefine("__linux", 1, "1");
+		break;
+	case OS_SUNOS:
 		predefine("__sun__", 1, "1");
 		predefine("__sun", 1, "1");
 		predefine_nostd("sun");
 		predefine("__svr4__", 1, "1");
+		break;
 	}
 }
-- 
2.27.0

