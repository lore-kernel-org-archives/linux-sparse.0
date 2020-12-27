Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FD8C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D7020799
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 09:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgL0J2o (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 27 Dec 2020 04:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL0J2o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Dec 2020 04:28:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70BBC061794
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 01:28:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c124so6960870wma.5
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQRZXPqCZ85pX5luD5eiYZf4Um+TYeyRxjmB8Blmqng=;
        b=HUiuBwDtRQNQ1U8YR3S8D1YVvdjJ0E11pf5wVfcxig//VWH208rq0jFHkArSgSA7BI
         3XXLRwD4FwS9VvxBPIC8LivXF3w6KAY5E9zU3QSqRFJsBDVJaTfILczCReuQdKYo5QXm
         vDgYuKoks5EfYxsNGOQuAcD+wchRNhAnxnIPCgjEAr7FupMWxcRJqIseilPGP4kFmq9J
         R7/Y3GoUGdjwOcs5MOYHgR/IUX3x8jNYvWadGW3HJvXTA2UypavxViIWADYFXaROUiQi
         6Y65X1YGfHN6RpArI4mU1vr0u1NmuZnT0zt9dB+VIMgJ9mm9ux3SVqEKEWVVPFdHx9aD
         q5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQRZXPqCZ85pX5luD5eiYZf4Um+TYeyRxjmB8Blmqng=;
        b=c2bNRZyE3xcA22r2sXfWsrbMXAX46Gpv6pyDVcYbChShO55sK418OkYMhBFFBbklMW
         jOtq0iHXu4lls+nClI1aoyWzQ07H8NpWj4Kk8zvI6egM2Ky6syUbR4MCsSSEbfbcGfAX
         YrTysub7SGk+Cjf08fqXlp8Bi2rS0HG7FT7xhjX7h2ku9emZVBUHd08sfS7B2+3G9UYR
         ZncJB5LEyYY5OjTQea7h3SwTtfNDT9JAGsRzGbeh1qR/ZtbSA5Puks1uKTzogRZsWTcY
         KtkGRqit+T3QwU8e3seQZA8Wqa6wgTfc32KXgfDft0yPGIaiRO0j0Abn1G9yPp5I/WgL
         JP4w==
X-Gm-Message-State: AOAM533cvNYAWBLF0hMKvARul8zpgi59GuOFEOKtzCnmN3M8i85uwNql
        zFUB+4PCYIx0gg0RkiXFC53tePsyEqA=
X-Google-Smtp-Source: ABdhPJyViEO1XfEQ3Vau+y412PDM78tsiDHq+ylXZJ1VV4b1OrDQG8kU9h9FOFjKIsYNsnuU7j9kbQ==
X-Received: by 2002:a1c:61c3:: with SMTP id v186mr15679587wmb.146.1609061282468;
        Sun, 27 Dec 2020 01:28:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c99c:3949:2fe7:7420])
        by smtp.gmail.com with ESMTPSA id n8sm49904007wrs.34.2020.12.27.01.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:28:01 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix rem_usage()
Date:   Sun, 27 Dec 2020 10:27:57 +0100
Message-Id: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These two patches fix a bug with rem_usage(), after having removed the
last element of a def-use list, tries to kill the defining instruction
although only PSEUDO_REGs and PSEUDO_PHIs have one.


Luc Van Oostenryck (2):
  add helper has_definition()
  fix rem_usage()

 linearize.h | 5 +++++
 simplify.c  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.29.2

