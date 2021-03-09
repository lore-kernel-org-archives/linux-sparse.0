Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E50C433DB
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DAA650FD
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhCIXmq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhCIXmj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 Mar 2021 18:42:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB900C06174A
        for <linux-sparse@vger.kernel.org>; Tue,  9 Mar 2021 15:42:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v13so24041703edw.9
        for <linux-sparse@vger.kernel.org>; Tue, 09 Mar 2021 15:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgX260EsUIv++yPlxSlZx3nD5mXwTAvlTAq4L47gMrA=;
        b=HQ0f8yfsvIE8lS4nbuhEolDtHX25C/vjDuU4jsOVd2zCS7zHJ/+L2cq9LRGWxTc9n+
         WCuvEzV6r7dGsWA+YiM0OBIwu/yUlUf/XPLD0RMako4U/i3cxGBwQXOsYnnPNCr5AN7Z
         0QH8b8e4jlrEmS92G22DUBnGg397I0hmFlQVwmDmoYa9gApjfBLg7/UQDwqhhLLJcFEl
         ConDYTu+tOlCppYZPCQMzKm7kchFBHO4mvVOMLm/OhmQ3CLi7cfksuo56v2RwFImJY8l
         fBqPEP1E72Y0NMid9FAfooStOOCMVOlQeMSQZoVaaDK/lvYIY+DwQr8B77Kj8ZTycbJG
         7z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgX260EsUIv++yPlxSlZx3nD5mXwTAvlTAq4L47gMrA=;
        b=Kciv4L/tbpk7y5l6OzbvAZNrHm+1Pb05VKimWEWPvNcNDWZ9mNJ5shYMPOmrrxFb1J
         noiArywIQ/Uw1lkofgGlM3M0+G2HSh5dcZfFLyumrEOL9rRFNVByY5Qq62gf4+9TUqEa
         K6hBlsONmgFpKMqQuGGl+MU6Pjvc9abL0TVolEbK5T+zODqHTxL1knLuT+i/8hosJuHS
         MyjH6OMjHQtMQ01L41GojGpxaH85AokxOQo1oe8scBll8BmcWWyfJMXLkciz5BKlZR//
         S9rHat5mklDCJ52sLh47/qQOMFiMltg568ZiO+fHvE5W3D7HnrV445M5EWqVrr2omBjC
         Qnrg==
X-Gm-Message-State: AOAM530+vPBYv7TpOVOHkN223/88xT4//rgmWbh3paB6cLdMvntYfAUv
        ywkpTgK6lu3/hfax/fZ7iiq9apRwbKc=
X-Google-Smtp-Source: ABdhPJz2YaLtLRgNFzzcO7vYyxknWajOk9tU0BWNk2xNkvZEkgieSoalZt664pkxlsbYNj+4ryrZrg==
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr127215edb.279.1615333357531;
        Tue, 09 Mar 2021 15:42:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:1dad:50b9:7959:c788])
        by smtp.gmail.com with ESMTPSA id cw14sm10147984edb.8.2021.03.09.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 15:42:36 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] fix SSA conversion of mismatched memops
Date:   Wed, 10 Mar 2021 00:42:28 +0100
Message-Id: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The SSA conversion works under the assumption that all the memory
operations on a given symbol always refer to the same object
(same size, offset and type/kind of object) but doesn't check this
well enough. This series now does.

Luc Van Oostenryck (4):
  ssa: add some testcases for mismatched memops
  ssa: the sparse set is not needed
  ssa: avoid SSA conversion of packed bitfields
  ssa: fix conversion with mismatched size or offset

 Makefile                             |   1 -
 linearize.h                          |   2 +-
 ssa.c                                | 111 +++++++++++++++++++++------
 sset.c                               |  28 -------
 sset.h                               |  56 --------------
 validation/mem2reg/not-same-memop0.c |  48 ++++++++++++
 validation/mem2reg/packed-bitfield.c |  35 +++++++++
 7 files changed, 170 insertions(+), 111 deletions(-)
 delete mode 100644 sset.c
 delete mode 100644 sset.h
 create mode 100644 validation/mem2reg/not-same-memop0.c
 create mode 100644 validation/mem2reg/packed-bitfield.c

-- 
2.30.0

