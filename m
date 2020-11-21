Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B0C388F9
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65E920727
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwRgKgF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgKUUxO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUxO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 15:53:14 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6CC0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:13 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o15so14514459wru.6
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRP8yPgyZ2I4yplyZvV/l/FyIAwawUDhnK3ITVYP3Jo=;
        b=IwRgKgF0aSdfUKtz/sGrGi8eQ7CVqMadNMb1WcIPKtdNBk725i60X8iXcnmytMFQsk
         +u0MdBYRYIpP4cfSUjwh+1vm/CSYXeB21PmO5el6QrZEM/d3wS/OHRz+D+H48DdQRLXS
         aDkyd8WqXc7QvXo4pawgGIBwnwY6Lh2B+TPTFnbgUqFzZYd6KqEYqE0fgfXe3NRtBVfm
         SUWcZaedjIHKwdv8pEIVjk+2k+yGfJduz7qp5kGh/3lA5I9R9NYptW1ks9XtNFtRImNR
         cSSbb4IKM2v/wf3Ui8SbSByHwpDfwY8Qbc2QshkRcaomsLFNcVRKwGDDznw7/UjSgZHK
         Skqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRP8yPgyZ2I4yplyZvV/l/FyIAwawUDhnK3ITVYP3Jo=;
        b=LZY6IbZnz9xwMFECns9UguNKQzELT3VIyJMC5fbU+8jnRZ/6hqor4rQriJx9X7VjeY
         FSqtieHRps84CmpoZolU6kPS06yDquxAq4a59qFBcOSkX30Oe8/THlvK3VofPwkeRLPY
         vXL9pAZ26S90kleCHva6cRraVaXcTDm7PO5gfpblhAEBI53UqQ++FZOGmQifV83xY43W
         QZaMJxRJuI9IumHXsDHLujUk9kuw4P8at349cwOzfm+zWz3xLzo4pcrB4Q/fId2fMsXq
         UNfPe9ktz2o9RwICfFoHGwG6PPn8CncaBkv4ebzt5sqLPcX6eDLlgngEUkxHr4ePzdCh
         dypA==
X-Gm-Message-State: AOAM531rrdGrZ8S4EYGet280oIhEK3s2XNb/XcWUUKTV5EMm+xcXD1bT
        nGzsgjvfKBYnhyRWJAJhDF0tILWLI/k=
X-Google-Smtp-Source: ABdhPJwdUn4aW9xqa1r4/R7klNowz/nBvyx3VaIveTJHrYX6VI/BckpNbn9RKEFpo5eBNnfWiyqjnQ==
X-Received: by 2002:adf:ee41:: with SMTP id w1mr3335496wro.382.1605991992321;
        Sat, 21 Nov 2020 12:53:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id p4sm9369815wmc.46.2020.11.21.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:53:11 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] simplification of computed goto
Date:   Sat, 21 Nov 2020 21:52:56 +0100
Message-Id: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains some simplification of computed gotos with
1 or 2 possible target as well as a new instruction which now
really allows the CSE of 'labels-as-values'.

Luc Van Oostenryck (4):
  add testcases for COMPUTEDGOTO simplification
  simplify OP_COMPUTEDGOTO with unique and known target
  simplify CGOTO(SEL(x, L1, L2)) into CBR x, L1, L2
  add a new instruction for label-as-value

 cse.c                        |  9 +++++
 example.c                    |  8 +++--
 linearize.c                  |  6 ++++
 liveness.c                   |  1 +
 opcode.def                   |  1 +
 simplify.c                   | 68 ++++++++++++++++++++++++++++++++++--
 sparse-llvm.c                | 11 ++++++
 validation/optim/cgoto01.c   | 24 +++++++++++++
 validation/optim/cgoto02.c   | 17 +++++++++
 validation/optim/cse-label.c | 13 +++++++
 10 files changed, 153 insertions(+), 5 deletions(-)
 create mode 100644 validation/optim/cgoto01.c
 create mode 100644 validation/optim/cgoto02.c
 create mode 100644 validation/optim/cse-label.c

-- 
2.29.2

