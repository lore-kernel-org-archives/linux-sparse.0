Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A44C433B4
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261C4610CB
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhDRPdP (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhDRPdO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 11:33:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB66DC06174A
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j12so12702608edy.3
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dg46yOBW6A3c0AJLW2TlZRXfxPQDpfrhqECNirfWSU=;
        b=JYu7Yo7cJVhIE2enCrfHkAAxtvZ1d7fNzon/VuHpDTfEq1Pu21Y29wVjUYMc9QCAz9
         BFmDy9O+gPrfFBOfOQhfEQh1Y/3Yz+9Otz4/Nr+ELEqfuH6f3DhJhjZMJtFZDlns2wc/
         f6Qi3F6dJAsmWzJTMv1In12U1FP5eauyHpV6iIjZxjHbd9IVXTGfAhKRUQ4Sd/nrKnfZ
         Vm98daYv5OAqTNEPLSyP5vE+igolQ1DUW0GusUVPDVHCRWW/CrSkvrNMhiYs7MTY9XHN
         WQNITCmrakrZSYMIeqdAGnZh3OrFCIx7KDwrvyK29BRemqGlU+gi/tAlzfwLHo60IK9E
         3/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dg46yOBW6A3c0AJLW2TlZRXfxPQDpfrhqECNirfWSU=;
        b=RuGDXhbFfaVcd0NEi7zD7QaUmkK1zvO/GR4MtNiArz0pSq4MKHzRtOJGjxCNaEbuPS
         LCzVDwrMUyrscArEzqo9w2600evC0NtKpa2iLRtSQlV5TTZ77e829fWSFjfAkDxgD2/g
         RmjmdDp5lD+BSfD1WMVqOyI3mZKGeMnT+K79KeE9ZgvWGnnieeY6XtCG7U5MqAUQZeP3
         6qae7MHQqvSKYR6ilEGw8+tXqQH9KUe8+dlMDBmpHdnHptPCwXYo9ieHlZ9bFtd9TXST
         1GauaTkDLFtpJ/wdenzK0CoXwO97o7K7TmfLNzYQApLOdbMVVceUqLQDmeaOztEWUmqO
         KrMw==
X-Gm-Message-State: AOAM533wQh5P9Efnf2C64rwBNrgUdoXej9NrkBKb0+JDEvVbGJpaBP5Y
        QahYPuT9efWhCsv3X6DEf72EY3CVbpI=
X-Google-Smtp-Source: ABdhPJyxzCnIIT1jn9G1Fnox6ST6v3xyB6yGkWdM4sqQ4C4IszJJ3xHUwVIW4TiW5hmussAH6SH7wQ==
X-Received: by 2002:aa7:da18:: with SMTP id r24mr19883219eds.198.1618759963489;
        Sun, 18 Apr 2021 08:32:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id k9sm8632888eje.102.2021.04.18.08.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:32:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE 0/4] fix/improve canonicalization of signed compares
Date:   Sun, 18 Apr 2021 17:32:29 +0200
Message-Id: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains the following:
1) signed compares against a constant are now canonicalized towards 0
   so that (x >= 0) doesn't become (x > -1)
2) a signed compare like (x >= 0 && x <= C) is simplified into the
   unsigned compare: (x <= C)
   
This series is also available for review and testing at:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git optim-and-cmp

Luc Van Oostenryck (4):
  canonicalize constant signed compares toward zero
  add testcases for AND(x > 0, x <= C) --> x u<= C
  add helper is_positive()
  simplify AND(x >= 0, x < C) --> (unsigned)x < C

 linearize.h                           |  5 ++
 simplify.c                            | 45 +++++++++++++---
 validation/optim/canonical-cmp-zero.c | 74 +++++++++++++++++++++++++++
 validation/optim/range-check1.c       | 16 ++++++
 validation/optim/range-check2.c       | 14 +++++
 5 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 validation/optim/canonical-cmp-zero.c
 create mode 100644 validation/optim/range-check1.c
 create mode 100644 validation/optim/range-check2.c


base-commit: eb4cdd21b7d0cedbbeff7f70e24473706ccce5a6
-- 
2.31.1

