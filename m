Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99CDC3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33C4221F1
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qw1bs9aD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgK0QwA (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbgK0Qv7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:51:59 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322BC0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:51:59 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m6so6222896wrg.7
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QLbiVYpHElLIlq6UrWrbs+apaPTHT9UxRJ/hWYxKk8=;
        b=qw1bs9aDHQMfECL5ga80CtaOgDRwy9Et1yC7r8l/T6jw5hwVQ6gLZlJP1INVeG2c3y
         pzjYu6z0SuKzInxXzscrXRut+puFXAL9t4GlrUipKiQcYk+tyf6nsA5Ci5TzOBMrLDzC
         9I9GtWRIeKfVdSn6kmMSOh+/kaxw8JQayefSbDcOuZ6iOMU9XCdnHcGE+V1mDJcSJP2h
         ECm7qC4HQ8ZLEPpn5oIiRjHyXNh/3FuZZo7vYVNccvsYell/2vuo4gNjdJMOjO7+mRZW
         WJ/6xaqJF/JmC1JYyzAGDXjOMMZqxIZKM+NIazCI6uZenH50l7KRJSNeDdSwa0JPcTH0
         AkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QLbiVYpHElLIlq6UrWrbs+apaPTHT9UxRJ/hWYxKk8=;
        b=lO9+EB5jG2bezkfUrMg+3gEHz2L2csE3Qfd8ibTKpnAfBI0iiGNDNEeGqaq/FId+sq
         DtKBG0M83lGBbPatYdjxnFCYoEtFaLgUO58TLqD4cDY0FC2THnpl3mBywkVm0/1N1cbM
         dmrDwC636EgBMbS3hOcLFelR5nlo7zfSdbUZTpSEtrnHuf7bm+yXiM+vCb1AyaVeWiMN
         I8bKTvnwsVJCguHRENK8WYNjURmUlw6X9FYEFdUFE6Z+CCAMCcVEXVzKwn7SSIV/ukvp
         olJ6uTEbV6xUy9TeFYWdh2asZ2sdqL+stSDSLSPweZSdu91urrhzZVKiy+rNTgW2V0cO
         X9lg==
X-Gm-Message-State: AOAM530mWDefHktxfCpm6KNCsEzFkxTXs/U0gGPqTLXLqRfoQaiJoDcB
        TpxVbFWBMDCZZ2OZxZdxqbWTp675Awg=
X-Google-Smtp-Source: ABdhPJz68C6f4IF6fnNqDCxVvR3dQ41/Z5n5MeSuBaW3Guyf77gpeaaB7A1cB3S4qEYn15NueSpROw==
X-Received: by 2002:adf:ec8a:: with SMTP id z10mr12066901wrn.113.1606495917973;
        Fri, 27 Nov 2020 08:51:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:51:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] factorization of distributive operations
Date:   Fri, 27 Nov 2020 17:49:42 +0100
Message-Id: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series ad the factorization of distributive operations
involving bitwise operators as well as the more classical
	(x * z) + (y * z) --> (x + y) * z

Luc Van Oostenryck (8):
  add testscases for some factorization of distributive operations
  reassoc: add helper can_move_to()
  add helper make_insn_pair() & swap_insn()
  add helper replace_binop()
  refactor simplify_add() to avoid code duplication (preparation)
  refactor simplify_add() to avoid code duplication
  factorize (x OP1 z) OP2 (y OP1 z) into (x OP2 y) OP1 z
  factorize SHIFT(x, s) OP SHIFT(y, s) into SHIFT((x OP y), s)

 simplify.c                        | 217 +++++++++++++++++++++++++++---
 validation/optim/fact-add-mul.c   |  27 ++++
 validation/optim/fact-and-ior.c   |  27 ++++
 validation/optim/fact-and-shift.c |  26 ++++
 validation/optim/fact-ior-and.c   |  27 ++++
 validation/optim/fact-ior-shift.c |  26 ++++
 validation/optim/fact-xor-and.c   |  27 ++++
 validation/optim/fact-xor-shift.c |  26 ++++
 8 files changed, 386 insertions(+), 17 deletions(-)
 create mode 100644 validation/optim/fact-add-mul.c
 create mode 100644 validation/optim/fact-and-ior.c
 create mode 100644 validation/optim/fact-and-shift.c
 create mode 100644 validation/optim/fact-ior-and.c
 create mode 100644 validation/optim/fact-ior-shift.c
 create mode 100644 validation/optim/fact-xor-and.c
 create mode 100644 validation/optim/fact-xor-shift.c

-- 
2.29.2

