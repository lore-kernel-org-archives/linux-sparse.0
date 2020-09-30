Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F39C4363D
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723BC20B1F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn736g5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgI3XjC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbgI3XjC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:39:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571AC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:39:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so1138123wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5pL/L0iNuwDkYDrSqNCjtPBlgD7sl5Ln3RlKuK+VZ/M=;
        b=kn736g5R5jfbZxD0PTo8HsywkzMTUd5dReHLIbRY0BpF7HbzVcqplFGYJ1LfQT+8fc
         OqmzduaQ+QVw5P6cua+eK6RHtvsNsGMBuP1of3d6TYLa1Nrg78W6Kuw/RkzAkmAeLNEK
         33Zw1G84DlzZNiV14h5OWCwlw+SxIBXAtA+xxpB7O9ZbLTpWvNqG/tpH06MBYboA5CK0
         6Ug6Bf9GlYP/Q41LttksRSi1zqYls7fyTifHA5+mCvOkCQg1XY6Hz/oxWbjCeKo3SmN7
         4mCzuwQB9MuQGHoKbbofjz1zOK/EWzH5xcbK/9PEziBrgBv5NfS/yhDD+BnzAoClipsJ
         rdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5pL/L0iNuwDkYDrSqNCjtPBlgD7sl5Ln3RlKuK+VZ/M=;
        b=n6gIS21MYwc1JXpoxgv8VfofFjllz652WzzAWch7mJVa1VytRagyjdceQzqMVEJugW
         eWF9kOk9J5wrYCmxNgu3GPRyaxCZ7UROBnfcwnnGRxt1Yfn0dAoPECPz1ym4GCBY54Yl
         I60rDDU9tkllQ/67gboRscN7Ucr+W+tnM9SO778N+UUZq6GcwhSPUm+eQILWmUTVyXxr
         ZzVzD+pSEt+JUENXPraT/zjiPy9ncjgz46QhvA8Tau5V8gzD5xPfcSHKIfap8araVs0V
         k8+tc1FAvYp4otAKJd29IuHYcqiOoHHG89rzfwAJYiyx+S1kPjp0Yz3fDtPfGnCvBpeT
         38nw==
X-Gm-Message-State: AOAM531vuWWY4Z3jk5tRp+lQRDuxR2j/u0IuYt0BmYPdLmReAPeHGN5T
        ilc1GADfpm5hlLYLcXJoSljrDJXPTM4=
X-Google-Smtp-Source: ABdhPJztKBnpv1zN87Ih42ebs0KKF4ygE9u4xekB0xFDTbTf6hb/KfMBvvJ1FjRcBBABTzgm2jtOkQ==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr5194239wml.169.1601509140279;
        Wed, 30 Sep 2020 16:39:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id b11sm5610620wrt.38.2020.09.30.16.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:38:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix Hurd PATH_MAX ...
Date:   Thu,  1 Oct 2020 01:38:56 +0200
Message-Id: <20200930233856.67063-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The fix quickly added for Hurd not defining PATH_MAX is not correct:
the local define must be guaranteed to be done only after <limits.h>
is included, which is not.

Since this problem only exists with Hurd, simply conditionalize
the local define by __gnu_hurd__. Horrible but well ... Hurd.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.h b/lib.h
index b35debc83288..0b1d4492e6bd 100644
--- a/lib.h
+++ b/lib.h
@@ -44,7 +44,7 @@
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
 #endif
 
-#ifndef PATH_MAX
+#ifdef __gnu_hurd__
 #define PATH_MAX 4096			// Hurd doesn't define this
 #endif
 
-- 
2.28.0

