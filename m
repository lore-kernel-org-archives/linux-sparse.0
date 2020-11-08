Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A41C388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3665520885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXlZam23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgKHBTp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBTo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:44 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3CC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:44 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f23so608026ejk.2
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9gbTQXEHWplHTvZ01kY3/K7KpvudUy+hRlNpG9o8jK8=;
        b=TXlZam235GN24Rx52/SjBRqKNTBohzBZo7u84NNAPRL0GKaQak7b1Pgj3f2P2Rwssk
         4aqYoSxtbdiz8b+97iOTI+bO8Yhx1UtZId0R6bNS6xS+MLTAI4Kp0jAItEp1dD7AmLLJ
         BoZp1uVpanG/JfnNqeWPGzSvLFdpvpFBPRsDrJJUhOfGo6F6zcQ57NCeWqlGI878GxVM
         1+sKr2GeVUrPEe66TeJu61Wu9fn7LzoHb5fNT6BdPj4E/S0f4wRBpImNLIv1hFVGsVgs
         +yJNuhuPWuzaBf7WJ61g1+DuUdSCxIGP1XFf19wG6+1/GVA+W3XDG5/o9FPvjHXaeccJ
         C+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9gbTQXEHWplHTvZ01kY3/K7KpvudUy+hRlNpG9o8jK8=;
        b=cjaIIpbe2Ae7NsS7JAMspcPZIG3S5ASvq6sONv4Q4Uy03jLf7KZztu0hcJGWeG4jzn
         upPlm1Qc9yLYpxpRBnT9kAVW6L4sj3wF/FZpXgICTywmRZIbVUgQdsXMsgnNduN9Wj1n
         rzdroD/egXOXwvbxbOYX1VSnqMGrRDHmZZS4tE6LX5hafsbApfmUenSRMyB51rTMgfDR
         EY/s1kGNebyoxR5p4Dw5x7z2dNtAVi9KClRB0sTINDCatbj2Z8QUyGhZhdRio/b5a2tg
         by+Ti/vlHwVkUhNxFkHRyE5Edo8emjYhee12RFQPxC9p/V8IqAj40TOd1x2mPGybA8E5
         XZkQ==
X-Gm-Message-State: AOAM531+ZUHPC74MkWF1aC4y1OLMayGREcRcQFRpzoRlNl+Saw/70/aj
        JOuDSwghIcTN7YrA5mNNgxDUlOB7cVQ=
X-Google-Smtp-Source: ABdhPJwUtynbsuOFYKJO1vPZgo87nvQigZGJPJnQl15C3ewHlWGISR12D4Y2I0l6W4z6Ldh5DQ7tIg==
X-Received: by 2002:a17:906:a28f:: with SMTP id i15mr9436423ejz.468.1604798382978;
        Sat, 07 Nov 2020 17:19:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:42 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/16] simplify & canonicalize compares
Date:   Sun,  8 Nov 2020 02:19:30 +0100
Message-Id: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains a series of simplifications and
canonicalizations, mainly ones involving sign or zero extension.

Luc Van Oostenryck (16):
  cmp: adapt testcase for compares' canonicalization
  cmp: add testcases for the simplification of compares
  cmp: add signed/unsigned to opcode table
  cmp: move some code in a separate function: simplify_compare_constant()
  cmp: use a few helpers for the simplification of compares
  cmp: canonicalize unsigned (x {<,>=} C) --> (x {<=,>} C-1)
  cmp: simplify unsigned (x {<=,>} UMAX) into {1,0}
  cmp: canonicalize unsigned compare with UMAX or UMAX-1
  cmp: canonicalize unsigned (x {<=,>} SMAX)
  cmp: simplify sext(x) cmp C --> x cmp C
  cmp: simplify zext(x) cmp C --> x cmp C
  cmp: simplify sext(x) cmps {SMAX,SMIN}
  cmp: canonicalize sext(x) cmpu C (with C >= SMAX)
  cmp: simplify zext(x) cmps C
  cmp: simplify zext(x) cmpu C
  cmp: simplify compares and sign/zero extend

 opcode.c                          |   3 +-
 opcode.def                        | 164 ++++++++++----------
 opcode.h                          |   8 +-
 simplify.c                        | 240 +++++++++++++++++++++++++-----
 validation/optim/canonical-cmp.c  | 125 ++--------------
 validation/optim/canonical-cmpu.c |  15 ++
 validation/optim/cmp-sext-sext.c  |  17 +++
 validation/optim/cmp-sext-simm.c  |  29 ++++
 validation/optim/cmp-sext-uimm.c  |  25 ++++
 validation/optim/cmp-sext.c       |  23 +++
 validation/optim/cmp-zext-simm.c  |  23 +++
 validation/optim/cmp-zext-uimm0.c |  21 +++
 validation/optim/cmp-zext-uimm1.c |  15 ++
 validation/optim/cmp-zext-uimm2.c |  29 ++++
 validation/optim/cmp-zext-zext.c  |  17 +++
 validation/optim/cmp-zext.c       |  17 +++
 validation/optim/set-uimm1.c      |  10 ++
 validation/optim/set-uimm2.c      |  12 ++
 validation/optim/set-uimm3.c      |  10 ++
 validation/optim/zext-cmpu.c      |  16 ++
 20 files changed, 582 insertions(+), 237 deletions(-)
 create mode 100644 validation/optim/canonical-cmpu.c
 create mode 100644 validation/optim/cmp-sext-sext.c
 create mode 100644 validation/optim/cmp-sext-simm.c
 create mode 100644 validation/optim/cmp-sext-uimm.c
 create mode 100644 validation/optim/cmp-sext.c
 create mode 100644 validation/optim/cmp-zext-simm.c
 create mode 100644 validation/optim/cmp-zext-uimm0.c
 create mode 100644 validation/optim/cmp-zext-uimm1.c
 create mode 100644 validation/optim/cmp-zext-uimm2.c
 create mode 100644 validation/optim/cmp-zext-zext.c
 create mode 100644 validation/optim/cmp-zext.c
 create mode 100644 validation/optim/set-uimm1.c
 create mode 100644 validation/optim/set-uimm2.c
 create mode 100644 validation/optim/set-uimm3.c
 create mode 100644 validation/optim/zext-cmpu.c

-- 
2.29.2

