Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3105C4363A
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D861222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cORi2hL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438657AbgJTVK1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438655AbgJTVK0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D4C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id md26so4837665ejb.10
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qI90pgGBSWhjSWpUlvMRSXmttTL1xQo+FZ7Bie36QsE=;
        b=cORi2hL00VBLRLuYpB3agImyPbYCYUUNnvvnwJwLcdwP+ZMYhBwIlwCxyrqhn94CsZ
         UkYQ+KqCjfQ7OT5lnFRGZekYbw9T6sLS8TldxwPKAHMVR0zyLL5A82kE2p4YPKSOb1n0
         HfeieymcRt9nYw5smGzHjIhggTIOr59wuXwVml64xfBc3q6dKb5uS8Ue6wSOREMtYlMe
         YP5oGZuX60I94k5697ZJ3sWEkfwXilNciJiUcIfyYmZP7aL8BNTWa3KB+ahKwxfA3Q5s
         nJFadVEO2rHnxSynNUBYSZqn1x38RR8vn8zjCK+gtlejyhklaVI87JCUA07siCTxm+y2
         xLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qI90pgGBSWhjSWpUlvMRSXmttTL1xQo+FZ7Bie36QsE=;
        b=taNvRhoHpZe5YAiDBkly0uGH+0D/sftRo4IuCuY4AWeFe2RNB229LsqAmdq9qpBdkn
         0Fqo5Ed06IVG6N4e2FZIbxK6M2lJOnWxpUCznPYTsZqLEwaIP/CnHUYWWHJSWbR8/ru0
         hGWswOeTIVdTafWL190xzIDab1RDsDXPvxuF2BDvRL38qlQh4yoz4wWynToRo9jG+ezf
         ger7QSe9X87C9NaAMrEZw2tiSBGMQU/3IHEqS7oer2PrTFLLgLZ7d6AaHzLoVun1lcbA
         U5TqRgWkT25AJ6R01OlUODHxMdMHu8Mqkz3f+pJ/kcpUy7nBrU+lE6IHv8wHai2nVVqB
         f7hA==
X-Gm-Message-State: AOAM530oemFlx6S+5jX59b3e1bosiy0hW0q+RwzIXRuHp7pr/LL3t/PN
        PmX3EyZyw2I8S9/4/T+X0xAGt+hbm1s=
X-Google-Smtp-Source: ABdhPJxdlexHl6bQuDSyQ7GXmSrXMLAy4GfgkovZyIIqgQo6umV8tj76dAHl+omA6oQ1ORLRGrimqg==
X-Received: by 2002:a17:906:715a:: with SMTP id z26mr112088ejj.300.1603228224153;
        Tue, 20 Oct 2020 14:10:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:23 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/22] essential OP_ADD & OP_SUB simplifications
Date:   Tue, 20 Oct 2020 23:09:59 +0200
Message-Id: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These patches are a first set aiming at improving canonicalization
and essential simplifications.

Luc Van Oostenryck (22):
  add testcases about OP_ADD & OP_SUB simplifications
  let switch_pseudo() return REPEAT_CSE
  extract eval_op() from eval_insn()
  unop: add helper eval_unop()
  unop: add helper replace_with_unop()
  add a flag to identify commutative & associative ops
  constants must be truncated to the operation's size
  reassoc: simplify (x # C) # K --> x # eval(C # K)
  sub: reorganize handling of OP_{ADD,SUB}s with constant rightside
  sub: canonicalize (0 - x) into -x
  sub: simplify C - (y + D) --> eval(C-D) - y
  sub: simplify C - (D - z) --> z + eval(C-D)
  sub: simplify (C - y) + D --> eval(C+D) - y
  sub: simplify (x - -y) --> (x + y)
  add: simplify (x + -y) --> (x - y)
  add: simplify (-x + y) --> (y - x)
  sub: simplify (x + y) - x --> y
  sub: simplify (x + y) - y --> x
  sub: simplify x - (x + y) --> -y
  sub: simplify x - (y + x) --> -y
  sub: simplify (x - y) + y --> x
  sub: simplify x + (y - x) --> y

 opcode.def                                |  50 ++---
 opcode.h                                  |   5 +
 simplify.c                                | 250 ++++++++++++++++++----
 validation/optim/canonical-sub-cte.c      |   9 +
 validation/optim/reassoc-op-op1.c         |  14 ++
 validation/optim/simplify-add-neg.c       |   9 +
 validation/optim/simplify-cte-sub-addl.c  |   9 +
 validation/optim/simplify-cte-sub-addr.c  |   9 +
 validation/optim/simplify-cte-sub-subr.c  |   9 +
 validation/optim/simplify-neg-add.c       |   9 +
 validation/optim/simplify-same-add-subl.c |  15 ++
 validation/optim/simplify-same-add-subr.c |  15 ++
 validation/optim/simplify-same-addl-sub.c |   9 +
 validation/optim/simplify-same-sub-addl.c |   9 +
 validation/optim/simplify-same-subl-add.c |  11 +
 validation/optim/simplify-same-subr-add.c |  11 +
 validation/optim/simplify-sub-neg.c       |   9 +
 validation/optim/simplify-zero-sub.c      |   9 +
 18 files changed, 397 insertions(+), 64 deletions(-)
 create mode 100644 validation/optim/canonical-sub-cte.c
 create mode 100644 validation/optim/reassoc-op-op1.c
 create mode 100644 validation/optim/simplify-add-neg.c
 create mode 100644 validation/optim/simplify-cte-sub-addl.c
 create mode 100644 validation/optim/simplify-cte-sub-addr.c
 create mode 100644 validation/optim/simplify-cte-sub-subr.c
 create mode 100644 validation/optim/simplify-neg-add.c
 create mode 100644 validation/optim/simplify-same-add-subl.c
 create mode 100644 validation/optim/simplify-same-add-subr.c
 create mode 100644 validation/optim/simplify-same-addl-sub.c
 create mode 100644 validation/optim/simplify-same-sub-addl.c
 create mode 100644 validation/optim/simplify-same-subl-add.c
 create mode 100644 validation/optim/simplify-same-subr-add.c
 create mode 100644 validation/optim/simplify-sub-neg.c
 create mode 100644 validation/optim/simplify-zero-sub.c


base-commit: 5192dc1ff23dae8644480a89ada8ff420ebb674a
-- 
2.28.0

