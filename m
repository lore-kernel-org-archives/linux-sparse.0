Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A830C3E8C5
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329C120756
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWBfK2Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgK2OuJ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 29 Nov 2020 09:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2OuJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Nov 2020 09:50:09 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87DBC0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:28 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so15720769ejk.2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojVDK9xOdgVLPJcx/q7ZRwxZ4Q59FxUIxbv5zfI+x54=;
        b=WWBfK2IlJ2DOP8MkHBSVPlfEXoTwsDuFnPWZN3r7UzECnNmUjiXBpRCA4WEf1p+zlN
         npirLmOUid9IQkQU4pVxL/F1bWN7FQG8RZlbA+cw94IGTAVBnLidqeWyzm//2YjoVMT2
         /X+FjEdGQPPieIufpdFf8ypedMwC+8IT85f0BakJImh5nn87KYyaWSMQifA0pC905lgm
         prrXqMdQZDeVNM8TYfRhFrdCzAzxeY1B8wGM6SlGBV3tLM0DZuOek8cq12CUoOdKY397
         RAHBoXeT7r7pF5zi4ohIgzEq8zJOvZ9b6UzOEvLfmJY6t3YiZZK31Ku9GV49ClrSI8GC
         OKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojVDK9xOdgVLPJcx/q7ZRwxZ4Q59FxUIxbv5zfI+x54=;
        b=QKc6QrDdeb4GybYjDP8WmXUa/IHrffF3ArdDOwE39kAXdaNhg7euPSmCskxNmTy87L
         X8DQ0540fLDK2o5NzNGKdxpqRMmj9QVj76UeBuIw01KJlLW2bGob4xVF8w3O1vrfAqIy
         c9jQ1CiKF28g+Ng5msso7dbLOdMiQEt7GgcvTIKVSdeZxfIl11oah7XhrK9/nY6WAznJ
         2DvJoY9GKSXKWmu7Y9OXGxbszdOtT1X/6S5lTJbK1CfuAq10gNObMjevfpmAnxMbaLGH
         /LBenateTXDMXE7SWtM24S9PwhY24jSN7zSr23eCsLBUxbkYzdqGd79X539fWkOMt30e
         ktAQ==
X-Gm-Message-State: AOAM532tcbOWoHdLczGrf3f9FyUIj1ei7JXglbespVQpIxMKkkRfI/PB
        l9W70Uv2K+EmqdImL9Fzwr4kW2uUuhE=
X-Google-Smtp-Source: ABdhPJxCbYrkxfmSYFUYaMTrUj+6doPOdAUMmQ7RMCX9BDZBWho+74RRQx/yJnvohmfPQN5jnE5SVg==
X-Received: by 2002:a17:906:60d2:: with SMTP id f18mr15171096ejk.528.1606661367270;
        Sun, 29 Nov 2020 06:49:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:149a:de72:e1c0:dd0f])
        by smtp.gmail.com with ESMTPSA id p25sm7435649eju.63.2020.11.29.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 06:49:26 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] use replace_with_pseudo() for simplify_memops()
Date:   Sun, 29 Nov 2020 15:49:17 +0100
Message-Id: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains a few patches related to replace_with_pseudo()
in preparation for some more consequential changes in memops
simplification.

Luc Van Oostenryck (5):
  let replace_with_pseudo() use kill_instruction()
  make a header for simplification
  make replace_with_pseudo() extern
  memops: move rewrite_load_instruction() here
  replace convert_load_instruction() by replace_with_pseudo()

 flow.c     | 48 +-----------------------------------------------
 flow.h     |  3 ---
 memops.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 optimize.c |  1 +
 simplify.c | 21 +++------------------
 simplify.h | 10 ++++++++++
 ssa.c      |  9 +++++----
 7 files changed, 64 insertions(+), 74 deletions(-)
 create mode 100644 simplify.h

-- 
2.29.2

