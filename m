Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B3C433E2
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238396192C
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCURJJ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCURId (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 13:08:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC03C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dm8so16588537edb.2
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCVNznYt4xWAEnmklaw669LNcnYdLkZR1+ec1waUP5Q=;
        b=jN7Gj1iIEKM+HATbnIiLGsbhF4krR5UvgqrWD2TwciwsumHb3gi3V4FlQ+Qclt9yNN
         IVGPWKFlz9p/IPfavjff3fa4yeBySH7kBquWWtdzNXbt6LksJEA9G1ZmxPvdpmqrbLU3
         9YTVfNjQvmd3K0thY1hqAI3R0GhEPb/CQXvvxztjMmrm8GLwVjKRKs3AXa4YlD/2r4qB
         t4QqBodQed2khpGYQSVwluiVl+S8UdJrDNXKkya8N7LIRiYDgHDFPxvntDo3Pxp8dTH7
         RglEgAI76bgQUNKlNK3rzN5YeXkvKH94fZ7OViHwnt6EyD+qnkT+Yt+Ij/9rBANx4ebh
         dDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCVNznYt4xWAEnmklaw669LNcnYdLkZR1+ec1waUP5Q=;
        b=SWnM+GaLXGnxJlRbegbEMKgLcZcxHhn8RktIyUGRZXVsx+8293BWT0Nx8Hh33sgZgy
         GS48FwE7UWrqf8fPtvVl501rA1lk+zUQ4mF3b7goIOQFKJmo6OgEmDN4x74fm0KyyLvs
         b4DBW/VBo+NRKCS9sPvr7ntLoeSS+eiPnTz5WxcbD+/8lEPiucnfhHlatDUIR3oObfxw
         cfwzLTitJ5hHjsXM0JkOonfh2AqayPheHtJ7vYnuBfX/3kaZrtGCVp6n3FWBXqN5qtzM
         eLUl3DgK+KtnreWbmNmMx0/Fik9azGQgyKk6pFp48Fodk8TK/HJf+PhePMwprhZbkhEw
         uYLQ==
X-Gm-Message-State: AOAM530/DX6owFPZlUeX3NOUB5vR0nk8AyV6olfQWPSoD8TsZfM5W7On
        Gzc7oxd0B/LRAP5+yamdDbmVVA5Vr60=
X-Google-Smtp-Source: ABdhPJx759j6lLtqlmhzZXdXFWG+boO+6+PkzUDLGWH4o/12jjKJqjSTBK8e1I5oRSy/fU6L34B6iA==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr21297608edr.263.1616346510334;
        Sun, 21 Mar 2021 10:08:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id 90sm9108044edr.69.2021.03.21.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:08:30 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] memops: we can kill addresses unconditionally
Date:   Sun, 21 Mar 2021 18:08:22 +0100
Message-Id: <20210321170822.46854-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
References: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In rewrite_load_instruction(), if the load instruction is converted
into a phi-node, its address is then no more used and must be removed.

However, this is only done when this address is not a symbol.
This was explicitly done in the following commit because of the problem
of removing an element from the usage list while walking this list:
   602f6b6c0d41 ("Leave symbol pseudo usage intact when doing phi-node conversion.")

But currently rewrite_load_instruction() is only used during memops
simplification where the usage list is not walked.

So, kill the address' usage unconditionally.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/memops.c b/memops.c
index 897fb6bf57fe..6d24604c2aae 100644
--- a/memops.c
+++ b/memops.c
@@ -45,9 +45,7 @@ static void rewrite_load_instruction(struct instruction *insn, struct pseudo_lis
 	goto end;
 
 complex_phi:
-	/* We leave symbol pseudos with a bogus usage list here */
-	if (insn->src->type != PSEUDO_SYM)
-		kill_use(&insn->src);
+	kill_use(&insn->src);
 	insn->opcode = OP_PHI;
 	insn->phi_list = dominators;
 
-- 
2.31.0

