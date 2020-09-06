Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A4C433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86D3208B3
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0371i+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgIFMl1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgIFMlI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 08:41:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B9C061574
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 05:40:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b12so10016210edz.11
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRfyAdivijKYd1eHjviR6opeYtxEZgXCZ6i80Txf3gQ=;
        b=E0371i+h3+SeCN5JjFEfHo2W1BELPn3E31X5YJETy7atpF5OSMyGXnxRgd0m4tzKGR
         gvEr8sWEaKwDxSJmO2Ofac87BW6+jbwXwo/HnK0UVJwmfqtWzjSyBt4IQ+e6zjAQ13SB
         v1O+00/gAzs9MUpyDSvPyu6iXzFrPa5TdysQaPfkfV/qOs9UTFmWNGRhCnntaZFYJUTi
         r77Rmk3Z7/3lkNluNR1hzj81ISD51WOA1XNRCKNn2L92O+y/X6GSjolZ7YmUj0jMOzbk
         pwZxzO5IdF1gOksdOUGDe7te1gZ9IRZrum9smNc411F2AkN3UlU98UOGR7tLCY6et3w0
         X3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRfyAdivijKYd1eHjviR6opeYtxEZgXCZ6i80Txf3gQ=;
        b=JbvChmpkzIaOY0vuyFCUYgC6j1uxz+ZpCTdS7Kwz+AmmN+vBrK13Czbf0r4s/Eiofb
         84FfpExLJj+SNleudw/oP9whYf+ZimBGVlcA9xEkTMgndcISoO0uN4V7eyZunfEBSEMv
         DG8yGQ/AakLP9ykk3wGn9476tRdoVILrNmDZJgTOfN1Et2Za6t4X30K3/OCLyr2pZiWB
         WO0XB2yOmaRnxGXo+Z42dL/LHyUiLmTafLuFJPThtbKp2b7onsD68PKSsDi7amtxZK78
         AGCMl9/ZfgKLy4p+MorMTvoXII0Af07IL3O43sh7k+5m7bxkEmRMQdgfXx3HRDChKD/T
         rfcA==
X-Gm-Message-State: AOAM532LyZ1bVZeuXqiNee7qbGQgPIL9sYnwCEauWR1KdsmvKqnFtXpN
        8QnVv8UzcsOM+XPBMUFwcCDalirij1Q=
X-Google-Smtp-Source: ABdhPJwsyC1yQprX/CbXUWmCEFDO7zaUUaoAxbaKKgVZQBjR8oXHjpZQ3ja3mor1D0sBIGA1H2ceQw==
X-Received: by 2002:aa7:cada:: with SMTP id l26mr17955423edt.112.1599396042906;
        Sun, 06 Sep 2020 05:40:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:6c5d:e4e0:a162:77b6])
        by smtp.gmail.com with ESMTPSA id b6sm11591124eds.46.2020.09.06.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 05:40:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] fix & extend mask related testcases
Date:   Sun,  6 Sep 2020 14:40:35 +0200
Message-Id: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a preparatory step for some incoming series.

Luc Van Oostenryck (3):
  add more testcases for existing AND/OR simplifications
  add more testcases for AND/OR simplification
  optim: fix some testcases related to bitfield manipulation

 validation/optim/and-lsr-or-shl0.c  | 12 ++++++++++++
 validation/optim/and-lsr-or-shl1.c  | 12 ++++++++++++
 validation/optim/and-shl-or-and0.c  | 13 +++++++++++++
 validation/optim/and-shl-or-lsr0.c  | 13 +++++++++++++
 validation/optim/lsr-or-and0.c      | 23 +++++++++++++++++++++++
 validation/optim/lsr-or-lsr0.c      | 20 ++++++++++++++++++++
 validation/optim/sext.c             |  7 +++----
 validation/optim/shl-or-constant0.c | 12 ++++++++++++
 validation/optim/shl-or-constant1.c | 12 ++++++++++++
 validation/optim/shl-or-constant2.c | 12 ++++++++++++
 validation/optim/trunc-or-shl.c     |  4 +++-
 validation/optim/trunc-or-shl0.c    | 19 +++++++++++++++++++
 12 files changed, 154 insertions(+), 5 deletions(-)
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

