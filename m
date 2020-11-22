Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37FC5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114E720773
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeQRRqxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKVP1g (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVP1g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:36 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259A8C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:36 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so15517656wmd.4
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiCHleSLrSElRB4xnH1N7hiOIs8yWxgiRxTbCdckcic=;
        b=LeQRRqxO5okwdq5Pr1EEdpeLimfdY49o7xwZCwJYvaarCJjUSZIZypw0p3Zp0yUZTw
         EvBN3UT9Ni5e7OKU8xtkwKbuqmq96FF5pnCE7mhYLUXGPRmst+tN+hYwCa89Mee9iQIW
         cUVeIUdx84Yv9loMguTf/YDLkXiMjXKAithjinNg8hDsdPKm0MhovqJ/OjtS+HqkuyF7
         XPvw6p767FjHfnmOnv1IdBCV2aFS1gFjpbyevjm+IZxtopWbvPpuRsmu9Xeyhu3UmWHZ
         HgRQSz7e9oYMsbmr71g0f4CWK2DMUYshMkAZJwLbeonuDQc4ZdzwkOYcav5Ni3m5bpIL
         9iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiCHleSLrSElRB4xnH1N7hiOIs8yWxgiRxTbCdckcic=;
        b=Q8ppkSgTVWJgtDq3HOuVCpCDWZmxoOgYB0C1RwCfjw9sc6k8eYCzRYeBlB+QxO8Mey
         vqUO+2mzwdmgZvcC7cfWEjxEecNmJO7y9ABjMs3fc2bO/l7KrfSoDXvA7lQqzdYjsxEX
         ST/AscbQrMrzSC+3kXb2BNhHZCBqDmHhXb26JEfOk9tzTuVerrSHbvycp6nOC8CcB8/7
         2xr6EHgYg6j2nF6vK8UIMfx1ywyvAFvuDwJ6BpKKpFoP+5NSwyYTa3f1YS3nQ+ne6EyO
         RuO87rYlMgftcorQnBb4L+cvCrLEEnwwxQnDeav3Rx2Kg6yVK0vsyM/b/EJM481xwkh8
         yMZQ==
X-Gm-Message-State: AOAM5337e1fqU9WfVEYcuxT6zZqwUWWS4QQQfUmIZxl5ftm30e9Ekfln
        vsWmKQ4+twQvHZfVJXSK5oi4xmQt2uE=
X-Google-Smtp-Source: ABdhPJx4ZtqM+FyYdd7JG0l/rt0zq6M0EXy3Nxsx5wwVHAKKomv98zRepKE73Ni3GjyyUlmsCu8a1Q==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr19277543wml.158.1606058854513;
        Sun, 22 Nov 2020 07:27:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:33 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/7] simplify logical negation
Date:   Sun, 22 Nov 2020 16:27:24 +0100
Message-Id: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains simplifications for tautologies and
contradictions involving logical negation, like (~x & x)
or ((x > y) | (x <= y)).

As a bonus (but needed for these simplifications), now
PSEUDO_REGs and PSEUDO_ARGs are also taken in account when
checking if operands are in canonical order, which creates
a few CSE opportunities of its own.


Luc Van Oostenryck (7):
  not: add testcases for canonicalization & simplification of negations
  canon: put PSEUDO_ARGs in canonical order too
  canon: put PSEUDO_REGs in canonical order too
  canon: simplify calculation of canonical order
  opcode: add helpers opcode_negate() & opcode_swap()
  not: simplify (~x {&,|,^} x) --> {0,~0,~0}
  not: simplify ((x cmp y) {&,|,^} (x !cmp y)) --> {0,1,1}

 linearize.h                         |   4 +-
 opcode.h                            |  10 +++
 simplify.c                          | 118 +++++++++++++++++++++++++---
 validation/linear/pointer-arith32.c |  12 +--
 validation/linear/pointer-arith64.c |  10 +--
 validation/optim/canonical-arg.c    |  20 +++++
 validation/optim/canonical-not.c    |   9 +++
 validation/optim/cse-arg01.c        |   9 +++
 validation/optim/cse-not01.c        |  11 +++
 validation/optim/cse-not02.c        |  11 +++
 validation/optim/cse-reg01.c        |   9 +++
 11 files changed, 200 insertions(+), 23 deletions(-)
 create mode 100644 validation/optim/canonical-arg.c
 create mode 100644 validation/optim/canonical-not.c
 create mode 100644 validation/optim/cse-arg01.c
 create mode 100644 validation/optim/cse-not01.c
 create mode 100644 validation/optim/cse-not02.c
 create mode 100644 validation/optim/cse-reg01.c

-- 
2.29.2

