Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC93C433B4
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E038F6134F
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhDRL5M (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 07:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhDRL5L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 07:57:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4AC06174A
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r12so48705243ejr.5
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQM3h26+r4i+dRt9VaOwe2aaPOcDhEwa61oB2HK2AgA=;
        b=a31GE/l/6Cfrx+5dITvo5/QUKlmRFpkMFQun1Vii7hcvu52s2hWYwVhud2CxZ4fyRJ
         MeUaZu7H1X3CRAdBUMXsOGcMRwpM/cApzFTvwn7FuktbOBCBZMOUZErwBgCxWIxvfxnS
         61e/XlmTHHXbHU61mjZWMsfaM8PDGsmi1plQbpoAE7qdnCAtSuTLa+1NIoM2hfRGPHKo
         tpUF0mnNNkyYDQRrLjiluwLH1ExDqdihqOG8gXshK1LjFjKcp+wnTkfXJGDKRranSXSG
         0kZVnfYUmFHyNhi7V1sGefYrkXAkBaT5pgFt0/mMwVItRfS7NGmpVtuWDc4p8THwMmD6
         fACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQM3h26+r4i+dRt9VaOwe2aaPOcDhEwa61oB2HK2AgA=;
        b=IdSRHl95PPzazD3NN8zTWzlLsXVqyQ1a3AtD3IQdHB0PiTyfTJnJ3eKxRf1jBuM6fM
         Sws17jr+rbMfcdZrKmGthXMrGFvXFN95caBNJjK3BV94CU6i7BsYwALUB1XHYs5ri15a
         r8vVL31jNlrdjJxYsOUty7UB0I5W7D9oeeXSdELUqVVevfAJ2luC6tqyYm3HOujNmNRS
         GAyGUA7LnoK1nRoeEb0MoAsSbo1dm3AxcvUwfyAwX+ANTw8CQ1IK4A5mkiaRGWGsc9cS
         JqUE9lZ/EDpFM0xcpe7WKGzg520MLxMqPmt47U4b0u9s909eKymtoOVxouD3+DHXO4Tn
         xfnw==
X-Gm-Message-State: AOAM533+WBpXnKMeZj9qLQHd7SCi21nRyYAKygqloDOmjg4mSGk4O6oa
        8jLglElaWlOFEYeAM4pADdyxNnRT6Xo=
X-Google-Smtp-Source: ABdhPJy28YLAz0cHXBbj6P7izJUY5h+SBK8KAs+NKXc+BMkTwldcDvETzG+syxLOgDonOHGsWMfKNg==
X-Received: by 2002:a17:906:1b54:: with SMTP id p20mr17408050ejg.477.1618747002423;
        Sun, 18 Apr 2021 04:56:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id y11sm10298199eds.10.2021.04.18.04.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 04:56:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] remove early simplification of casts during evaluation
Date:   Sun, 18 Apr 2021 13:56:32 +0200
Message-Id: <20210418115635.40608-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series removes an early simplification of casts during evaluation
which was wrong in some contexts (for example when applied to a bool)
but adds the equivalent optimization back at simplification where it can
be safely done at IR level.


Luc Van Oostenryck (3):
  add testcases for simplification of casts.
  simplify TRUNC(NOT(x)) --> NOT(TRUNC(x))
  remove early simplification of casts during evaluation

 evaluate.c                       | 44 +-------------------------------
 simplify.c                       | 15 +++++++++++
 validation/eval/not-cast-bool.c  | 14 ++++++++++
 validation/eval/not-cast-float.c | 14 ++++++++++
 validation/optim/and-extendx.c   | 24 -----------------
 validation/optim/trunc-not0.c    | 20 +++++++++++++++
 6 files changed, 64 insertions(+), 67 deletions(-)
 create mode 100644 validation/eval/not-cast-bool.c
 create mode 100644 validation/eval/not-cast-float.c
 delete mode 100644 validation/optim/and-extendx.c
 create mode 100644 validation/optim/trunc-not0.c


base-commit: eb4cdd21b7d0cedbbeff7f70e24473706ccce5a6
-- 
2.31.1

