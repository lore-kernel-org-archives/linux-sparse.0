Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000E8C56202
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCE42158C
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDwMHm0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKUWrF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgKUWrF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 17:47:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86077C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:47:03 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so13812808wme.1
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8I7590KpybjEmmr7UWjeuspzsPntzCnTzq2rgaHibo=;
        b=hDwMHm0XqUhBzdIuNowcQ9FQEiFdNbyJb2yqcE84F+44nAGeBujq3AMumdQ4MFLFMo
         cRUPeEyWEx1ZswRb5mf3nu5hkjDWOwfN6ozS7y8xrW8epD7lQM6vnJsH0gKQhybpaIh/
         Dd6hQE9UVd8SeLIOywTnTt6gWw7k9uKEJTYfhUYfeoBvWuSJVeIPIljYziDAhH8ljrdW
         RWoT9btGXEb14+2y4UskVsUEp5ijuLt1GKbit4T1aaLW9XFS4HDBHZpNIYyMZQhFw/QD
         lvqHsq2F0JNHizvnd+5cxpAn1W/+9fqw6A7XSGzrvSydro6WBwI8tAFNW7BTR/ZA9JAo
         xOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8I7590KpybjEmmr7UWjeuspzsPntzCnTzq2rgaHibo=;
        b=rYz6CeCh3k4k26qII/1wPGDvoGEyNrMMkpXrF2sexgYZQF6u+Zpo88x+W7gMCxZfwF
         W/ZmrTJtWWeawS0yPGXPiQv3WaS7uYKF+47Oa/JYbBKb/zb53whvlRG5BmGbFLlPz32L
         e5ThLFCHgtYbi6Q3sIDCaBDjOC9MLQ3F1ZsKObbE1wReZnbwX0FIy2JRF2mewdUJWJhn
         OHeku8i3JkhYSrG78pwPOLVP2AsfF5B3LiM8pgLeULoE53VFFDgJm8aq+efHB65T9zWV
         MGLctNhzuAqliPECauSjkM7bBwcjNsTMZppThz8zelt07l0TxkRgwqFbjN8Yv8hImYaz
         7vIw==
X-Gm-Message-State: AOAM530fI9zYirmQRdMNaXacUGXbdV0o2yvtLRDUz+bAYy5lI6J+3t5V
        yEg81C4Wqgx7aCHGOMAU0CC6dkCdstA=
X-Google-Smtp-Source: ABdhPJy5Gh4YGyb7FtFTh9OwJsssdjEFssVjibS17Lq1Heh6qO+qti1qMdyYHykmEEPpZZMV99GJAA==
X-Received: by 2002:a1c:7e11:: with SMTP id z17mr17449230wmc.83.1605998822147;
        Sat, 21 Nov 2020 14:47:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:4ce2:b4ff:20e6:17bc])
        by smtp.gmail.com with ESMTPSA id l14sm4830406wmi.33.2020.11.21.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 14:47:01 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] cleanup REPEAT_SYMBOL_CLEANUP & kill_insn()
Date:   Sat, 21 Nov 2020 23:46:55 +0100
Message-Id: <20201121224657.96038-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains 2 patches doing some cleanups related
to REPEAT_SYMBOL_CLEANUP and instruction killing.

Note: these pacthes must be applied on top of the previous
      641cf2c29528 ("fix kill_insn(OP_SETVAL)").

Luc Van Oostenryck (2):
  remove unneeded REPEAT_SYMBOL_CLEANUP
  simplify kill_insn() of unops and unop-ish instructions

 flow.c     |  3 +--
 flow.h     |  1 -
 simplify.c | 25 +++++++------------------
 3 files changed, 8 insertions(+), 21 deletions(-)


base-commit: 641cf2c295285ee15f35dbcfd85367ca61259be0
-- 
2.29.2

