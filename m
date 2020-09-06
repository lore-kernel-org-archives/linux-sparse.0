Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811CEC43461
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE6F2078E
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLEPwdXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIFVQx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFVQx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 17:16:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E403C061573
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 14:16:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so15465796eja.5
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WFc+dHOy930Bfy7k6+ru3PEApSHXK/oHiJkRd3c/Ibk=;
        b=mLEPwdXKFTsi7dDoPKorF4hcubtV7WfJbFqvXiJLXOc+N3/JrVjWT580SeSh0F0I19
         BXVe1q6gveEQDSKilt9n5miinU9tGOtE9w8WAXPFjJNOtVfbScBkFXZ7LRjWfgOEtgsq
         /aQ2PdI3wFVL1nSDo1qDoiKJ8dPE2XqQhNmEkE4n3ig8xL0xIuqYJrAkHlAfEsfvrHjA
         KGe49CYRoNgM1k/kAxbwIJSLRHDc3lTosppWn2sPT+2Pgduc9BzRR+4nTVOGxFK6Vsb3
         wCmoeBKt/+OMHfLNceu2xN/BxDLBYjBReR7Y4vORtptv/xavHIv8DTBmCpH7+2p+a8rq
         FRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WFc+dHOy930Bfy7k6+ru3PEApSHXK/oHiJkRd3c/Ibk=;
        b=gojT4eHSVWuqqNtwrmERtwqesi93TKx8HNqh4W/ySQFJdh6zHf9/cgQ3rYRriKVISC
         B1J6z2PgWYSfNGv+3PnfAd4e0DGVhz/oTuJHOqfuWgNsb1ji3yH8gapgn7gj1G2V1lyb
         AeyYWC8gCHyGX+qtGFsq+6dOXaha9cNFvatMLqa0bWMRUoDykRO2wXTLY1ZtbfKx0UGf
         5hBoPmvNsyHz1Q9Qz1+ikX8yIMh2M42zgqTRLU3cmCelaFRYMTkUdZqSKvIqtUn7cnVJ
         shO3vSc/XxeqXzJxtcHleKnj7wC2GEa5g4CPvs/FHq11m9nGiiLeD0+v5ogwf0dTvRhc
         TbCg==
X-Gm-Message-State: AOAM533+fi8yEMTV3bFdLMfRw/bGwxecmJS/F818guPFMPwmq0sC91Dd
        J9BjvSnj/B9DI6HDOGKMzMEp5WhX5kU=
X-Google-Smtp-Source: ABdhPJySZ+UFHC2dtluHaZG6CM16/KEqnbqphgpa74Rg05qi8xtYRKYb9S1wRteI9MaIB7AWvRqKwg==
X-Received: by 2002:a17:906:46d5:: with SMTP id k21mr17766823ejs.247.1599427009581;
        Sun, 06 Sep 2020 14:16:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:1c0f:34d8:de78:ecc0])
        by smtp.gmail.com with ESMTPSA id e4sm13057645ejk.76.2020.09.06.14.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 14:16:48 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/3] fix & extend mask related testcases
Date:   Sun,  6 Sep 2020 23:16:43 +0200
Message-Id: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a preparatory step for some incoming series.

Changes since v1:
* take in account Ramsay's remarks:
  * add some short explanation of the expected simplification
  * add a few tests of the absence of %arg[12]
  * s/shl_or_constant1/shl_or_constant2/ in shl_or_constant2.c
* move patch fixng existing testcases first.

Luc Van Oostenryck (3):
  optim: fix some testcases related to bitfield manipulation
  add more testcases for existing AND/OR simplifications
  add more testcases for AND/OR simplification

 validation/optim/and-lsr-or-shl0.c  | 13 +++++++++++++
 validation/optim/and-lsr-or-shl1.c  | 13 +++++++++++++
 validation/optim/and-shl-or-and0.c  | 15 +++++++++++++++
 validation/optim/and-shl-or-lsr0.c  | 13 +++++++++++++
 validation/optim/lsr-or-and0.c      | 22 ++++++++++++++++++++++
 validation/optim/lsr-or-lsr0.c      | 22 ++++++++++++++++++++++
 validation/optim/sext.c             |  7 +++----
 validation/optim/shl-or-constant0.c | 12 ++++++++++++
 validation/optim/shl-or-constant1.c | 12 ++++++++++++
 validation/optim/shl-or-constant2.c | 12 ++++++++++++
 validation/optim/trunc-or-shl.c     |  7 ++++++-
 validation/optim/trunc-or-shl0.c    | 22 ++++++++++++++++++++++
 12 files changed, 165 insertions(+), 5 deletions(-)
 create mode 100644 validation/optim/and-lsr-or-shl0.c
 create mode 100644 validation/optim/and-lsr-or-shl1.c
 create mode 100644 validation/optim/and-shl-or-and0.c
 create mode 100644 validation/optim/and-shl-or-lsr0.c
 create mode 100644 validation/optim/lsr-or-and0.c
 create mode 100644 validation/optim/lsr-or-lsr0.c
 create mode 100644 validation/optim/shl-or-constant0.c
 create mode 100644 validation/optim/shl-or-constant1.c
 create mode 100644 validation/optim/shl-or-constant2.c
 create mode 100644 validation/optim/trunc-or-shl0.c

-- 
2.28.0

