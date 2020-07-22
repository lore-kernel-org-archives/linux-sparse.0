Return-Path: <SRS0=QBgf=BB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE5AC433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2793A2071A
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9XZmNEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGVVm4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgGVVm4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Jul 2020 17:42:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A94C0619DC
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:42:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so3958027ejj.10
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+0+4Dd2LTM00x+v418u3zLCqzJdE7OMCO6ZJUn9u9o=;
        b=F9XZmNEXpYdz/ZzyrVGkpiUoLxmag4LbfJ96lncQRH2jFOMJFJCVc5pOoXOU/QhHs9
         U17DyCdq4pSlHolEgu/H9QL9B07lL7GPbifuc+anVS5hoL/t97PUhQyapLYS3t7is3qR
         Z/d0BRHYERNS6kAa1qOtfaP3s4ORuRgvJePQjvI8X44XVGBPNNMDvJryQdAGFRUq97oE
         jWAl0rf+rxVkqG/66HOmCIsfHlBPptX0dHLEL28gB5NJ28ijEgsGXO/bWttVARj+6SRA
         NJyGXcOEIjEUBtsBtelKqHn0fu/vK6swjQRNVEnrts2S7U9mkzd/5KUvgrNJszvdHNll
         kE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+0+4Dd2LTM00x+v418u3zLCqzJdE7OMCO6ZJUn9u9o=;
        b=bU2cct7wfpb7qilK2xpns0c5zNVI8mD/xaS9nUjF2qa+YXI4R1UiYVXAI8F6e4QFvi
         90MRq6Wt2QR+tvq9ZmDd3BCQc2BDvBwD8g8lqusshj+eBOLGZNUM/qO5AHBbDjKMNx8R
         XciX4kYf+ldqhyWB6ZdE3CRMYvyZRWo3Sp8u5OKaiZSwI3kiCOclxS6HIiuo/X5tBltP
         o7zxgA7acAtHyVGR3j1PJBZrg4/CqnDUuFaM+DnXQ/WmsIXBSHCbEeyziiNCTzjblyBq
         swGgBuedmyGCY5ZJ+stl+OX/druhA9GZQJW9JmdfXfFKwI6i/7DhuQik1SHv7fbl+Efy
         rrSw==
X-Gm-Message-State: AOAM531qGUWwu1XsknpvxEVniBHBcyApqgq70nlU51waume8OsxKtHtd
        WyVXeLfk9zoEp9iPU3aIZwJCxt+x
X-Google-Smtp-Source: ABdhPJxMNPEfSb2uQcBQn1CRUV3v/DfiWTTzghLTn9vaUijpSwVIxi9TLnumEh26jfVWmCJjMC6ksg==
X-Received: by 2002:a17:906:ca57:: with SMTP id jx23mr1503169ejb.256.1595454174371;
        Wed, 22 Jul 2020 14:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:905b:ad5c:bc87:c79e])
        by smtp.gmail.com with ESMTPSA id a25sm665125eds.77.2020.07.22.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:42:53 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] manpage: replace homepage to sparse.docs.kernel.org
Date:   Wed, 22 Jul 2020 23:42:47 +0200
Message-Id: <20200722214247.36824-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The online documentation was updated for the new homepage
but the manpages were forgotten.

So, update them now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sindex.1 | 2 +-
 sparse.1 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sindex.1 b/sindex.1
index e3e14ca3ad23..508e2d52cfed 100644
--- a/sindex.1
+++ b/sindex.1
@@ -144,7 +144,7 @@ read and write
 .BR sparse (1)
 .
 .SH HOMEPAGE
-http://www.kernel.org/pub/software/devel/sparse/
+https://sparse.docs.kernel.org
 .
 .SH MAILING LIST
 linux-sparse@vger.kernel.org
diff --git a/sparse.1 b/sparse.1
index 399a63fa2a0a..60203d5a6463 100644
--- a/sparse.1
+++ b/sparse.1
@@ -513,7 +513,7 @@ By default chars are signed.
 .BR cgcc (1)
 .
 .SH HOMEPAGE
-http://www.kernel.org/pub/software/devel/sparse/
+https://sparse.docs.kernel.org
 .
 .SH MAILING LIST
 linux-sparse@vger.kernel.org
-- 
2.27.0

