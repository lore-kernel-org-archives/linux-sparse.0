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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B6C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEE020775
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHAiUxZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgGHXmE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGHXmD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF3C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:42:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so285821ejj.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMvGraCOnputRbcP0HQl37K0zR7Yb8mGU2hxQIM4aPs=;
        b=BHAiUxZQXo/D6jiSfSwV6BhdCMa/wYAN/+Xh7LwJjIZswZv4y9mY8qbAbbFoo6SuMK
         8vibx1NWv7BkUIMwdBFY+nHIHEWmeIrDoXE98p9Jy5I12bVYGnzwVv6I+4UTl+TnA9uy
         qXyHH3rxBYVmRmI9k2DnMcWWeRPlOaDEEZsEzHE9Wlp7eXy6ebSqtoMThB0ZFA01k88E
         tU82lpLpT9ytxbV/Ge0BMaNS/Q1JKINYdZ7tNIpL6TNmzv3X7Ik9qDaTbC02A8NGqdP0
         sBZ6OfjhaZDyQn6uBHtY40Ju9VDe6Swe652lX7L8N2rg0J/Y1W+W+UTuxJPSMT0tt/21
         HOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMvGraCOnputRbcP0HQl37K0zR7Yb8mGU2hxQIM4aPs=;
        b=hFh0y2VLpALESX9S/AvbKNNPFpXsvXRYFuY6EEgsaV1QpIe6hPf2HhswjDnuwoSErV
         Ote8R6rJF6Z9O4RleF026fyEfKmUq329BXlJ60iK1pvEMWCymT3QFd7B0vwJoVXWRLsH
         em2hmjno+uQlPcwWk1LxNoZozi9QvR718aOP0p5hYmeIVdAk32H5As3gmSZBY9Ul3k6A
         fYGd+kvyZCOo0vSJDxKIOn8v+BO15B/QexpfF+V2Dqw5mg0QQybdl08ofip2Z3+aGlZM
         8SnkUAByuvqbxJfCl1IYiXNYAcRdMfN9Go2ku2+5PmYiH85/IiuW81CLNVBKzJNVollF
         KJLg==
X-Gm-Message-State: AOAM533a89VKUgfDt4PDF/7VEOfGmhKnKR47tKlTRRD518hCxPlSQKDD
        j8de2kYbmAqHMzIk05K2uDbtcBxk
X-Google-Smtp-Source: ABdhPJyCJMOm2hURgi1nC0RG+yQI+sSYNAZg7G9vfSlOR7TpxY8O/ciCj/DDGYfcx9HUqBlRgAJ3Rw==
X-Received: by 2002:a17:906:40d6:: with SMTP id a22mr55850026ejk.133.1594251721586;
        Wed, 08 Jul 2020 16:42:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:42:01 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] x86: fixes types for NetBSD & OpenBSD
Date:   Thu,  9 Jul 2020 01:41:47 +0200
Message-Id: <20200708234151.57845-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On NetBSD & OpenBSD, some types are not defined like on Linux.

Fix this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-x86.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target-x86.c b/target-x86.c
index 01117bb6ecc8..62323aecc52b 100644
--- a/target-x86.c
+++ b/target-x86.c
@@ -29,6 +29,8 @@ static void init_x86_common(const struct target *target)
 		wint_ctype = &int_ctype;
 		break;
 	case OS_OPENBSD:
+		size_t_ctype = &ulong_ctype;
+		ssize_t_ctype = &long_ctype;
 		wchar_ctype = &int_ctype;
 		wint_ctype = &int_ctype;
 		break;
@@ -72,6 +74,15 @@ static void init_x86_64(const struct target *target)
 		break;
 	case OS_FREEBSD:
 		break;
+	case OS_NETBSD:
+		wint_ctype = &int_ctype;
+		break;
+	case OS_OPENBSD:
+		int64_ctype = &llong_ctype;
+		uint64_ctype = &ullong_ctype;
+		intmax_ctype = &llong_ctype;
+		uintmax_ctype = &ullong_ctype;
+		break;
 	}
 }
 
-- 
2.27.0

