Return-Path: <SRS0=Z4Q2=EE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04452C2D0A3
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Oct 2020 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD0C2076D
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Oct 2020 22:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrRh2BWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2W7M (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Oct 2020 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2W7L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Oct 2020 18:59:11 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8A4C0613CF
        for <linux-sparse@vger.kernel.org>; Thu, 29 Oct 2020 15:59:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p5so6091613ejj.2
        for <linux-sparse@vger.kernel.org>; Thu, 29 Oct 2020 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3H2UsUFwo3vhVmZMhtuiSBjpHQ8xwqEzKnU/Pyy2k7s=;
        b=JrRh2BWIq2itkAiw3JPD48obC3uwSHFwqZrJmcikqSKdUN5HqJ3uyup8W61xpJnpVT
         v/9tZZP4fTdA/8LMBrpjtHBg1W8nrH45P1xOIawJzB3HbC5HtVj6okqBSFcATI31oyrT
         eui8HftIOskRG7nnbswMNnGwjZzmg0T4PDZC8CRBOs5SErO+z02Sm5vTY82Huo9k+hnI
         Qklqmk6MFlo7E1ToJS6Y2LJtI6W08PGqBDH+foK25JR8dvgvFZEpvpdlREsrYdU9MEj4
         lLxRphECUj57vNxRYo9NxMHqpdbZJK0A9lcFHvtxSOqHK8KvVKMB/bRHiHNbOI0mSl4X
         AQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3H2UsUFwo3vhVmZMhtuiSBjpHQ8xwqEzKnU/Pyy2k7s=;
        b=W6XN+K+sMw7qAJV7+6iXib8fiwYPgvPrWOogyIsKgyucPxRIEeza6LKPQqRi1Xf7PP
         seuFbupMYad8piqXcUJEu+5B40oihqqubgLgZnmn4mQSQkJBSRQ4L23GHL0TmaUdqFdG
         /VD6f3CI8ihUpYCRYLt8VeMl180d5YDSP4r7ggg5BOgPeP8doEcQIUpXirn8wBvuaa6c
         iV4Byzo2Q2ZorLamXpRUrrM4B9TF/QQWuVRnU9X7kf5kAmAzNPsi6W31ODGPSezWcN+Y
         gzqU8N/pob8S8Sc0Mm/MHmfqp73ybQ0zPrxUtlBZAsaoVBBxLhnyv1SmRwhZpKiN66Nd
         xDbg==
X-Gm-Message-State: AOAM530NrrGfGhKFYdKFbytlpDh+a0mXYEmqWNoy/Hn6Rz0OsDEblZcf
        4/9zkPaVjnLxY4Gn8lp/sEhKonu8/GQ=
X-Google-Smtp-Source: ABdhPJwwAVI8l85SA+VQWX05dpAMpF7TTnM1TvFsaxNAQhqfhIoEURXFAhyvX6RC9KbDLpb2fEO4fg==
X-Received: by 2002:a17:906:c0c9:: with SMTP id bn9mr6206817ejb.289.1604012349957;
        Thu, 29 Oct 2020 15:59:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d5b9:9762:e6d6:4f40])
        by smtp.gmail.com with ESMTPSA id v21sm2175224edt.80.2020.10.29.15.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:59:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] give an explicit type to operands of comparisons
Date:   Thu, 29 Oct 2020 23:59:03 +0100
Message-Id: <20201029225905.85037-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series fixes a long standing problem caused by the lack
of type information for the operands of compare instructions.

It also allows to new simplifications that were previously
impossible to do without the type information.

Luc Van Oostenryck (2):
  eval_insn: add testcases for incorrect type in OP_SET_*
  eval_insn: give an explicit type to operands of comparisons

 Documentation/IR.rst           |  1 +
 linearize.c                    | 16 ++++++++++++----
 linearize.h                    |  4 ++++
 simplify.c                     | 14 +++++++++++++-
 validation/optim/cmp-op-type.c | 18 ++++++++++++++++++
 validation/optim/cmp-type0.c   | 12 ++++++++++++
 validation/optim/cmp-type1.c   | 15 +++++++++++++++
 7 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 validation/optim/cmp-op-type.c
 create mode 100644 validation/optim/cmp-type0.c
 create mode 100644 validation/optim/cmp-type1.c

-- 
2.29.0

