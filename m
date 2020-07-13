Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03465C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48E32089D
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulYZSrOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGMWdK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMWdK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF08C061755
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a1so9734357edt.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkdKiISHhi/iBzJC/DAoUsjd7l3dVaSjRq/4RvVlwhQ=;
        b=ulYZSrOqiglNmKukcKY47jZrWqPn5tNg6plIVrk5uQmuB26aytJbPDpyxSWAMg/3MV
         CeFT41n6+uUf4qP0J4IAfJIWOBSD3FH7fcu4bWC6esqzVTpqcEDYcB8lTKCmsPuMoEzV
         yyBVL0ECGcfXHCeK1LjSquqA9vhpfHCBjheOG5a0M09l/o0dBdM1Xs+qZr7iBt3KgBOr
         bKXVLK4kC2cnaP5725MpiM33c29Yd2o+q3jSiCNxm0d9wJRR103NsyqZ03CjadY1rKJY
         v1fzMo2KSYWHCr0rEcpVx9yeOsIRBs7yhP+vQgQ817amiWFuAOLZrIGFF5uiaMiv+uB5
         LGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkdKiISHhi/iBzJC/DAoUsjd7l3dVaSjRq/4RvVlwhQ=;
        b=fkGMlIK6lagxkr2ARdVt2PRrLG1X393h+juy/Y/CD5QvThKo585l1sqRuGMQVJoQiW
         zlWbZSKSKI398OQh5Kfc6nh3NwaJb/bIzFkdPQf9IHnzAsvXa1GvPsjwM+u5sAsj/Ddz
         2nvDUwTTBpamooC0cLy1Rj1KYPi6MNeIVIzSlDq4mSUbWySH3wINredPO7LL//M0otoP
         u2sELhSzGWeHB+LKPp8IcaYyPeTTTVPbezG/KIzlXsRIqbyqhy1+fc4qjphQvnKjqbcg
         nK2Cxl+G04XtJ/ayZUIsBJWC6H6OoqXYwNIsTjFeMJbTiJVzjSWhLumVyn1scZZ40U0A
         PBSQ==
X-Gm-Message-State: AOAM533MfIeYHTXBMSbAqkXxFhU6ExcjhQJZDqJeiHiuTRdnjTNfE5h7
        hnI97qY/QMm61Kyw7mSxGXQgFIqG
X-Google-Smtp-Source: ABdhPJxptHx+R3XxwyCurZUlrvxlZZkD/bK19abPY3+JnLPXGn6uIRQvH/ts9smt7U1DQEytwhnx5w==
X-Received: by 2002:a50:b065:: with SMTP id i92mr1667652edd.112.1594679588205;
        Mon, 13 Jul 2020 15:33:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:07 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] arch specific predefines
Date:   Tue, 14 Jul 2020 00:32:54 +0200
Message-Id: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains some small adjustments to the builtin types
and their predefined macros, for all supported architectures.

This should fully cover now all the integer types. The next step
would be the ones for floating-point numbers but it's not exactly
on the high-priority list.


Luc Van Oostenryck (9):
  sparc: add 'sparcv8' predefines for sparc32
  alpha: has 64-bit long double & int128
  ppc: add predefines __LONGDOUBLE128 & __LONG_DOUBLE_128__
  arch: add predefines __INT_LEAST${N}_TYPE__
  arch: add predefines __INT_FAST${N}_TYPE__
  predefine: teach sparse about __SIG_ATOMIC_TYPE__
  arch: allow target specific [u]intptr_t & ptrdiff_t
  x86-x32: fix it by defining a separate target for it
  predefine: let predefine_width() take the usual interface

 predefine.c         | 31 +++++++++++++++++++-----
 symbol.c            |  7 ++++++
 symbol.h            |  3 ---
 target-alpha.c      |  3 +++
 target-arm.c        |  7 ++++++
 target-h8300.c      |  7 ++++++
 target-m68k.c       |  9 +++++++
 target-microblaze.c |  9 +++++++
 target-nds32.c      |  5 ++++
 target-nios2.c      |  9 +++++++
 target-openrisc.c   |  5 ++++
 target-ppc.c        | 13 ++++++++++
 target-riscv.c      | 12 ++++++++-
 target-s390.c       | 12 +++++++++
 target-sh.c         |  8 ++++++
 target-sparc.c      | 24 +++++++++++++++---
 target-x86.c        | 59 +++++++++++++++++++++++++++++++++++++++++++++
 target-xtensa.c     |  5 ++++
 target.c            | 33 ++++++++++++++++++++++---
 target.h            | 21 ++++++++++++++++
 20 files changed, 266 insertions(+), 16 deletions(-)


base-commit: d2947a933574da18bab1ef7b7534199f44cf9e98
-- 
2.27.0

