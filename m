Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D5C43461
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600D520760
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSoe1MnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIEMOK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgIEMOI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 08:14:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1195C061244
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 05:14:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q13so11940409ejo.9
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxGzZnbNeC6bQNhTQk6zKpvF00KuZK2z23uwMDDI1no=;
        b=LSoe1MnC0BP6aQ1/52b/rltK/dixwIojGn4/WJztW/S5Dv07cPWx6indqPI5gdTyf5
         Q2JgOYQjxwbm3f7ftUEaa17BhWzYXhotvZSGSkBxFg1b9Jj0PtIkCjXcz7edEBe76klO
         IVP/ekFHKSP3R1njpJr8Akz8yOg0Tq6iTNJwXtgS1AZWR+pT7bz3CghRvFf3q4TJ+rU3
         OUnkv2ojI4H2cy4FWc/qAwboI61d5OOBb+Q1uCesczaj2qLN4SCgl/dKoh0S45rk8uw7
         TR/cn0dRdoxhFf4Jq/FoyPzw7o5/d6tIxoTzzh1goGDPqr7k8l1KP9f8IxV/FlfsLp5X
         smzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxGzZnbNeC6bQNhTQk6zKpvF00KuZK2z23uwMDDI1no=;
        b=ofweuC6A+qJjS4LoXtfNLmFrd7/30fOqLXvKZGgE9wR2GVruun0+gcRYXovNZWNtRI
         MGVgLW5s155xoJKJJMFnxSMqK/M/XEyQG0GJWB5gN8mFUREXb9vbWWqd7UNZ5rNk2EG+
         v4QHR/ui0ERhN1a0n/AdbiLYJydyjewV6ZwGYj2b0JF461wcZGbJoOvD2lUCCo5/NgQL
         r4QxMpAlxoTPxX94Mb13ozN72ZTOLWQ/x6Xhn4qpsakojVmIQdJ0bzPtKaG51JDTbVYo
         JsiitqT9C21ky7TuV/MgJOrtpcGu98zjqHbSVlnDbWXtXf2+Nef8NZUEiHzkWsqJ3gXp
         M4uA==
X-Gm-Message-State: AOAM530U3OxL3skM1W3kJKSZRHlW2D+2GYOhdDrDCqbQZ/4/h+50T+Jf
        SyztGUWVrSxjMg9PfNr0BQq6talCpwI=
X-Google-Smtp-Source: ABdhPJx+AO7tg9rvQCEEh6X30C48kHBGko9FXuT45kjlR2XBI8gGwPKmNcfai468+JeVlf8zUtuARg==
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr12871477ejn.56.1599308045268;
        Sat, 05 Sep 2020 05:14:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id k14sm8577412edo.89.2020.09.05.05.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 05:14:04 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] replace_with_{pseudo,value}() can be tail-calls
Date:   Sat,  5 Sep 2020 14:13:58 +0200
Message-Id: <20200905121358.83080-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905121358.83080-1-luc.vanoostenryck@gmail.com>
References: <20200905121358.83080-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This avoids the need to have a separate 'return REPEAT_CSE' and
thus make the code slightly more compact and fast to read.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/simplify.c b/simplify.c
index 3c4b972ce607..76c0558855a2 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1153,8 +1153,7 @@ static int simplify_constant_binop(struct instruction *insn)
 	if (!res)
 		return 0;
 
-	replace_with_pseudo(insn, res);
-	return REPEAT_CSE;
+	return replace_with_pseudo(insn, res);
 }
 
 static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
@@ -1298,8 +1297,7 @@ static int simplify_constant_unop(struct instruction *insn)
 	mask = 1ULL << (insn->size-1);
 	res &= mask | (mask-1);
 	
-	replace_with_value(insn, res);
-	return REPEAT_CSE;
+	return replace_with_value(insn, res);
 }
 
 static int simplify_unop(struct instruction *insn)
@@ -1554,8 +1552,7 @@ static int simplify_select(struct instruction *insn)
 		take = cond->value ? src1 : src2;
 		kill = cond->value ? &insn->src3 : &insn->src2;
 		kill_use(kill);
-		replace_with_pseudo(insn, take);
-		return REPEAT_CSE;
+		return replace_with_pseudo(insn, take);
 	}
 	if (constant(src1) && constant(src2)) {
 		long long val1 = src1->value;
@@ -1577,8 +1574,7 @@ static int simplify_select(struct instruction *insn)
 	if (cond == src2 && is_zero(src1)) {
 		kill_use(&insn->src1);
 		kill_use(&insn->src3);
-		replace_with_value(insn, 0);
-		return REPEAT_CSE;
+		return replace_with_value(insn, 0);
 	}
 	return 0;
 }
-- 
2.28.0

