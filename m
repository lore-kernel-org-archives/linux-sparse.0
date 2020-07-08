Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54504C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B4020772
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMlf9La0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgGHVsP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVsP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:48:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFDCC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:48:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so44882ejc.8
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCSbbxKu95bm1utSKQQy51MAkNa9bPVUExJE+X417h4=;
        b=dMlf9La0RxAQOqIzxrGyzfGUAGK99hag92KycKXSVDIX+h9y8NjI+RiK7Xw0IZlr/C
         81Sx75gElNbxMWZ+1or2cTC+fPgGEHuAY6Lz81qjV4u3Pl8hX3Ao/QUnTuf770JMZzzT
         QhvcIJ2itowl/+iuLrmPh8vtar1cwRbZbrz2A1Vz64JURFHjaN08Otx/xH2r1E5T3aGY
         3WY7p6T7MRKpo7kVhtoHbKOK3Y4CkUPzZHqrsSGi72p4SLm8TdyUK8YHzB176JiAPYMB
         R9oTiCYSuGNUsKwcH5HgaGdDy0LamyNodnTrkRTSNoOSS7lQirTE+ozzK/wfZ35VzndE
         9uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCSbbxKu95bm1utSKQQy51MAkNa9bPVUExJE+X417h4=;
        b=NsFdrBEFmmtqlUMEyideKTx2rUXQr3SeSbpmHEEAxZZYnrKJH7GBKgBde3TVNFtBYt
         Qj4jpgQdatTxO+J0s6WIULgjr0PRs2VRIoyGHrDBiiPY3fLMI2rwLYNDIGh5ctStV2TR
         0tiGi3/RFIFCOEVLm/hRdqa+Pr0Cn2cs/WQKxsyzOLWCicBo7QO5VvyxwSO3kES7htjR
         fSSxeQ9iqYkTZzSV48Cwj3opeKaPnioBf/zdCwNSNmIBCTDERV3X3pTluE4xYmJ2zKld
         n+8T3NQUPqvDy8JOnRrhJZ6pS6xXw4XA9rw9/u2/LPt1VIsoeselomUiEwXUP55nl+nK
         qgmg==
X-Gm-Message-State: AOAM533Rhgk581iQAZsalRQkyYRinPnSGkqEY5E7u+51Y5IwXGyaheQi
        s9XzD/rvLETIm1iXGqZKlVWxBWjO
X-Google-Smtp-Source: ABdhPJxbtLVCut2y8FA7MOPTL+JO1u/DbjoE/GvnOvVkDMRWYwt1gzrbUSehbmc9siLdVBfEZfkIMg==
X-Received: by 2002:a17:906:d9d9:: with SMTP id qk25mr56469399ejb.448.1594244894000;
        Wed, 08 Jul 2020 14:48:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id l15sm450370ejd.100.2020.07.08.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:48:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] teach sparse about the '-march' for RISC-V
Date:   Wed,  8 Jul 2020 23:48:06 +0200
Message-Id: <20200708214810.56214-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

RISC-V architecture has a set of extensions and those are
reflected in the predefined macros.
This series add support for '-march' as an architecture-specific
option and uses for RISC-V to correctly predefine these macros.

Luc Van Oostenryck (3):
  arch: teach sparse about the '-march' option
  riscv: parse '-march=....'
  riscv: add the predefines for the extensions

 options.c      |  8 ++++
 target-riscv.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target.h       |  2 +
 3 files changed, 109 insertions(+)

-- 
2.27.0

