Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DDEC433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BB0611BF
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhDJNbH (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhDJNbH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E32CC061762
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n2so12890622ejy.7
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpCSGBH9GQh0Y7ESDJOHpSGZbQlr0fMAx/DJanh/reo=;
        b=L77Q3KidKwaa2dDKMjZTGrdugYMYZaSJoibmIYJib5vlJtHY4LcULEJ6tOq+qP0hzE
         2EgeMJiiPIWM+A1IU0V7VkvObd6Vo1P8dY+xqmCNJc6VTRZPL5b+t6xBOJNFh19mrxKr
         KSzrbzf9bAnUUDbe/EBtFKePdiSyizheTa/rHcWfK1EYWk6YByL0TuZKfpxyAL2gYc8c
         lqrnZMb/huixg1VC6RsTplVrC9qg8Q9J/uFFyDxhaBYswqlNVKHSORUja8mcGg8M9wEo
         Eo2V9PrZlSPerw9uhYRomdMF4+0up37euea/seSmh1HljFMlOLWf8u/LBXc0kufYmql6
         SKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpCSGBH9GQh0Y7ESDJOHpSGZbQlr0fMAx/DJanh/reo=;
        b=pDKyRkSun2NGiAoIh3o1ooEySXQEQKIOlH/lwUOlQWx5NKKH6qiwxkKsiGFp4liJCv
         R7quSkcY0WlPi4I2HEIk4+Lnvm2xGyshJ6tB26ffnCv5GY9vT10d7n8A/MO64r0f2jiQ
         32m6De7psyjmgseJOKekRuljWrXtiOc+nxnjaotzf5FXQ2KDRvJ7L4Hn0vsvO4WaOE34
         jVmBHELeBGLrePEXNcKLaV5gJ9rgAR71wvxdA3kZh2Wubdq34nYx+NX07U41InKvtKBc
         CiSpuPYsOJtwPNIQOsdK5oBq3Z7FCGWk6Lz9Sr/gMf0hQ+kjqgs2askLHM5fVN+yE0IT
         8ENA==
X-Gm-Message-State: AOAM532MDNWpG0AHtMki8DyZgUMywd4UkOqxf/RgRMo+CiZgWdxAlFbG
        isMfh1Bf5sRXE8MYnaKtEbgcu1Z9VOM=
X-Google-Smtp-Source: ABdhPJyrEid6057jgCTEJWJKZOHPh+fwx76VCj3Hvi4Ss75N1EFWkk+1AOObaYlHgs3KRiMVm1x4Aw==
X-Received: by 2002:a17:907:2058:: with SMTP id pg24mr20629432ejb.515.1618061451066;
        Sat, 10 Apr 2021 06:30:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] scheck: add a symbolic checker for sparse
Date:   Sat, 10 Apr 2021 15:30:37 +0200
Message-Id: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Some instruction simplifications can be quite tricky and thus
easy to get wrong. Often, they are lso hard to test (for example,
you can test them with a few input values but of course not all
combinations, it's not clear what are the conditions for which
they're valid, ...).

This series add a tool, scheck, which feeds Sparse's IR into a
bitvector SMT solver. This, combined wth some assertion at the
C source level, allows to symbolically check the expressions in
these assertions. In other words, it allows to check if these
expressions are valid for all possible values (but these expressions
are limited to pure integer expressions, so no floats, no branches,
no memory accesses, no functions calls).

Now, you may ask yourself "Nice, but how can I be sure that this
checker is working correctly?". And the answer to this question
is obviously "You should write another checker, of course, and
then another one, all the way down".


Luc Van Oostenryck (8):
  export declare_builtins()
  builtin: define a symbol_op for a generic op acting on integer
  .gitignore is a bit too greedy
  scheck: add a symbolic checker
  scheck: assert_eq()
  scheck: allow multiple assertions
  scheck: assert_const()
  scheck: support pre-conditions via __assume()

 .gitignore             |  35 +++--
 Makefile               |   7 +
 builtin.c              |  52 +++++-
 builtin.h              |   4 +
 ident-list.h           |   6 +
 scheck.c               | 348 +++++++++++++++++++++++++++++++++++++++++
 validation/scheck/ko.c |  10 ++
 validation/scheck/ok.c |  22 +++
 validation/test-suite  |   6 +
 9 files changed, 472 insertions(+), 18 deletions(-)
 create mode 100644 scheck.c
 create mode 100644 validation/scheck/ko.c
 create mode 100644 validation/scheck/ok.c

-- 
2.31.1

