Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63AC4363A
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5066206B5
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgTpmu1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbgJWQjr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbgJWQjo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E5C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w23so2169939edl.0
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJ5gzdN9j7w5S6ZhzkbYNNoAug+SfWWwrk5EYTzJWpY=;
        b=JgTpmu1pm8D5YTc//mY7Lm80dWWv3ICPXFfrEdJXvSYkIx9u1JrTO/MWmy+Kma42aE
         rablhyr0KMBATSjIWsk+NC7GEdN1qpnNIcCjOZFR1QQskgI7MAwLWJlZgFUePSKlv9bT
         J9RD5HfQvvt+weC9xU/sZw9Qcc4I4hipZ+uZ4eGVtFfZ9taVXf4sJl9UbOlE3d9j7drH
         +OJ3DlKbzV8xbRDLwxZZaSdrMLSqzamiDNUrjUN+iXnjBt/KlKEWCp6gJkm41/sNBT+s
         LGxfeeMMzw7178xNaHwK3czhYb/EKhHyFlARmd0JzyYBqauqZETUB3Kpkxe/nJvHcIhd
         t7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJ5gzdN9j7w5S6ZhzkbYNNoAug+SfWWwrk5EYTzJWpY=;
        b=MbZhKgKdK7K6MDTEKSL9AnO8ynyILEboQXe+t0Ix8198cmQpNNmahl8mnB9xVQx45r
         WMS2YH2Ge3W6a8Z6MX7+kcFEJBmVd/PHrnkYxr5NI/gnQFjK5uGQo8RAVlgpbG6gWOdB
         YYIGst+QMzx3jSX2r9+ZkBXVTusPigOmB7o0WpmMvGMs90p4P9rhntIMIptjGhp3udXI
         VLJ90MxAzNgyM2d99K+voIoQPKoVuyPBbZzUyUxU340nJtMad6++8156HbstYS8kekOa
         QoD3HPg3kDfsaVXVT0C9utLpc9wfju75wLao19ludaF97f9mdldoiZD5zz6qbcHLl6MQ
         ql1Q==
X-Gm-Message-State: AOAM531YIsDKNhDS76QCbPZKeuLqyLZVMqlXJcH/TsrDkcpiHyIVBSgW
        gF9FpitNviXD4PAohWcvWbj5/nAy6m0=
X-Google-Smtp-Source: ABdhPJxWAM6/5+Oz2z1Kwxiy3jmRyQo/3Xdfg+e2+Rmdi3iHe8T9OfbSnDHMncVQ0KkXcGZXWHDauw==
X-Received: by 2002:aa7:dcc7:: with SMTP id w7mr3180989edu.54.1603471182443;
        Fri, 23 Oct 2020 09:39:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] basic unop simplifications
Date:   Fri, 23 Oct 2020 18:39:30 +0200
Message-Id: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is the second batch of basic simplifications & canonicalizations.

Luc Van Oostenryck (9):
  unop: add testcases for unop simplifications
  unop: prepare simplify_unop() to handle more cases
  unop: simplify -(x + C) --> -C - x
  unop: simplify -(x - y) --> y - x
  unop: simplify -(~x) --> x + 1
  unop: simplify ~(x + C) --> ~C - x
  unop: simplify ~(C - x) --> x + ~C
  unop: simplify ~(x ^ C) --> x ^ ~C
  unop: simplify ~(-x) --> x - 1

 simplify.c                              | 50 +++++++++++++++++++++++--
 validation/optim/simplify-neg-add-cte.c | 11 ++++++
 validation/optim/simplify-neg-not.c     |  9 +++++
 validation/optim/simplify-neg-sub.c     |  9 +++++
 validation/optim/simplify-not-add-cte.c | 11 ++++++
 validation/optim/simplify-not-neg.c     |  9 +++++
 validation/optim/simplify-not-sub-cte.c | 11 ++++++
 validation/optim/simplify-not-xor-cte.c | 11 ++++++
 8 files changed, 118 insertions(+), 3 deletions(-)
 create mode 100644 validation/optim/simplify-neg-add-cte.c
 create mode 100644 validation/optim/simplify-neg-not.c
 create mode 100644 validation/optim/simplify-neg-sub.c
 create mode 100644 validation/optim/simplify-not-add-cte.c
 create mode 100644 validation/optim/simplify-not-neg.c
 create mode 100644 validation/optim/simplify-not-sub-cte.c
 create mode 100644 validation/optim/simplify-not-xor-cte.c

-- 
2.28.0

