Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C9C433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAD365018
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCFKGB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCFKF6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 05:05:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C3C06175F
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 02:05:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id e19so8759688ejt.3
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 02:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9xz+7x5DoOv1gaYk2ZCxoJ4h5OVhaaDxi/twhoDWlk=;
        b=cR1ny/YPP8ZpMDPrAT6quwu7+tdGE2pPTJ1sPCXYPHTLvLEBmzkghtL5kjzr+u3wsY
         aany13g5okckovc6AQ87jX+gua4vDsbYP23XD/Yh4rFhrk4GE5Chn0CTQWZDEcqJ1kgV
         g69sm8tbYgntVboyq+yWPDAuqhofTYJUg3n8OlTVPvGzqyc6JAj3x2pFqkigLFV2IxBK
         gYRtkla4Uh/ZXgFs8URoRdbPvbEK6HhV0afTD5akSoelqoedlz5bzetkXcMJb11FkBK3
         PRkfls2AuSvBCensDiwMfm9JhZ1ZjkBBbxZxmj3uhOHJMeIh4y+29nasy7uKHxQltmUO
         pGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9xz+7x5DoOv1gaYk2ZCxoJ4h5OVhaaDxi/twhoDWlk=;
        b=DadXTcdnBOoN9ORoEw9FFq4HgFOIBw2k6Szefa1Bt1AiuxOMfQhnxOBj7R9m/PhoK5
         CYjUGwpKv5ZErwxrdd1L0tGxZ6pPBBUkwxOjLAMuOv4DWucYwkEK2AvIH2Nr2J43+P4J
         jeb5611L8rvmmSxUstDMTCG9a0yTOLikDLC4KBZ9nEXeA9EEp52x6pHvOGxhxXN2gvye
         942LW/6j2aVp7INce1fs6uS/MDj5d+OheMAWLyrOFMY/ad3q2C22s76sMvqwOf5JXHAx
         q/bdSqAPZoSWIXL11JsbXn7ZncG/I85gujYOS3x9OD222YkHjogxnDio5qkoeHdHlbwn
         sOcA==
X-Gm-Message-State: AOAM530QhyAmTXqT2clAJAAjYEdZ+VwvtQ3zZHKAy2wMPzbB22/hUYYj
        axXL4fg73E4C/g7Nlp2qPeB5QC0F9IY=
X-Google-Smtp-Source: ABdhPJykqjhjLqfaT3mOGf/mMB8QQfkicDu5uwn5RLFzqbu26KtMXtoQkKEkeBd/PTiPBgPoQfppbQ==
X-Received: by 2002:a17:906:558:: with SMTP id k24mr6344552eja.387.1615025157011;
        Sat, 06 Mar 2021 02:05:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id i11sm2624020ejf.76.2021.03.06.02.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:05:56 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] small changes to ptrlist API
Date:   Sat,  6 Mar 2021 11:05:46 +0100
Message-Id: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains a few changes to the ptrlst API:
* let TYPEOF() return the entry's type instead of the type of its address
* rename TYPEOF() to PTRLIST_TYPE()
* add pop_ptr_list(), a generic macro
* make linearize_ptr_list() generic and rename it to ptr_list_to_array() 
* change the return value of linearize_ptr_list()/ptr_list_to_array() to
  simplify its use.

Luc Van Oostenryck (6):
  ptrlist: ~fix TYPEOF()
  ptrlist: change TYPEOF() into PTRLIST_TYPE()
  ptrlist: add pop_ptr_list()
  ptrlist: use ptr_list_nth() instead of linearize_ptr_list()
  ptrlist: make linearize_ptr_list() generic
  ptrlist: change return value of linearize_ptr_list()/ptr_list_to_array()

 ptrlist.c  | 10 +++++-----
 ptrlist.h  | 22 +++++++++++++++++-----
 simplify.c |  6 +++---
 sparse.c   | 13 +------------
 4 files changed, 26 insertions(+), 25 deletions(-)

-- 
2.30.0

