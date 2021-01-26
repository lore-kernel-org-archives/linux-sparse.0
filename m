Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C8C433E6
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2843D206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhA0Do5 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbhAZWFS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E48C06174A
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c12so18117540wrc.7
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9Rk9YE2kQANqzfta/O86ARxtiDGZlGpbyQZpvrrF00=;
        b=SyrrhCiAMvmvtcsVeEOSZIY8cBcQFcvXmVx4tTe5hm78jYwHaXBqH0gJ3YpWNaCBKa
         tUQzXbVuSOlS7+aaf1W5f608tG35tzHlHxHBvUOe9iDUGBDmG+6lfnkpuU/Gn1Ywhxcs
         towpgtq1O4ha41r2ev2H3XIL3zcQAIBom8aWIyaHV8MXRtAbVtgfm2BPxkcV1Q/fOfn/
         dD92y0aS7vczyZ0KpdBPuGk7S+2Z/KUTAIEtmEn8VW/eICev9HuNRdtnqxblfZ+2bNN9
         Ml04Xb0vbJG+hq2mCliLjtHZz4Xb28H/PamBuUHyGmnUkr3RUGLvxUWaSDfjD/PK0/xW
         FDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9Rk9YE2kQANqzfta/O86ARxtiDGZlGpbyQZpvrrF00=;
        b=FDbZl7KArLeaM9EJiX8zaRanUxirRPbLvToLA591pgajv4pO4RrMPpDAtehClUiW7b
         NZ5eEqVbi0/4onmgQnURnslWzFhpXb+g/UVLmgryKh/2xNz01eCWRKBH4r4vfyVgO7T4
         0vZZQtZygeyOFVDdvMnnQ4+kkmEyf5n8HNO3n7lVX7is3Kz+6Jl55wvP6mJLn4lhtuc9
         gwMBE1bVFw+7mSK7eEIgmksldjyQPoIb6uUaLupWcNfMZAxOOFi90lOjh1Vj7C3KrFBN
         bpqSC9ctk+RhORXP+Ky0U3MiF13FmC3xmF9ruH3eJx4w9lLekt2+s4BO08QWtYlqsjqw
         Ms1Q==
X-Gm-Message-State: AOAM533exnkhLPKVewy2ytmp2d8iaLWLBkutQLiYpA7H31jw2OSdhYPf
        9KISO4HUaKElA14LTP3lgoQ5T0IunCk=
X-Google-Smtp-Source: ABdhPJwfK0rXeP3cY+IgA5/qHK+j26RkIi8LpjP1aA3ehm1knqWnyP/inc9Sf0FvEhLr9PQLRzz4jQ==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr8149378wrq.315.1611698676913;
        Tue, 26 Jan 2021 14:04:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:36 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/10] simplify and canonicalize signed compares
Date:   Tue, 26 Jan 2021 23:04:22 +0100
Message-Id: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series fixes and improves the simplification and the
canonicalization of signed compares.

Luc Van Oostenryck (10):
  cmps: make clearer we're using the operands' size
  cmps: fix simplification of sext(x) + signed compare of {SMAX,SMIN}
  cmpu: fix canonicalization of unsigned (x {<,>=} C) --> (x {<=,>} C-1)
  cmps: add testcases for simplification of signed compares
  cmps: simplify signed compares with SMIN or SMAX
  cmps: canonicalize signed compares with SMIN/SMAX
  cmps: canonicalize SMIN/SMAX +- 1 --> EQ/NE
  cmps: canonicalize signed compares with constant
  cmps: canonicalize SEL(x {<,<=} y, a, b) --> SEL(x {>=,>} y, b, a)
  cmps: canonicalize SEL(x > 0, a, -a) --> SEL(x >= 0, a, -a)

 simplify.c                               | 73 +++++++++++++++++++++---
 validation/optim/canonical-abs.c         | 11 ++++
 validation/optim/canonical-cmpe-minmax.c | 16 ++++++
 validation/optim/canonical-cmps-minmax.c | 16 ++++++
 validation/optim/canonical-cmps-sel.c    | 25 ++++++++
 validation/optim/canonical-cmps.c        | 16 ++++++
 validation/optim/cmp-sext-simm.c         | 46 +++++++++++----
 validation/optim/cmps-minmax.c           | 16 ++++++
 8 files changed, 200 insertions(+), 19 deletions(-)
 create mode 100644 validation/optim/canonical-abs.c
 create mode 100644 validation/optim/canonical-cmpe-minmax.c
 create mode 100644 validation/optim/canonical-cmps-minmax.c
 create mode 100644 validation/optim/canonical-cmps-sel.c
 create mode 100644 validation/optim/canonical-cmps.c
 create mode 100644 validation/optim/cmps-minmax.c


base-commit: 0fb77bb6e5429575f52b5e26f06db031f93de057
-- 
2.30.0

