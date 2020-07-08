Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DAC433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74052065F
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHQ8YFyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgGHWUl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWUl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 18:20:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB1C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 15:20:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so132126ejj.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F50M5FjyvPeOOuXh8PyqRzyshdMTP5LaKsI6zHuhTjg=;
        b=tHQ8YFyxAq4iMRc7bNuypUCt4oI1y+qCvWHZ7klBb95l2EDtFdK2X/g3XUGiUrOCqJ
         uFHjjC/dxfhe+oc1FcIr/XN5RD43cEdVlN6rIaJa+/+inMFfJLShdsFqIgAbUzXN+uzw
         fFWtLMGUcvjCjU9ujEDtOtEUOQSI9I+ZP+1kzFZM58zUAt2jzAE/nD+z9jFauDbTEWhb
         IKZ5ecYtWyPtFNU3O7sH/7zJTdvcCV3mqtShii9PH2P7jalWASASRMCFRXThkKhR5buc
         fqAo5Dtrv06b2ZLTKZwUs4OcZ9MK99U91nbjByq9OrQnxOt6wU8CsLAunDVJYKesL4Yg
         W8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F50M5FjyvPeOOuXh8PyqRzyshdMTP5LaKsI6zHuhTjg=;
        b=HgebeXcbMoHMqYvrdj3Q0a7kbg35Iq2T9sjxZOdcjBg4PUwBfTpsv6xpXx+oyTzZBk
         NXlMYm1VqGs7suVZrcv0jcAG93Uuap/Q9x9zzWCPf7iT85KAOsMegPswQJC9LFtiLthN
         lJOHlxr5wMcZqPodXApUsOEm6cqsltEmfmiownizUjSmMMJm5MmM7MFxtcU6xeYQ2Ft8
         1ZRu/4ft5F6oD21h80v1xme1J27X2ErCJ0FxsBtNUWMh+2CCQP0ttVNm9tBDYYXhnmwS
         xJC06bASoGE9ARqRhTPbNdYLQyPNE6DER4AjWqZsviBMOprmyf4eU85mPa0nuuyB+91f
         OBlA==
X-Gm-Message-State: AOAM533X+Oces++wLaEFrYQPKBbKoDFxcbzilj18gmWgQquzEEYdFNkV
        HEzjH9P0/sri0RrkDNrciK+L5u9n
X-Google-Smtp-Source: ABdhPJwxZvoWR3ctoD1gZvF7N/IXGdETysAV/wcp+AKH6gGAwleT0eYLspEL7AcMmRDELRbXMVzbiQ==
X-Received: by 2002:a17:906:7b54:: with SMTP id n20mr52827260ejo.144.1594246839558;
        Wed, 08 Jul 2020 15:20:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id ck6sm567571edb.18.2020.07.08.15.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 15:20:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] small fixes for NIOS2
Date:   Thu,  9 Jul 2020 00:19:14 +0200
Message-Id: <20200708221916.56665-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Fix the width for 'long double' and add the predefines
with only the leading underscores.

Luc Van Oostenryck (2):
  nios2: long double is 64-bit
  nios2: add non-trailing double underscore predefines

 target-nios2.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.27.0

