Return-Path: <SRS0=8Fyo=DL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE101C4363C
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B9F20797
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 11:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmMr/aqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJDLny (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 07:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgJDLny (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 07:43:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB97C0613CE
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 04:43:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so6024760wmi.0
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GTXqPE5C051bpd3xRzerX+kqhJ1tT7fcen6fXZc1wn8=;
        b=rmMr/aqFpr3er/i0sLcCgaak/hFjFIyKyM6VUDsdhM2w2SrkMgn5wIjrwCW8Mg9+n8
         otxZIAxpSkqnMbOCe8yZe4jPCTNSQ2LMFOEzfo8xKduymLasYSUcXsTeOmHJ+rALLZE3
         AE3Rcg8WHovIATQSRh1k1msiKrAFUI16UyefS5IBKBctFmQmkxWMFei+fdqaksxPuHI1
         n3SJpyvFlr8p2mwE9GiZ+vGZx2xZYMDGPXMz2JbfHGrF7IbLxe6GrQgg+sbXBnb6U60s
         eVqntKvzvbLakbz47vQOmwnxejluaaepPrSHmTjLiReRManAjLwqquL+ggHG7tEzOkSb
         IvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GTXqPE5C051bpd3xRzerX+kqhJ1tT7fcen6fXZc1wn8=;
        b=AwWh7QgPUCCS+ktNlbLxu0Ozz7s0olEXhJ//n42KW5SCW1DcAT+t2tI/CmNhMnyFew
         5lmmUOm2fSc0MIfHilkcx6dAO+YTD9sBb4fwMkNjyUwDJy+4vqJNraQ59tJ5Me+/N1ua
         /oXRKDNC86GcMGMA6RF8sfIZIeG9jssfOywEWHiowqG5vqzwmX5krYSUsjAAq1++PrTH
         Rsn2gOIe8NeapejXAetzlSfB2RYTiO1oO0HusdFYR+eNIjCK1pumuJn7iiUBjntDVHUU
         k6STGCbFnr/8Vb2d6NtBlan3uxLMYhb4pRvECKOp034o8nEud3WfGRIq1uac90XFcli6
         BmTQ==
X-Gm-Message-State: AOAM533CxarS6qYA7a0ndAkz1r8ZkPxY8ywrG4M2b8bWeLhb1OW/ijjh
        YT0vpFA57oJKjcieXrVcQrlu0RTXpNs=
X-Google-Smtp-Source: ABdhPJzDSPk5M7Diijpym9iOLux27BmP+N3C7P5BVGtbWHKLfmytyJW6bW6CvxvkmfQsjRt12q+3SA==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr11685709wme.188.1601811832384;
        Sun, 04 Oct 2020 04:43:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id l19sm8244801wmi.8.2020.10.04.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 04:43:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] add some builtin types for printf format checking
Date:   Sun,  4 Oct 2020 13:43:46 +0200
Message-Id: <20201004114349.81440-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The checking of printf format strings needs a few more builtin types.
For example, a type for wide string is needed for "%Ls" and more are
needed to support "%n" with the different possible lenght modifiers.


Luc Van Oostenryck (3):
  add builtin type for wide strings
  add builtin types for signed char* and short *
  add builtin types for size_t*, intmax_t* & ptrdiff_t*

 symbol.c | 19 +++++++++++++++++++
 symbol.h |  3 +++
 2 files changed, 22 insertions(+)

-- 
2.28.0

