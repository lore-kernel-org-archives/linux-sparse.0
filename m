Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D1DC433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269A064F06
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBYXj5 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhBYXjz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Feb 2021 18:39:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8CEC061574
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d2so8899157edq.10
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/O5+MLEIriusdWYWIu0J3+Z8k55hc/0mTpoGYUgi/A=;
        b=grHHXtwAtYTCGpl6lyR2mDVpic5sd7k3VJ2c30hV11PPMAcJOwJahKw0YhGNv9Nt3Y
         4cop8RkpO4CKvHtOOqD7ZcOCCIFIDL6HViFIjyqcivJX+6rFITsA06UWuPEG7HGKSgqC
         sqTJl+ld/3LjHFADkdKGOAEVJOZ6hklnLvdeFqpiwTfCUr2U+suFSjvYa7R+SIxPKN6H
         9+630KYFuv6wiGcz47DZ6TcDYO1LpRGAatZ8Pw5ZD8xIXfr9tS0FfV2Ij07ZaVN3UK8w
         EhRx6zOjecDRcw4w6ubyJ15PYEQAtghGRj8LPWJKcU38KBCspvmMQtovf4jMNJEtFjMB
         WGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/O5+MLEIriusdWYWIu0J3+Z8k55hc/0mTpoGYUgi/A=;
        b=RlGwv2etsgxjvMh293LOtMNlQQpDc0giyzLEjJCm84ZGkT4qKYywQerubWvdVUq7+B
         9K4cO0yAT1iy0yulEp+k8HwqQ2KFY7pLqjMEFkwlMGqMRncbBohuGmmtQCfJ2qjCb625
         7gs3DwNXM8H5HUcqpUysE5Oi2fyHlJbElWrLdzW8VOgUegJ2trV7a1TPpeh02P5izU5O
         kiZzvNM2ZztU/MjF6ZxvXlaGTEYkdwe8+zv+riWO0WwPRBFfmzmc9nZEbQLwu7BbqhYM
         7GojC7TtfBS53R8Rm/htpY9FIn8GdRVa5Uy081uN77RQbnxk9gFZXrhWQYL6K/CgqgJq
         e7/A==
X-Gm-Message-State: AOAM530VLwNO8qx52XrF5ohXRzAw9XrhMhEoR8BfNXhZWGZteoEKKrE/
        ZFdjrUFQS8G/GMIdFpqJrk3JDycijIA=
X-Google-Smtp-Source: ABdhPJxd6b48IbIsvjxTmDFtJGJKjO5hNoF0l1dFw3Ehxr4AijyoD2O7wbLqBSlgHhr63ttmZBc4Tw==
X-Received: by 2002:aa7:c80a:: with SMTP id a10mr404197edt.380.1614296352380;
        Thu, 25 Feb 2021 15:39:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:2cfa:d768:30f4:f221])
        by smtp.gmail.com with ESMTPSA id q27sm3906167ejc.74.2021.02.25.15.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 15:39:11 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] small reorganization of OP_SLICE
Date:   Fri, 26 Feb 2021 00:39:04 +0100
Message-Id: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Slightly reorganize OP_SLICE instructions in preparation for
some incoming changes involving them.

Luc Van Oostenryck (4):
  slice: remove unneeded len from OP_SLICE
  slice: remove unneeded nr_nrbits from EXPR_SLICE
  slice: OP_SLICE needs the source's type: make it a kind of unop
  slice: display the source's size, like for unops

 Documentation/IR.rst | 2 +-
 evaluate.c           | 1 -
 expression.h         | 2 +-
 linearize.c          | 6 +++---
 linearize.h          | 5 +----
 liveness.c           | 5 +----
 show-parse.c         | 2 +-
 7 files changed, 8 insertions(+), 15 deletions(-)

-- 
2.30.0

