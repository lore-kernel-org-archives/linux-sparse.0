Return-Path: <SRS0=D4es=BS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B11CC433DF
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D4720716
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjZXbkRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHHQL4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQL4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:11:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45423C061756
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:11:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so5156138eje.10
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0cZ7cSFnoVWZ+Z80NZw8iquHymbLM6SCt4F1HlE3dqE=;
        b=TjZXbkRm2dSo0U+Wsff3rE1TqikCcXIRkjlm7qwj1QRQoiE+TslxAs0MfmK++lFxBI
         VW0u4UZQA/kXFApeHzb2MwS08SIvtbuUFxz6M2aR8/azYxTt/anvr7cBQ+RXYHddOqCr
         bDfyzO2E4J40zMbv9N2r4n7ClnEJUUs3L8dNJnxiOfDxuQWnVyFq/H2pwEW2LZuMm3fs
         MhUYzxSEQGjKHHpY2zn92p0aFdEJsuJ4QRGuOLFOrqal7i9+zKwFG5tfIGFXPvZclMgl
         oQYGVcmlGNyBOPlD1Iwmn0IPEh3TT5oACGv3s2sJS82kCWrEwvDK6OBqgL5JuHpTDbed
         I9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0cZ7cSFnoVWZ+Z80NZw8iquHymbLM6SCt4F1HlE3dqE=;
        b=larr8Tk6AM9bcd5+eabs7PyLuwwoRoLJnLFR/R4iFEywMGSeORVY8F8n0o7oTIbE+R
         VWEW1qdOTqNccuA2udoBSyZJTpmPz+sTS3uqIKnAoKrsw0HjlPCWrf8XyDwtiz9AJ5QI
         FJF0gIILrF6nJz6NFfzrHuZmyTtkrM6x+6GGhwoK2BudiJuhkzPbYQu5yook6yJA0Fr4
         ozt9icVqWSmParxvuO9DD2Ln9uee5oWmdZLZqXPyb5c9FyQja0ejM0JwXtZ9aJ8zLJ3G
         IqWexqj1A7QK918AcJTNXGvC4k4+sPNP2G6P+jmY1Nq/6nVUbRO7yeIJrwc5Zlc6JbBR
         HPdQ==
X-Gm-Message-State: AOAM533Gf00fKU4M1aqczKessmqrcxjh/OyKLP/KYW+86xUzz1cymwFU
        ZJpgrI5wbPRFlS7YNWdGt1J3VIj/
X-Google-Smtp-Source: ABdhPJydxNS2b6SND+o/oInHioOZh5YyH1okhaMkCuX5y87yoxhG9efEmvUEZq4eAFusaE+4/mRpAA==
X-Received: by 2002:a17:906:3890:: with SMTP id q16mr14042718ejd.107.1596903114628;
        Sat, 08 Aug 2020 09:11:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id g25sm8145725edp.22.2020.08.08.09.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:11:53 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] teach sparse about wide string initializers
Date:   Sat,  8 Aug 2020 18:11:37 +0200
Message-Id: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series adds support for wide string initializers.
It's obviously not much important for the kernel but it's
used in a few places related to EFI.

Luc Van Oostenryck (6):
  wstring: add support for evaluation of wide string
  wstring: add support for checking size in string initializer
  wstring: add support for examination of string initialization
  wstring: add helper is_wchar_type()
  wstring: extend is_string_type() to also detect wide strings
  wstring: call is_string_type() only when needed

 evaluate.c                | 25 ++++++++++++++----------
 symbol.c                  | 25 ++++++++++++++++++++++++
 symbol.h                  |  7 +++++++
 validation/init-wstring.c | 40 +++++++++++++++++++++++++++++++++++++++
 validation/init_cstring.c |  2 ++
 5 files changed, 89 insertions(+), 10 deletions(-)
 create mode 100644 validation/init-wstring.c


base-commit: e1578773182e8f69c3a0cd8add8dfbe7561a8240
-- 
2.28.0

