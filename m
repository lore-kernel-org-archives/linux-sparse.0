Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B173EC55ABD
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E00822252
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/ci7DP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgKNKYG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 14 Nov 2020 05:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgKNKYF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 14 Nov 2020 05:24:05 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D1C0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:05 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id o20so13723049eds.3
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CeXqGjT552cCK121/9+kr5jFkrhjhkwTnYcgf2xOzmg=;
        b=Y/ci7DP8KbeZMls0Mmxd3L60DlZHcAED/YG25j5Md44Dv8MmsKXZzLL5p6NFq/w87X
         6CN51PIG6dRbRtA/wXCsf7fJvYKvAnR+7f8HEyzzTynGR8BLCJDX7GPIGcNlHwozonS9
         MELiIIbxep6ZT/ByROM6gAI4eLqC1ExGCXrEir8B5fNBvJ41sTzBtB0SmC/JoXVrKANt
         sadSRVgoJY1IMArMW3lFf+RL+/dYCWRw/vOkbis9es7BP1hA75KZHl0K4SvRO6vYzeuz
         upF6bdTObrRdCy+DPFikk9RYX//OnOehkpTlxBpX9EALaOef3wcFk2xDtjoCIL6VRQBa
         t1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeXqGjT552cCK121/9+kr5jFkrhjhkwTnYcgf2xOzmg=;
        b=MZhqKJXL4sDlAVrFnQTAQDMi4N5IYczQs7LDTsK2+feIR9WaTcZkKbKeiAKwYoKYUf
         hA752PoOezHJivF/wwdKgia/nps+kytlwuNJiw3ioIHvklbMsAWk1+zVwNc2FurgNllM
         QnUEleo3tQ2jrs19798og0KaV1SB52Zhwd7K1VtMmwpEX7d/kNcPCPTZlIHRyVcHgmqi
         /y31HplTql8YXf73XpEEwYVK1ereFHk7qZE7hq8S0iCs/aJ+p4EFsC3NWz9CS7tsLCof
         9P/z2Hru6H0QgSWRlvIw77VgPKiJ+wAKMWzniu44XOp1+wTFtHfIsJyGqzs/XghnQY33
         x10Q==
X-Gm-Message-State: AOAM530BOhSE49PrA6m3mk0agfUTtkiH2lMlZkow0pYaFzjlz7WdX4+Y
        ZwOnrtkoF+4HPUr3NZ4B3bBWCgWB4Kk=
X-Google-Smtp-Source: ABdhPJzKGxCwGw2elr2QMkO+aNgx/N/iHTvxY5cAQU+/K8w6YFzOotDU1bQ9crPd2TP2XY0oacwD0A==
X-Received: by 2002:a50:f40a:: with SMTP id r10mr6811635edm.229.1605349443772;
        Sat, 14 Nov 2020 02:24:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8ee:663e:d7a3:b425])
        by smtp.gmail.com with ESMTPSA id f19sm6479758edy.13.2020.11.14.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 02:24:03 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] doc: add header for optimization related documentation
Date:   Sat, 14 Nov 2020 11:23:55 +0100
Message-Id: <20201114102356.61234-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114102356.61234-1-luc.vanoostenryck@gmail.com>
References: <20201114102356.61234-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/api.rst | 1 +
 optimize.c            | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/api.rst b/Documentation/api.rst
index 09ed0c4d7f9b..0cc830165e70 100644
--- a/Documentation/api.rst
+++ b/Documentation/api.rst
@@ -25,4 +25,5 @@ Typing
 Optimization
 ~~~~~~~~~~~~
 
+.. c:autodoc:: optimize.c
 .. c:autodoc:: simplify.c
diff --git a/optimize.c b/optimize.c
index bfab74c01b62..fd4ecb990fe9 100644
--- a/optimize.c
+++ b/optimize.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: MIT
 //
-// optimize.c - main optimization loop
-//
 // Copyright (C) 2004 Linus Torvalds
 // Copyright (C) 2004 Christopher Li
 
+///
+// Optimization main loop
+// ----------------------
+
 #include <assert.h>
 #include "optimize.h"
 #include "flowgraph.h"
@@ -45,6 +47,8 @@ static void clean_up_insns(struct entrypoint *ep)
 	} END_FOR_EACH_PTR(bb);
 }
 
+///
+// optimization main loop
 void optimize(struct entrypoint *ep)
 {
 	if (fdump_ir & PASS_LINEARIZE)
-- 
2.29.2

