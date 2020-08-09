Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC1DC433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DA8206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CURrjRcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHIQwj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQwi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:38 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96AC061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ba10so4738591edb.3
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgGZ6BAVk3bgQJSuPUVP0KqLhTQfVS2nfTb3xgLr9qg=;
        b=CURrjRcPrA7/tdDW1bnSfFNct8yaQeEMlScot97tAYlB8G2w5zvgO+9fo8uXfDVQWX
         i9HXb2U82ITcX/zm038fT2LP1+t38WdQ38K8/++6b+GnueKWHJbWvVS9CUoJu6Lahk2T
         egl8LZKGIqbOkfDORk7T4vHGxMj3/klP2WK+LOe3c/qnYoN+85PTRYgFuaLF8uAkqIMY
         0BggEBoYfSYGnVhKA+cDQSY3l7YOb+maDZVx208Weixy3rUGKR6G8Yf5geiB7NMU5hvw
         X3pMXSp1T1fVyBGi2c9iV2Uw8cMceYUWzwXCdsNLz8emmeMeo+ww/nZOJnzSWPzDPDxU
         lKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgGZ6BAVk3bgQJSuPUVP0KqLhTQfVS2nfTb3xgLr9qg=;
        b=P976jmrEojLBkaA3QVjFcBBam1xEvpvY5E1qJniX2b0qFY0ERLmiKUz03NEwDC9aN7
         rYRgXq10PmDIkanFdux+gun9chjgZ9a8Jv2rkQ2lEl1vx/Z7nAkaid/tABj0bZ+UW4tR
         n+AyAim1w0+1sy0FZxI7zQqr7e0gANOKu7fQU0Zc38eYSZ0omqgv09ep3eEsosiuuS3N
         3cWlj1PWvDQkFYMimLT6iDiqIBZDkDycpwKgg5qpjAKNUkjK+e9eYHPVTNlSYtLe2yom
         wfDHlQC+1ZChIROM+fDWKI0vysPAS5l8NpXfNVks7IUk4Mj7Pm41e1IeYa/zPjxUUp7Z
         99tA==
X-Gm-Message-State: AOAM532JT+bI0rETnpdchPnY8FLAv3y0pyOa+l6q9mrLQ0My59jEVbBV
        jfwS1/l278UGwthzTWtDMCcHMOek
X-Google-Smtp-Source: ABdhPJwfZ0cSWJu81nUps86oCs1r/FtsOD7Tz+7jE+th99rAPvWxV/Jg/K4jvPJuwZlJWgrIQhQLXw==
X-Received: by 2002:a05:6402:896:: with SMTP id e22mr18317849edy.210.1596991955421;
        Sun, 09 Aug 2020 09:52:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] simplify parsing of storage modifiers
Date:   Sun,  9 Aug 2020 18:52:21 +0200
Message-Id: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series simplify the parsing of storage modifiers and
is part of a larger super-series aiming at rationalize the
handling of attributes and modifiers

Luc Van Oostenryck (8):
  show-mod: add helper to show the modifiers but without ending space
  show-mod: no ending space when showing a single modifier
  show-mod: no extra space when showing modifiers + ident
  parse: rework handling of storage_class
  parse: associate modifiers with their keyword
  parse: let asm_modifier() use the keyword modifier
  parse: improve error messages concerning storage specifiers
  parse: simplify set_storage_class()

 parse.c      | 237 +++++++++++++++------------------------------------
 show-parse.c |  20 ++++-
 symbol.h     |   9 +-
 3 files changed, 91 insertions(+), 175 deletions(-)


base-commit: eb6779f6f62173672b533cfbbff59758f710fb4f
-- 
2.28.0

