Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13FC433E6
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7597864FC3
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhCJWLN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhCJWLA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:00 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026DFC061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id c10so41841303ejx.9
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k54bFo2D+JoiONc3jLIMm1xDJGStv9bFd7m+UKyfhpc=;
        b=OrEmSK7+gBpJ0uItUXuu9PE6bvuiexrs6miuwsvN35M3sONPvs+vDWHgZk0xe9EUhb
         R75Y5WgK+gFJDIugKj2Yaxqr7uCOBMjFQhTrreY+pnHbDHe+DamqPDlBa2tNSwm9P4CF
         vROKPNrd0nvW8QqbpwTkXYsqjtXIxY3UyGepcus2B9X30EiqKp8+l4NCgHbJx3JnDv9r
         2b9+Sp/6vywwWDVdj5/2Usp6pxJ9qsq1qvEwA+80JXG3ub4kwYSo0uli9nF9CRD3FIlH
         W7Qh89nc8Q9xi/8d4a/QRICpZuGG4gy1RMCBocLSpqqHIJN2NLT/8MHatitBjJaKNq1w
         XDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k54bFo2D+JoiONc3jLIMm1xDJGStv9bFd7m+UKyfhpc=;
        b=JY6bYJkUXJ8t2WKFDzfW7dCcRyGfByFDCeFb9NwcNGUeiTlF6j8iLtdL3OoOl3Y+O9
         /i48iUfnFZA2nyXhbXo2RoESYENxrhHy6oJ2EoUBn/4rDlnykU6ck+061nyNkLQmBJ5O
         WxhordhRiH16XXpOuPzrDEeY7hbkFdcpz7JRJ9NlvJBRSDXNZlkCpOXlEI9lysGDbwck
         7PYxxKzoTgNe/x9ZoYqvjpwim+zTVs0Yt8Yh2iGKHZgPXZVwMHgz+ZDIGaiz1zcgOMEx
         lEzzPBZTfDX6dvlgjNQZVLQmUJHHYe/7xRQi1kiZBq/+5ZEVJI4xayO+Jwj6ve84f4Si
         qAUg==
X-Gm-Message-State: AOAM5316RpSJBOSLEsk/NYbjl0uokcooYj549FmGqjntfMQhgNkvrPL4
        j6MMUjISHsM+XkxF3gJsqROynpuJwLk=
X-Google-Smtp-Source: ABdhPJyg5njLeAm+mC3Z9+U8q82xu2lfEnBQZv/B8hzUVO3ndVEhzQYS38anl3KOkLOs8xf1S6dJcA==
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr63102ejf.55.1615414258835;
        Wed, 10 Mar 2021 14:10:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:10:58 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] simplify CMP(AND(x,M), C) and CMP(OR(x,M), C)
Date:   Wed, 10 Mar 2021 22:49:41 +0100
Message-Id: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains simplifications of compaes between a constant
and a constant AND/OR mask.

Luc Van Oostenryck (9):
  change testing of signed compares against SMIN or SMAX
  add testcases for constant compares against AND/OR
  simplify (x & M) cmps C
  simplify (x & M) cmpu C
  simplify (x & M) cmps 0
  simplify (x & M) {==,!=} C
  simplify (x | M) {==,!=} C
  simplify (x | M) cmps C
  simplify (x | M) cmpu C

 simplify.c                     | 98 ++++++++++++++++++++++++++++++++++
 validation/optim/cmpe-and0.c   | 10 ++++
 validation/optim/cmpe-or0.c    | 10 ++++
 validation/optim/cmps-and0.c   | 21 ++++++++
 validation/optim/cmps-minmax.c |  8 +--
 validation/optim/cmps-or0.c    | 21 ++++++++
 validation/optim/cmps0-and0.c  | 12 +++++
 validation/optim/cmpu-and0.c   | 17 ++++++
 validation/optim/cmpu-or0.c    | 18 +++++++
 9 files changed, 211 insertions(+), 4 deletions(-)
 create mode 100644 validation/optim/cmpe-and0.c
 create mode 100644 validation/optim/cmpe-or0.c
 create mode 100644 validation/optim/cmps-and0.c
 create mode 100644 validation/optim/cmps-or0.c
 create mode 100644 validation/optim/cmps0-and0.c
 create mode 100644 validation/optim/cmpu-and0.c
 create mode 100644 validation/optim/cmpu-or0.c

-- 
2.30.0

