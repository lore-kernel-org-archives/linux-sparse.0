Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D2C5519F
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F5B22252
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCXAVJX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKNKYE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 14 Nov 2020 05:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgKNKYE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 14 Nov 2020 05:24:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D18FC0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v22so13683221edt.9
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BYWxGaNA4zI3LMzoNwlKUlCRSYYQDfbJeNecsFKTe8A=;
        b=tCXAVJX+2wEQ1onn3uvoX3Hf8ddQ/OhnkjhsuEyW/TVZqKBsH2FiDUKvWmdj0hapkc
         f39jdEvun2yJXX+pmSqKR1A00BKZGrJ81RQvSJYL3aX8EIRlyfZNVXri0AKf4XLVnGLO
         VwWrydQDkwANuGyTqLvcAFxNpyu42NYhGfjODlwRUaq8uzUMfw7vzn4TuoZYnGtHLMl2
         GyRRiTsVgUbSY8WhrjHrZ0snEZUfzIPYizxz1jzJDh7tIeSjmC31slx61bbixtW/3hnA
         PLm3FYt9T3Slh/MOhygi6+yZxk9ap0QvepXwIlwP3daZNCvlVfft+4fwhcRO+U5zgDLF
         hIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BYWxGaNA4zI3LMzoNwlKUlCRSYYQDfbJeNecsFKTe8A=;
        b=HBnTkM4+1AvKGCc9+fTDaqMUdUzRnrh0bGXkJ67NgzlCwga8RTcNWP0WhUKgQG8BSC
         OdO+ZihpqUn96RImvIWB0303BXeQT2gE6z6H4yfU8k7y6U8YuVTF2A/IWU+OSxBiXYW6
         bGiiIHzXxhLXUCx1M3z4cNahtCCqwDGhcDeHwOFxrZfMkUNk7TiP4zNBeuZqhXaSRdfJ
         wFRGCCgTCPinQV2kJmKNieWJDFB3s5bnC4koZ1BEHRZwenDGHczfgc/5sE0iPHO3kXnM
         srWB4SvS60hWPYf3EvWegl6488ndOu/Q6VTBM/Em9b2H8ioA7jfI4+sfLF5uDPHlvUsa
         dcbw==
X-Gm-Message-State: AOAM5307fiMZiJkvwAE4Bo4gPr7eY1jC6WbSC9sCVZfk4rGmpBAeNvSi
        yA+9vir2MbfWn6YB2nxLTg2wrWYjyHI=
X-Google-Smtp-Source: ABdhPJxQ7W8CO6HvGT4a9BsaKaYoNynGjQRhIQina9bV1swjmrcAtbfLPuFUy2RAtT7I+ntR53cNiQ==
X-Received: by 2002:aa7:c5d0:: with SMTP id h16mr7000275eds.7.1605349441050;
        Sat, 14 Nov 2020 02:24:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8ee:663e:d7a3:b425])
        by smtp.gmail.com with ESMTPSA id f19sm6479758edy.13.2020.11.14.02.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 02:24:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] doc: one patch and three improvements
Date:   Sat, 14 Nov 2020 11:23:52 +0100
Message-Id: <20201114102356.61234-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Luc Van Oostenryck (4):
  doc: fix extracted autodoc when short description ends with a ?
  doc: add some doc to flowgraph.h
  doc: add header for optimization related documentation
  doc: add header for flow simplification related documentation

 Documentation/api.rst        |  3 +++
 Documentation/sphinx/cdoc.py |  5 +++--
 flow.c                       |  7 ++++---
 flowgraph.h                  | 20 ++++++++++++++++++++
 optimize.c                   |  8 ++++++--
 5 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.29.2

