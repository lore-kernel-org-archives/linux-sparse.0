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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF3EC433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 22:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D1F60238
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 22:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBYWGY (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 25 Feb 2021 17:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBYWGX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Feb 2021 17:06:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1654C061574
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 14:05:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d2so8712396edq.10
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DYPJIyODZzzYOsQ4uA/jRxpME1EpYW1TR9D5kt9n7g=;
        b=CyPmLqIoHoNI5gnJwo9PNFn/37lu1JIoDT4vbSctuS8web94QGpegA9qpT4n9tz57B
         +6sJfagenFQJuXuKZqYsVv7MrZV1xDr4ThlOyJBTgePKHYeHXEGuX/TYZ5Z/x961h47g
         /LZdq3gGEfXT2OtHXabnngOygDzZZPFzY2VVv+Zg/8WEcURo10l21AgvMeVokgi7DY0Y
         DzkX/ZxUf5aOr2TV+6EOzj1dL1EvdE0b4hfCCxbSj+XsSq5Ed7oF8Z0CXYhapyDfwA0K
         Kpi04J/qBYdKDU+5O0khs+6fbXqsgMfh8l5cunme1QCzCHxahdiUN/rb4ZOa77CE4KWL
         FKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DYPJIyODZzzYOsQ4uA/jRxpME1EpYW1TR9D5kt9n7g=;
        b=HSi14nktjIdfbnGRqGqDmLOf06TxwyAjdCMpkJUhrjnNuIMwvjzy4oNTFst84Hb1u/
         FlELyEw0StzqDj5A9NKAmDUyfEUA+0fBoO/XfkvajM9HATSDE1jPkmB/HRoIYnyWQxOA
         Ybw6BJj97ChoZ3R0ZV6O12gpEDOVorprogrr8tOFvDgLbMZVwBUyXb7Jx8jXEsKFgHz2
         k+EVvL7uS/oO3B1u98dZ5xqGoS0D8FzFR9g08Wurf2m1WAIYCWgZ5a1/Nymh58v7vPMl
         UNuwg4NrFsHKixkpYtmVBRXNacwoVwL0EtZsT6Iau/nP2m9YA3n5LyBXfL7lG27dV6uE
         wwyg==
X-Gm-Message-State: AOAM533F3GG1kE8R6Md1Ue/AbKtCH4bB2Iy0OdCQQNOQKjRg6qRCY4DA
        XaXe+2mmLQgSV46c78a93Pjs6tGxBgA=
X-Google-Smtp-Source: ABdhPJw16ay6CqUv9m1bIc+3G2N3t8uBYor08CNy3uwnwX4JYQspFKLmR2SGXqKiBGW0EpqYA2DQ8w==
X-Received: by 2002:a05:6402:34c4:: with SMTP id w4mr71160edc.153.1614290741606;
        Thu, 25 Feb 2021 14:05:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:2cfa:d768:30f4:f221])
        by smtp.gmail.com with ESMTPSA id h12sm4202352edb.70.2021.02.25.14.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:05:40 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix eval of the assignment of a non-restricted value to a restricted variable
Date:   Thu, 25 Feb 2021 23:05:37 +0100
Message-Id: <20210225220537.95335-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Assignment to restricted variables are severely ... restricted.
Nevertheless, one value is always fine because it has always
the same bit representation: 0.

So, 0 is accepted unconditionally but this creates a problem
because the type of this 0 needs to be adjusted. Otherwise
0 (int) is assigned as-is even on restricted variable with a
different bit-length.

Fix this by casting the value to the target type before accepting it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                             |  2 +-
 validation/eval/assign-restricted-ok.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 validation/eval/assign-restricted-ok.c

diff --git a/evaluate.c b/evaluate.c
index 41871e18503a..a661027f8df6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1442,7 +1442,7 @@ static int check_assignment_types(struct symbol *target, struct expression **rp,
 			if (sclass & TYPE_FOULED && unfoul(s) == t)
 				goto Cast;
 			if (!restricted_value(*rp, target))
-				return 1;
+				goto Cast;
 			if (s == t)
 				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
diff --git a/validation/eval/assign-restricted-ok.c b/validation/eval/assign-restricted-ok.c
new file mode 100644
index 000000000000..df94d8c9d6d0
--- /dev/null
+++ b/validation/eval/assign-restricted-ok.c
@@ -0,0 +1,22 @@
+#ifdef __CHECKER__
+#define __bitwise __attribute__((bitwise))
+#else
+#define __bitwise
+#endif
+
+typedef __INT16_TYPE__ __bitwise __be16;
+
+static __be16 foo(void)
+{
+	__be16 val = 0;
+	return val;
+}
+
+/*
+ * check-name: assign-restricted-ok
+ * check-command: test-linearize -fdump-ir $file
+ *
+ * check-output-ignore
+ * check-output-contains: store\\.16
+ * check-output-excludes: store\\.32
+ */
-- 
2.30.0

