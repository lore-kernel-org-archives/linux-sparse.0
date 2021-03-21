Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A968FC433C1
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EAA61934
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCUQSZ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCUQSN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 12:18:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4685CC061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so17372084ejc.4
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NF4j6hscx71Wh84EnFKkas0kfHACZT2i0U6zwXqCabo=;
        b=pe/8/taMlR1kJ9MhgufaEcL0JIptFZZDYePL74oR5htIoWeT2Qr+3DoYTNR8rG511z
         zGLHnnJXO0QxR3wbvV5fPYIuvysYSsJJWrITb9/GArlWQPWpARwcBXqlZxCOh2/p2BIc
         8O3RDAGOwklFI8HcbLRyt76jmI9OxOIcxYU3e1IT+/mufgL9fKkDe/4ISR3JLhIrEuDK
         XN34RzZN37vrkbOiF4l5PQidAI3ibib0FtBF5T69V8W+wymOs+m1bf5t8whRUi7Pn1OS
         fXv+J6zBwEhd7vTmoOx/6D/yogyJnN3ZnWquKlUyurtQ/dKboVoL1K2pyKe/mrXV2Y6k
         FKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NF4j6hscx71Wh84EnFKkas0kfHACZT2i0U6zwXqCabo=;
        b=ekKmDzKVCYPBDCs4pBP8eDmEH1MVqz8b+Ug+rHpuat7S/BrGS3GBf1LUU5IY8UU+kb
         kUy1ZLitnors0sdPBbsOHUqBtTnkdrbpWlTkCYLJJVx4uhndAzjxFF/sovaQCH+T/H5L
         44m16YNsuJ+0ZEBd+WxFDJ4I30NZs4W7oktJ2OlfSjKCK2NhhQfCiJ68w1llcBIbENnz
         y8HNq0UjJQCeLZb76kfHW0HKWQQ3WOeJbnYNwd1QTjn6GIntL2oeqIjgh/A/sqMSZ1kQ
         oBkw+X2tkEHlLFTGE0VRRpwB8iyH84VsF/6BirozgvhcXHHOmOw3ntYNHrZ6+tC3FykB
         F8Fg==
X-Gm-Message-State: AOAM531Oat/yPD6RXbVG3yb50UpF6ewVLtBgkDvE9bCvbmbJAcCghMtS
        E51GvhPFpprpm1K8RIsnWpzCHTK87io=
X-Google-Smtp-Source: ABdhPJz+2tjZecOdqj1yLFs9j9yvgGWp31kPWV4rPRHWHbvh8q+oSBFG48+aazEccfikBSbnssOhCw==
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr15179710ejc.333.1616343491872;
        Sun, 21 Mar 2021 09:18:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id c20sm7390295eja.22.2021.03.21.09.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:18:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] use an helper to add an instruction to a BB
Date:   Sun, 21 Mar 2021 17:16:03 +0100
Message-Id: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series adds and uses an new helper to add an instruction at
the end of a BB.

It's a preparatory step for incoming changes in memops simplifications.


Luc Van Oostenryck (6):
  add insert_last_instruction()
  replace add_instruction_to_end() by insert_last_instruction()
  let insert_select() use insert_last_instruction()
  let insert_phis() use insert_last_instruction()
  let find_dominating_parents() use insert_last_instruction()
  let ssa_rename_phi() use insert_last_instruction()

 cse.c       | 10 +---------
 linearize.c | 14 ++++----------
 linearize.h |  8 ++++++++
 memops.c    | 10 +++++-----
 ssa.c       |  6 +++---
 5 files changed, 21 insertions(+), 27 deletions(-)


base-commit: 7b5cc7b6135733cbbce121cc94fdc4a5400f46b5
-- 
2.31.0

