Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B70C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20A42065F
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMpTU6Kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgGHWUn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWUn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 18:20:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F2C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 15:20:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so122604eje.7
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+V52jbKPlig8xCvEuPjbhDHVtJW7jbtSK101vb+hD4Y=;
        b=gMpTU6Kv19a+36MVtENMbuIeTacIivVcjTUme3n2GpschmKnWgLg/L5XKzzqKtk07L
         sRkQnG45Q86JILtGVaJvH5Bnp5nIJb3Qc8jfl29dRvVd5G0qSVb/e/4ly4bg7DfB5J4c
         03z0BLoZV7SotVTjXTXdKmsrCi/AbTLtQPozUNCE93nnK4b2XBvcVw8IbqhqcjTIBdFj
         9QAFglGJQzhXYq2Ms/ZMZfZ3tXyeryu5dpupWq8YtFJzBzwQoeiCpwZqgzZttnsk0soZ
         IlbD9WGWqWiczW50kMmioRvJKv1YqMKct1uzC3khhOEnWOmgAk3BOtM7AJ5DuisnHAll
         WcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+V52jbKPlig8xCvEuPjbhDHVtJW7jbtSK101vb+hD4Y=;
        b=I6Yd9SkNzoHf6Cu3ajD35dGkl+45l4fWRJ0nHvTvDrX+JYdJ0gIQCKvZtaEMrqvMy2
         HM+xJ/5T1U7Mpq/rj5aAV0XFBMRkbuOMmbJI6vE+d8rsKC3XRQWjRv0Bx0+LfKLJS9qI
         XGSoGettNKE5MaL4Y0LTdgZhBgPVLkABYc4l4XXNuuFN3iT+Vu8vV2zrAPDf4b+Y88L/
         s/+w7/ksyY8oCDf7TFqMPEIUPLOYuiLhSK06LJ9IUVNAtJHYLnKBusmkiL0N0ZCIiHwh
         xN/Rs6dJgMj1DHApDiQaEw+EnL+aSOMMIq99cgTElZicyd4Ag5G7v6tD2U84kPhPul/A
         CEgQ==
X-Gm-Message-State: AOAM533a/7FieAszBUFimvt3MDBUER8FowHhM7EfS5R+kAEE9wct2hoZ
        lkdCfkZ3+2pgyGBcPwLGy3hDwEif
X-Google-Smtp-Source: ABdhPJz+EXUIi9zJ0lBoEv3LR3UzK41qIn4JwKgRDT/HY9vQUNw+V71MufIOq6IOW7sMIwfo06a7Ug==
X-Received: by 2002:a17:907:2108:: with SMTP id qn8mr48998957ejb.16.1594246841586;
        Wed, 08 Jul 2020 15:20:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id ck6sm567571edb.18.2020.07.08.15.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 15:20:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] nios2: add non-trailing double underscore predefines
Date:   Thu,  9 Jul 2020 00:19:16 +0200
Message-Id: <20200708221916.56665-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708221916.56665-1-luc.vanoostenryck@gmail.com>
References: <20200708221916.56665-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

For Nios2, some predefines with the trailing double underscores
were added but the variant with only the leading ones are also
used. So add these too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-nios2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target-nios2.c b/target-nios2.c
index 98813765b925..a478fff51e18 100644
--- a/target-nios2.c
+++ b/target-nios2.c
@@ -6,13 +6,18 @@
 
 static void predefine_nios2(const struct target *self)
 {
+	predefine("__NIOS2", 1, "1");
 	predefine("__NIOS2__", 1, "1");
+	predefine("__nios2", 1, "1");
 	predefine("__nios2__", 1, "1");
 
-	if (arch_big_endian)
+	if (arch_big_endian) {
+		predefine("__nios2_big_endian", 1, "1");
 		predefine("__nios2_big_endian__", 1, "1");
-	else
+	} else {
+		predefine("__nios2_little_endian", 1, "1");
 		predefine("__nios2_little_endian__", 1, "1");
+	}
 }
 
 static const struct builtin_fn builtins_nios2[] = {
-- 
2.27.0

