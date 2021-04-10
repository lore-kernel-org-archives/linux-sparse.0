Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D17C43461
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9177361028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhDJNbO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJNbN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED68C061762
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r12so12928627ejr.5
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ut6UAGUaiFV9b9kVlyDir9c4hl23I/6Etf5cntioMcw=;
        b=erKRyqQZFDOzY/wF2FLHtYFGN367gRNdh7o0Lmz59briF8ipXVTye2g1Ot4vw2BacO
         rgm6r6qgVIdNP487vFs6znKOKaIVWjtFtzJ0i96ZTkeCPBDswduIC7ws8OSbFjfpj80C
         BGutz7AHpf6eDecPq1DJa31cVyLAhiofs9zYLvtFN7RIPHMsZGwpLI/2SbBFxQ0JiTs9
         qgQKy+gfkg2YtuCGgd+WpoZTAqQiXh1COpYlJyZ0UURbN4ecn6tW/jfuLt3eftF7RzlY
         BNpW+LjEYhCPgpFvmPVAnFuLJwgpDaM7oxXyrqAL5+LWqTUn4szyADwtICVvVJjsh084
         UTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut6UAGUaiFV9b9kVlyDir9c4hl23I/6Etf5cntioMcw=;
        b=nqQsafd2L7Yl7Uwm4zxC2PrQufPZu0H+YLpmnaabqlC+EwG+xveUbQ7Y9stqDqNJS4
         BBFt48584hkHunBk+jJXC/dUSD2gcGA4ufCwo99LpXbn+dNBWS/Ocq49sIxD95kDYr2z
         MOzcwPz/KkvphbKdOdkhsdP1UfVcEgfwPFGTEhp0AGe8jKKrYQqZp0vYcB+KgeYvzTq9
         qKFO5am0VxTKke8MOZrQlLnovvVcKDNhGy7GNTt6JyhXUSgv8OtV/fHu7dddKguIIyRd
         O+3OwDtt4HYs4hvmnYqNIZz2ufjyS6KxfZeB7rH9HrHwu9ZMzSpD+DcrJxxcXf+7z80x
         MoTQ==
X-Gm-Message-State: AOAM532B/N5wza097+iuUSIYDxUILHF7nPMcwiMHl0b/GSlPbXmX+McL
        3f4yiDtw7hkK6VGazMIYpItPPUMXFVY=
X-Google-Smtp-Source: ABdhPJwONesIwZU8q/3CvDSE6Onhps1eX+t00IGWz6or0YCIhACaLKrypU0I7jhAlKdZp5MQ8iu1IQ==
X-Received: by 2002:a17:907:6004:: with SMTP id fs4mr19618711ejc.479.1618061458126;
        Sat, 10 Apr 2021 06:30:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] scheck: allow multiple assertions
Date:   Sat, 10 Apr 2021 15:30:43 +0200
Message-Id: <20210410133045.53189-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

With the SMT solver used here, by default, once an expression is
checked it's kinda consumed by the process and can't be reused
anymore for another check.

So, enable the incremental mode: it allows to call boolecter_sat()
several times.

Note: Another would be, of course, to just AND together all assertions
      and just check this but then we would lost the finer grained
      diagnostic in case of failure.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scheck.c               | 5 +++--
 validation/scheck/ok.c | 4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/scheck.c b/scheck.c
index ff91328f681a..26f88a4a028e 100644
--- a/scheck.c
+++ b/scheck.c
@@ -241,6 +241,7 @@ static bool check_function(struct entrypoint *ep)
 	int rc = 0;
 
 	boolector_set_opt(btor, BTOR_OPT_MODEL_GEN, 1);
+	boolector_set_opt(btor, BTOR_OPT_INCREMENTAL, 1);
 
 	FOR_EACH_PTR(ep->bbs, bb) {
 		struct instruction *insn;
@@ -261,8 +262,8 @@ static bool check_function(struct entrypoint *ep)
 				ternop(btor, insn);
 				break;
 			case OP_CALL:
-				rc = check_call(btor, insn);
-				goto out;
+				rc &= check_call(btor, insn);
+				break;
 			case OP_RET:
 				goto out;
 			default:
diff --git a/validation/scheck/ok.c b/validation/scheck/ok.c
index 76c04c4f6870..f4a0daabfe9a 100644
--- a/validation/scheck/ok.c
+++ b/validation/scheck/ok.c
@@ -1,10 +1,6 @@
 static void ok(int x)
 {
 	__assert((~x) == (~0 - x));	// true but not simplified yet
-}
-
-static void also_ok(int x)
-{
 	__assert_eq(~x, ~0 - x);
 }
 
-- 
2.31.1

