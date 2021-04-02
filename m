Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA699C433B4
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A66610A0
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhDBU0J (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbhDBU0H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Apr 2021 16:26:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E974C0613E6
        for <linux-sparse@vger.kernel.org>; Fri,  2 Apr 2021 13:26:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so2552314ejy.7
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2021 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9CUYfC2gKkzWfALajo2Bfttt7W+OMdkhA4/2s4Af1w=;
        b=Zz+zt93A7YI3dElh9+jGetieE4Zdh2neyBYerEnsz6Ttf1qmteLhWawW2ZCYtBj7gh
         e4qNVMQrJgY+qo+8aPpntTpChPnge40wBlzxIA23DMIgeWvI1Wy7y8axyl4LqI7Z4/uu
         h1u2k8T5YhACe/u6zCeNOC5H97RezINvQ60ba6NUyOl3I6JRYmXRKegEk34el+uJm7i8
         Ykr126Ydw05tDKPzMYd4HEiA5RF02XhHqR70o63U+1AfYKVJ16rm7IRx0jaOAyqJUOD+
         /E0Ajq5PhMaD/rsDXLwX19tel82Yxgj2/w9tceQDJhuuASMXmDLMGE+1yY5DCvIrtdJQ
         YYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9CUYfC2gKkzWfALajo2Bfttt7W+OMdkhA4/2s4Af1w=;
        b=nCmlJEFai9ryHQn95y84tQgOcrpdjJ6oJHnoBvtjvkN9WHjN8A5fILDlsN0lrTguOq
         DMZlgnbah1ToxahzggIhgYCYK4acIp1QA7J40o8GAgj8ZfVQgrk0aR4HNGQaMJT4v6wx
         Tc8V6nFfI5apifg+vER+n+XX1ZbZRgL28jBGzxlO0Y5QvphMPGynzjUHOoJ4TMgM2LpW
         buTQDhf6Vls4q3ropWwiFYiUXMEU0TZP9VUPAdDObZPaGrUBpqD9QoUodxtzAFusmnCR
         YQmJ4V+2VsEXLO4sUT6tIAACv6b0Jn96mLmtSci/nbumc47na5nnQXP8tvRpp+zMzhDP
         QWgg==
X-Gm-Message-State: AOAM530NyNtXimZI7oi26Pim7/M+47vnhC0TR6Py87RMvXnkBPsGIuM4
        o9PX1clG9YWbX7ntYPQ4tmORvL4OlXM=
X-Google-Smtp-Source: ABdhPJyHPqm5wdVNOrqo+FOd7tfGSORS9MU8xjVYUPzE2Kga9PLFfMNWjAYSNJgdr7+wMZxc5q9p1w==
X-Received: by 2002:a17:906:6bcf:: with SMTP id t15mr2071650ejs.252.1617395163139;
        Fri, 02 Apr 2021 13:26:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8a3:6a32:4891:b7b])
        by smtp.gmail.com with ESMTPSA id p24sm6011890edt.5.2021.04.02.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:26:02 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] fix 2 problems with phi-sources
Date:   Fri,  2 Apr 2021 22:25:54 +0200
Message-Id: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series fixes two problems relatd to phi-sources:
1) fix and improve the check that protects try_to_simplify_bb()
2) fix remove_merging_phisrc() which couldn't handle the case
   where there is several CFG edges between two basic blocks.

Luc Van Oostenryck (4):
  additional testcase for remove_merging_phisrc()
  correctly count phi arguments
  better check validity of phi-sources
  fix remove_merging_phisrc()

 flow.c                          | 53 ++++++++++++++++++++++++++-------
 validation/optim/multi-phisrc.c | 23 ++++++++++++++
 validation/optim/phi-count00.c  | 27 +++++++++++++++++
 3 files changed, 92 insertions(+), 11 deletions(-)
 create mode 100644 validation/optim/multi-phisrc.c
 create mode 100644 validation/optim/phi-count00.c

-- 
2.31.1

