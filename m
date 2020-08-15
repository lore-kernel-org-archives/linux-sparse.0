Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D6C433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3342053B
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOHPxSHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgHOV6B (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgHOVwA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C99C09B047
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f24so12977541ejx.6
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=usSmUMXYZx9XHbcucQBYTobKUeIawcAh4+6GIF6IwtQ=;
        b=WOHPxSHKvaS3oAiHfRJBfzY/MA0RoGiSfc9cP/rdmlIRudmzF9CfDklxCXO0Oy+bbf
         78ArGfdF2JHaPTS07/HJIx3q06y9QhpVURH8GzW6GBObT7VaYAJnlFN+fbSVjB9GBTDm
         OOPROuA3kg5NDL+EpWwB6n6X4pvKc0cCcznIE8HVks5+dpdu5l36n6R/pLpZZwVWkERW
         iMJId5LTwXrZHYVB1bUfYUtZ75wv2/ghn71TfIWN14Iyxmj0ZhMaTrlM7x8eEqVA3d9x
         +122drprR/vY95xDjBKGQC+2nbt2w1aSzRmyTvsxlMXhLdWRKjE+pkLsUC0D6dbdyxyE
         cAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=usSmUMXYZx9XHbcucQBYTobKUeIawcAh4+6GIF6IwtQ=;
        b=peiMj8yhIMlTtRAzpxB2Sf93/NcgUciCSukXGwnGTbhr6hpZAvwxg/c7oY5f+NDcAF
         j2OkaQY8+e/mvWGE/h8Ln8xJ/tA3Ybu49d5JI1YgAjyi9p256NQZwOKAjy8SQW9p+FCN
         wB36Dh0SxzOosoaL9GCLdkCkDE1tvXHUhcdSimGZghyOx+rnvZ0S6ErpH/nXw7o7VAHR
         M9cQYD+Csijf+vEsD4p5erTwBgMzMTXHe2vT91Q5DvNMLkmwincxVs1kEHwhVSrkDFFy
         qmAdPKAkvbTUj+Hd0G+2I67IimjdfVbuESaJGKb6OP12Gh7wX3ueUWGc/VRkHweVumPP
         WRwA==
X-Gm-Message-State: AOAM530HcvZkeeHsaK0SU36EvclzM9YL+k0v9roDK00uK3R8E4Mo53h2
        ZvvKXZtcMAVTwS/m8Nzvg0P+9X7SaeU=
X-Google-Smtp-Source: ABdhPJw0sg5G5QNTfTZn1ge+dQazSf5I6tOX/b+gZUJhJ353D8LpT0DceFu3x5tmT2DOHNgd0eg58A==
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr7105485ejb.511.1597505288810;
        Sat, 15 Aug 2020 08:28:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:9042:5c68:7405:68b0])
        by smtp.gmail.com with ESMTPSA id o7sm9065091edq.53.2020.08.15.08.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 08:28:08 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] teach sparse about union casts
Date:   Sat, 15 Aug 2020 17:28:00 +0200
Message-Id: <20200815152803.2788-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series adds support for union casts which otherwise give
technically exact diagnostic messages:
	warning: cast to non-scalar
But these warnings are not interesting because GCC and clang
support these casts, they are used in the kernel (but not much:
~13 in the usual x86 configs) and they are not especially dangerous
(like losing bits or cheating with types).


Luc Van Oostenryck (3):
  union-cast: add some testcases
  union-cast: extract evaluate_compound_literal()
  union-cast: teach sparse about union casts

 Documentation/release-notes/v0.6.3.rst |  5 ++
 evaluate.c                             | 88 ++++++++++++++++++++------
 options.c                              |  2 +
 options.h                              |  1 +
 sparse.1                               |  6 ++
 validation/eval/union-cast-no.c        | 23 +++++++
 validation/eval/union-cast.c           | 24 +++++++
 7 files changed, 129 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/release-notes/v0.6.3.rst
 create mode 100644 validation/eval/union-cast-no.c
 create mode 100644 validation/eval/union-cast.c


base-commit: 49f7e13a7ac9a582d11e9c1ad01e71740f486601
-- 
2.28.0

