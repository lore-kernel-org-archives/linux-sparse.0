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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E6CC433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575C320708
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk/40Y+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGHVzi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHVzh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:55:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF38C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:55:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so186464edb.13
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYIXmf/CWlEnkMTzhalIJaijA4G+ikl4osXjZhl2e1U=;
        b=dk/40Y+GV9w4v4Op/JjBTNRKByaAtmyLzL+vc6DAcy3nog+ZrDIREpug+kEkceakJ+
         rHt4TRq1jA9CKeVF4UAtLALa9nrXxe943IJArNfLv920ZigzAYtjaM3IKwhuPnlqhH15
         O3n6pvD9vYVC8Z9JP+ceNO9l7CDV0EqaZ1IYGTmDG7irDEqlpomNbBl1LSICO7XBkZQH
         nLmfJnjxMpH5iwBlY5cRkIWncr6N4eUCqehAZxQaSfKbYKe6E7GNma2urVBZVffLQu0L
         Lin5H69VMx7I7jLRnb8wXkUeqTyU+qCzn5LwCYzyGD8txFzr0Wu5XbrCaCmvIIMfPLIq
         8siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYIXmf/CWlEnkMTzhalIJaijA4G+ikl4osXjZhl2e1U=;
        b=falJeFg2oS3NCAAEAdCa2jFl6Phvv4gGYE1P/qR+ayrk8MopHyirFLnP/5EA1rDxxb
         qyrqjxZCubxnxl4f672lXMuZ1/aKpxxWA36mZB9lrSTNRaoMSB+PzkxNojWaN9eL0MJl
         mPYGZzDgi8n99+unIzy8xD5yErMUyefilGE3Fju1OrgdUGPxMClrVnWoQicDznPjrbc7
         fGWMrc0RQ1pfXpyacr+Ttv1xxKl05Q+A2z0QdM1xPRJLXj9CPRSzc4F6UcjVf9GqZhEZ
         usaujf09HINIbDN9GuTJfste8L3RbU97WICORJuP3AJBY9T0Fg4PRK0nlYgKEKnK6CbF
         DkDA==
X-Gm-Message-State: AOAM532JAktkLJBVHlYgagyXu7GxiGWz+oRC4Xbd2O+f4y4oddqJ4zMf
        bud8tIf8+jvFV4bzlOsx8nDSvBEu
X-Google-Smtp-Source: ABdhPJxbCh9BsCS9kHRN0VS4iCFvQ729Wm3GkzZSVH5ED/Inln10ePQ4JPR69BPfEV+nRiGYHrin+g==
X-Received: by 2002:a50:d513:: with SMTP id u19mr66932906edi.241.1594245336193;
        Wed, 08 Jul 2020 14:55:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id a8sm478999ejp.51.2020.07.08.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:55:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] arm: add predefine __ARMEL__ or __ARMEB__
Date:   Wed,  8 Jul 2020 23:53:29 +0200
Message-Id: <20200708215329.56404-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708215329.56404-1-luc.vanoostenryck@gmail.com>
References: <20200708215329.56404-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Depending on the endianness, predefine '__ARMEL__' or '__ARMEB__'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target-arm.c b/target-arm.c
index 0d7c6134795f..382bd3decfe1 100644
--- a/target-arm.c
+++ b/target-arm.c
@@ -19,6 +19,11 @@ static void predefine_arm(const struct target *self)
 		predefine("__ARM_PCS", 1, "1");
 		break;
 	}
+
+	if (arch_big_endian)
+		predefine("__ARMEB__", 0, "1");
+	else
+		predefine("__ARMEL__", 0, "1");
 }
 
 const struct target target_arm = {
-- 
2.27.0

