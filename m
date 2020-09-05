Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B618BC433E2
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA502074B
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww/w/7u/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIELMU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIELMT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 07:12:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6BDC061244
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 04:12:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so11902657ejc.2
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWD0uL4akOQ32S9DjiBXlPXP8TW0t/Qk1tVIPwEzdEc=;
        b=Ww/w/7u/ttLsO7tGvoszVSOKbWJd0veATalgdwJzAVq3fDjzAr1JcsuT27mINzHHD3
         R69+quFeqhfBVkxBLAbIuFO/H8VsxcwAGELMyCN/0pU2SMEikJYn++fSBoZR/MyLF2/n
         xtpj5HY3bDhAVirNheB84ne5hemHWSU5IIzKvMTpKpfClnri/HZCJB9lmBdzqLROOg1L
         ko09Nv/DrqdKHwKcLLpRW9dJLl0+Cp6JHQgmimEb2wMAuBjPd9A8nGPgohKzMVlhSX7n
         WQjl2R1V6dXZ67eCXC6olk720BUp/ypDJbAQxL8p7qQvLjYX1kiL25iqW55mQ/WR3mt4
         kQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWD0uL4akOQ32S9DjiBXlPXP8TW0t/Qk1tVIPwEzdEc=;
        b=Ng47errnAmfPhn8ipHSOjlyAvd3eG2Sc+ySkXQy0ZofVwE4dyYE8zaB/GueuJlwzFQ
         pkGH9RJgZ1QWIYnn24RuPT3f6iLyZpTn9q1TdzufVTOjSioH68FVJgz2aGZS9qLnxTJJ
         Dh39bjEFeK3BfIQoER0CyV2F2HjohI3UMopS5wdEL3G3pdDMLGAJgDBbjx2+0FB6Z2mQ
         AYYQymzbIKekiFZ2COiXdXrlliePtiJNzDNagoFkYqeRUvNq3L/RbGjqvsedsp1n/3lb
         eiDZ7lZfqWCY7i8GUmb1jcyvHjzMRKlqGTyve6GvISO9T17sNdpmowJxqgxFz0xU6kDe
         rOww==
X-Gm-Message-State: AOAM530SHzE6dtSrbQmL0GcJpHfeH/U/eNw4pzgz7jsycFKAWeeFsxk/
        m8gOLlYg+3a2PcqJufj1dWyDEg9bACU=
X-Google-Smtp-Source: ABdhPJw7wP6y0l1ff0akJXrxzT/6nXXcSlbT5T277zqaHENbNQXjQ0beHGBuag71ALTOmw7U2OsRHw==
X-Received: by 2002:a17:906:4c81:: with SMTP id q1mr11550098eju.72.1599304336673;
        Sat, 05 Sep 2020 04:12:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id u15sm8319506edj.69.2020.09.05.04.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 04:12:15 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] builtin: teach sparse to linearize __builtin_fma()
Date:   Sat,  5 Sep 2020 13:12:07 +0200
Message-Id: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series is the second part experimenting with adding the
infrastructure needed for the linearization of builtins.

The first part added support for __builtin_unreachable()
but this builtin has no arguments and no return value.
Now, there is an example showing how to do it when arguments
and/or a return value are present.

Luc Van Oostenryck (4):
  add support for a new instruction: OP_FMA
  builtin: allow linearization to fail
  builtin: add declaration for __builtin_fma{,f,l}()
  builtin: teach sparse to linearize __builtin_fma()

 builtin.c   |  3 +++
 linearize.c | 29 +++++++++++++++++++++++++++--
 opcode.def  |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.28.0

