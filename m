Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02E3C388F9
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E12D20E65
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SubQwXU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgKPW3f (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKPW3e (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:34 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD8C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:34 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id cw8so26662545ejb.8
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4mbxrep/FifMdBJ0SCtBC3PkRnSlAxH3RxDKLhkHFU=;
        b=SubQwXU6IO4cCv8ouP4LhLGuk7ADv2gdgNdi2WhUm977oHBluxuAASYuK0Eow5i9Dq
         HFtWy8PhE3yAIqkTjrPzHSBbHDxQZhMP8CS9/k6DVSM7Se4SMIm61BnA45wE4xQ4rJk/
         dEr+7/2yep3zzln7o3pmZK34RxKAd2gPvUos/NYK45rHgCOaBI51m8OW3PajxYItcfBh
         lHGD8uMrLoQKR7Q4KYSNpBUuq+R22dAdSdccUhekVqQlmkAlvGBqM8i4hsZ+F6AkbcNu
         K935Qezx11AM893c1o0AzXXEvpNelsntZb5z/oRYdOG0JOwHBFzYSdw03HK4INlOTbBr
         7R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4mbxrep/FifMdBJ0SCtBC3PkRnSlAxH3RxDKLhkHFU=;
        b=oGSwCAfvavLvks+4VOAQ0KflWAcWpMH7lUbOqueOdmT6lpWvDQaPFB8Zt14D+QS35W
         LD1HTCTLbshWkWgex3RDpJt+63xhz4E0fDA00uwcwB5B6jWbpYbybINfrXPaQnATLbbM
         bNiwEBWV5FJb9lGFtsDziD3S8rxvng6yEk1upjqTpxTL80GHn//oEy78uSHWKTmOf24Q
         XVU/0Mf0JSCmyrRtFJMfT88RYWFKf62QW0RFUrAW3y+GeWzhz+yxlgJZdicQkyiyUrae
         HC9iMohJVjwDjGH2sGqhW8piuV+UHbJYSzcQ/ONJhPBJyUX6GeDaApegBA3hcoSSGiZ0
         ELTg==
X-Gm-Message-State: AOAM532yV+a86XImSjG7JpvqwMdSOXzLppktIqJMV8jNLoP2jQJuPpt5
        ucKzy1gP+F0ZSd7XLC6dmiAuHH5ycIo=
X-Google-Smtp-Source: ABdhPJw2Na+W5SCqGDM80wsGuCGi6ytNQuIZhe6py6RHUBUWeW4upft9C4bs9IJwi9aLWAK6GFtgEw==
X-Received: by 2002:a17:906:8144:: with SMTP id z4mr16383711ejw.251.1605565772832;
        Mon, 16 Nov 2020 14:29:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] cfg: early CFG simplification
Date:   Mon, 16 Nov 2020 23:29:19 +0100
Message-Id: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series is a preparatory step for some other optimzations
but is quite valuable in itself. It adds a new phase of CFG
CFG simplification before any other simplifications. To be
effective this pahse needs some other changes:
* phi-sources & phi-nodes must be handled specifically
  whne merinf BBs.
* some missing REPEAT_CFG_CLEANUP must be added
* simplify_memops() must be called unconditionally

These changes slightly decrease the number of 'context imbalance'
warnings (32 less on a total of 995 warnings) and have otherwise a
significant effect on the size of the generated IR (~0.4%).

Luc Van Oostenryck (8):
  testcase: avoid UNDEF
  cfg: add testcase for phi-adjusting during BB merge
  cfg: extract merge_bb() from pack_basic_blocks()
  cfg: adjust phi-sources when merging BBs
  cfg: adjust phi-nodes when merging BBs
  cfg: add missing REPEAT_CFG_CLEANUP
  cfg: call simplify_memops() unconditionally.
  cfg: early CFG simplification

 flow.c                                       | 201 ++++++++++++++++---
 flow.h                                       |   1 +
 linearize.c                                  |   1 +
 memops.c                                     |   2 +
 optimize.c                                   |   9 +-
 simplify.c                                   |   2 +-
 validation/call-inlined.c                    |   4 +
 validation/expand/builtin_constant_inline0.c |   1 +
 validation/inline_base0.c                    |   3 +
 validation/linear/builtin_unreachable0.c     |   4 +-
 validation/linear/builtin_unreachable1.c     |   4 +-
 validation/linear/call-inline.c              |   2 +-
 validation/mem2reg/cond-expr.c               |   4 +-
 validation/mem2reg/cond-expr5.c              |   5 +-
 validation/optim/cse-size.c                  |   5 +-
 validation/optim/memops-missed01.c           |  23 +++
 validation/optim/memops-missed02.c           |  14 ++
 validation/optim/merge_bbe-adjust_phi.c      |  23 +++
 18 files changed, 269 insertions(+), 39 deletions(-)
 create mode 100644 validation/optim/memops-missed01.c
 create mode 100644 validation/optim/memops-missed02.c
 create mode 100644 validation/optim/merge_bbe-adjust_phi.c

-- 
2.29.2

