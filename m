Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E465C433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09C761027
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhDJWbN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhDJWbM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 18:31:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76770C06138A
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so10607008edu.10
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSOGM+3xs/3F3ITRMFqUYZnknGrTu1A8SQ75eFql5Jg=;
        b=SgHtSnLRYOZGvdB8F+P2f4hyO78uEG3oZEeyeRiQzK7Q2Pdu2MyxN4i4+1jiqm86XJ
         BkgFspHbzJVIfoCG1G0raPbmde05l0xisSHcf/jptWPNrrlo4wZ1xbW4TBAXxs/CD1fO
         Zu286lML2dVCS+s7meEh8wMcM23aY+7vpoqrBT/Yw5KW/WsXmpT8EIp3RuwargGPJUBm
         ush0A38Stjk5UL2iuqiEyOnw7R2562aKcbP8h4Y/+VFQkN7q881WEyrQ9gPGInYqYvYP
         Ub9ElI7HZfYAi9KRs8C8fTBIJQN9IodErbYguOqVEU1uae728glG7N6h5ZGSgjlMTdpb
         c5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSOGM+3xs/3F3ITRMFqUYZnknGrTu1A8SQ75eFql5Jg=;
        b=aDBNBPKkjE2IUPKb9x5tYjDnfUr6tC/3XV7PX2clcgQLkb6RiB/MVn2KuiLfyfkFVp
         QQ7zeWBsksnAzaAHc8tvIKULCkX+CskT83bp1bT74xVjvyvVMUTkTZPq6JLZl4sx2zpp
         sJpzeZNT/DQvc7tMBMCwDGqKvsYcHEtpHtMmAev6pJGxt4xoY6wW8DUBt6hEkNxN6uIG
         kOh9inbFeSCNIvZveigmWN8utAJjza/x7mKqo8IviV/mRrw/fQzCa90hCafQ08+DIvTV
         sZztta+xxNO42tt3GNpXIVQ5i7ufumOsF3UvGAYzbTLcxyFUsymuZXpfvVbJXXZea9H4
         yCFQ==
X-Gm-Message-State: AOAM530nnkpJXSGI+/H4H7zeNxEEQqe284bArpYF8Fd+l8OwJAT4vcxH
        Vj8S3naZcswvqMa465nxw12oc5deDf8=
X-Google-Smtp-Source: ABdhPJzl1pKF02GghRpIZtkisxh0EETrwqYd2YJUMElauLQQDrt3V4AHEXrfETpgIiMTWMOy30Mr4Q==
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr22483672edc.131.1618093856083;
        Sat, 10 Apr 2021 15:30:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9597:4a1:b5b6:4666])
        by smtp.gmail.com with ESMTPSA id q18sm3701372edr.26.2021.04.10.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 15:30:55 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] kill more dead stores
Date:   Sun, 11 Apr 2021 00:30:39 +0200
Message-Id: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series improv the removal of dead stores:
* kill deadstores in parent-child bascx blocks
* kill redundant in the same basic block

Luc Van Oostenryck (5):
  add testcases for stores simplifications
  extract try_to_kill_store() from kill_dominated_stores()
  volatile stores are never dead
  kill parent's dead stores too
  kill redundant stores (local)

 memops.c                                    | 53 ++++++++++++++++-----
 validation/memops/kill-dead-store-parent0.c | 14 ++++++
 validation/memops/kill-dead-store-parent2.c | 25 ++++++++++
 validation/memops/kill-redundant-store0.c   | 13 +++++
 4 files changed, 94 insertions(+), 11 deletions(-)
 create mode 100644 validation/memops/kill-dead-store-parent0.c
 create mode 100644 validation/memops/kill-dead-store-parent2.c
 create mode 100644 validation/memops/kill-redundant-store0.c


base-commit: d549d4d55eecb394e3f69314287f91e85b19e3e3
-- 
2.31.1

