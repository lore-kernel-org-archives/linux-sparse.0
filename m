Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F152FC388F9
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF5D208E4
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIw5+hiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKGLm3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKGLm2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 06:42:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4943EC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 03:42:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q3so3909105edr.12
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wub3etaCE4eDTRubd6gKXqXHKz7lH/5MZFosRqVRQQM=;
        b=oIw5+hiW3ENog1voJ3pb/skbd6dTLmqYPYbU/PFFquTkvGkRiRLI49af84Cig5MuXU
         HO4P1UaWcnVQqG1RNB36zBeACKp8S6Ik8l6x5GbU9Uc7dTauLiE+iZX+ROK9D4fgrJiE
         4JfM/0qZ26LN5xPGC0Vz4l8DmQHWVmfXsCUOORNqPIArQqNdYFouscFQL9LzVoJuw1d7
         F29BA0df61tJ6PiDkoWb93eNw36DKLIXbFsynFgMJ4J8nel2jZxPz2MYhhkSSY/AziU9
         dDc+dhghGh4EEA9vJzqOzHW8K4VClPMFTRr2c+L6L9nDT2huhzMmXuQAlY0bryqH2kSn
         ooXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wub3etaCE4eDTRubd6gKXqXHKz7lH/5MZFosRqVRQQM=;
        b=Nh444RIHhOLCrYrXLctLiqn8oQ45YN4bnO8mrCTNbrMD5mkwXdO1/hXV5q6M4rMXFz
         9goWq54QczOVmKmraQ7HVfX7uFzdDuX+AD9/LI2n4JCgyq6yu7qvO8vvu+gSUi+9mdrn
         TVDBxhEaoAJQyeqqmUoyYKwa1Xc3sqGx1ocZKJ7aY74BQMfrUgvQVDtsEmKSQf0cj1LW
         Gj4HRfRJOLUBt5F5VmpTwAYgu/NTyaAWw1keF4tf+tfquxlHAcUVnQpe+tMoHCn6bHBV
         d15p3RX4jpbA6kfN9FJHV38n4hoyuM19qs+mJNHnQ0CvSIhh1FrMIDOTaj+YSdXgDkfS
         GLOg==
X-Gm-Message-State: AOAM532LjF6p1oZdarY5I5rG365BNiXO9mLUh7Jw1wl2ui6KIDSwfA1F
        BkoRjz7V2dLO5IEnQ4lsSPfd6pxsEBU=
X-Google-Smtp-Source: ABdhPJy+0t6PEZQWQ6vuV4ShrU34ehf4pgjUJBTiyLqhzRdZ5Nic2/cZaC9cWKaJbU7qEe8OKbugmg==
X-Received: by 2002:aa7:d690:: with SMTP id d16mr6409490edr.329.1604749346271;
        Sat, 07 Nov 2020 03:42:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9030:856f:68be:7b84])
        by smtp.gmail.com with ESMTPSA id s21sm3308311edc.42.2020.11.07.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:42:25 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] simplify SEL(SEL, ...), ...)
Date:   Sat,  7 Nov 2020 12:42:17 +0100
Message-Id: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These patch add a few simplifications when the condition of a
select is another select and have constants as operands.

@Linus,
  The patch you wanted is patch #3.

Luc Van Oostenryck (5):
  select: add some testcases for select simplification
  select: simplify SEL(SEL(x, C, 0), y, z) --> SEL(x, y, z) and its dual
  select: simplify SEL(SEL(x, C, 0), C, 0) --> SEL(x, C, 0) == cond
  select: simplify SEL(SEL(x, C1, C2), y, z) --> y (with C1, C2 != 0)
  select: simplify handling of constant cond or src1 == src2

 simplify.c                                   | 40 ++++++++++++++++----
 validation/optim/select-constant-cond.c      | 10 +++++
 validation/optim/select-same-args.c          |  9 +++++
 validation/optim/select-select-true-false0.c | 10 +++++
 validation/optim/select-select-true-false1.c | 13 +++++++
 validation/optim/select-select-true-true.c   |  9 +++++
 6 files changed, 83 insertions(+), 8 deletions(-)
 create mode 100644 validation/optim/select-constant-cond.c
 create mode 100644 validation/optim/select-same-args.c
 create mode 100644 validation/optim/select-select-true-false0.c
 create mode 100644 validation/optim/select-select-true-false1.c
 create mode 100644 validation/optim/select-select-true-true.c

-- 
2.29.2

