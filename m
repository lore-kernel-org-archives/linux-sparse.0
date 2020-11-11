Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E4C4742C
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA9B21534
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMOxZBk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKLBdq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgKKXwl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Nov 2020 18:52:41 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBBAC0613D1
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 15:52:41 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ay21so4201519edb.2
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 15:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRPX+3QTJQt/Ddz0V92IIvauoN2kzc5Byd5oCCuO93Q=;
        b=vMOxZBk1xCW8fz1iTBtyHjP53aqUFM9b+qLnCGXnwSbHQ/c8k9XBcACsXTZLvqeS1B
         a33aqx5oNqGA1gjnKk2ulab17Soy2jbg6LPLpCWwo1Hha5m3Iw5US1tE+zww3756aDrl
         146VgcmWB8sF957M84bUT315OtdR1tV8G+ls4dd7yEQyLFJe+xcusjvvQytyO2K7nARY
         nYoNJE3OtO3i3s6pLxrVp0VKpTPnni7XlO/iJsCVN+2yBRwiglVt/YKo3L8l1RQ+/avz
         4I03Z32uMdub1w6zSoc5mYWOsN4b39fj5ZmFbaiy2tHZuxpc8on7i5DlB0dKslZwnaVw
         6Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRPX+3QTJQt/Ddz0V92IIvauoN2kzc5Byd5oCCuO93Q=;
        b=kuf2WcaGnooTwwuHhvpJIcyI2UDJK7hHdT2WLXTocnSd6+3HujYiOnpscenYmDfsB5
         d/lydOgRzbji9ImRU0fwTvIy1+4OaGOcoEUF7spfTWolgN6gPLrgg0Hpo0Q1JJ96hQio
         8YT6sCXEaEl4+Cg7fMz7+X97Q5/cw1ZkerY9fWzgVBwE/5euVUOFItZazadqRSjmzc4m
         env3O5AxDj9nTFkQfkPb+jr0T983sguRJqL2eN4O2o0h9kvoGAn21jcg3/LQmL54VQmf
         5GI0OoM5wi5QoKT3hf49LsKocJHuxbPssNr+22lJGjNT5V6z7LpIplkmubHvuMYGmm9v
         Ixlg==
X-Gm-Message-State: AOAM530tI4eUp3o+S1Dpj3WFGrndJxswFGebWHXOipSnZEwRHMM8bkAV
        780z8B/U5Mci2s2+c1GdPYzvp0FJfl4=
X-Google-Smtp-Source: ABdhPJwfX60gm2K/uy/4HHmlD53lVd7s6H26Zdzccw8hnIyEad3VYCdE7Cs1NWPuB7J8V2SDTFQEPQ==
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr2173948edt.219.1605138759460;
        Wed, 11 Nov 2020 15:52:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:28a7:5fc2:f4ab:be33])
        by smtp.gmail.com with ESMTPSA id 1sm1391398ejt.107.2020.11.11.15.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:52:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] adjust phi-sources when merging BBs
Date:   Thu, 12 Nov 2020 00:52:30 +0100
Message-Id: <20201111235232.78450-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When merging BBs, phi-sources from the bottom BB should 'overwrite'
the ones from the top BB which should be ignored. This is currently
the not case and both phi-sources are present in the resulting BB.
This doesn't make much sense for the corresponding phi-node and
also causes other problems like hindering further simplifications.

This series contains a testcase and a patch for this.

Luc Van Oostenryck (2):
  add testcase for phi-adjusting during BB merge
  adjust phi-sources when merging BBs

 flow.c                                  | 28 +++++++++++++++++++++++++
 validation/optim/merge_bbe-adjust_phi.c | 23 ++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 validation/optim/merge_bbe-adjust_phi.c

-- 
2.29.2

