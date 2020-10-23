Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31D8C55179
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C15206B5
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGrMbPe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbgJWQjs (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbgJWQjr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F0C0613D2
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so3221643ejy.11
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69m0Al0elMAaaFGsiqal6TSPdRS4e5BbBaaMNsRTlyo=;
        b=VGrMbPe9ra4IGL+CfUJdwaTzLiL/dYZlmFQMUy1+NYNDLrkp6IE1rP2jKdbM3jhJyk
         ixXVHrRxNtCx3YG09fm+C/soymVYnurM7pCeZhAICTETKMhYF3fL9k615mbici+oQBP6
         XfPs84STKMSkMBXCrpvFSFs3SbusW0jjW9BDp5AyJi1Bo3Hz6i1ZMxwBF8JIf7x+D2ay
         Or6SgjHDIbSBgdRDagfpZlArF1gDzgPfhc9DDyqJCWjPGBfS9GHmCkwDwAH9nMf/bmBi
         IL8EGgwXvIIZuKBA2F/3Ca0JXaMYQWfkaAoAOqX0U/0AC1BeTaWNGSQuc/EN41Q8/L4v
         pHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69m0Al0elMAaaFGsiqal6TSPdRS4e5BbBaaMNsRTlyo=;
        b=fpHn5ZbNolfDS2//JI+USz78D6AAXraC9d1rfR1Gulu4PH4iWnC49WQrRvPH34p18M
         li/AQI42paeEHcPq0P5OAGlFBza+gEpjKmJv6aN6zY2fmQQGfmNd24RGT2Is2/vyT9Lg
         BuJ6QqL/Lkn/RIcuX4lihXnyXbcddRmI33+E6BYwxW7c5VBwQ+M+XmhJGhkqHS5DpiDh
         hyaMERemic0f/0dvITfnpyEQiNXygC3Dq8G7/HnM87TNaNRnYNtwG3Su9nHVcZcVWOnD
         RayyR3oR4EgKEbjAhFb4zIKPnkiHGoYXyrUKbRl8BDKv4T/coH49/FbhGivFJQih7aJ7
         uJ2w==
X-Gm-Message-State: AOAM530rwVdai2fzkFVy8DgUgXAIx1PI6lVuFIDXxkeu6ce9Yufq3+yI
        mspJNIo7ImY19bMnnKEuEps7WFTR4rA=
X-Google-Smtp-Source: ABdhPJzHIxr6jMShdD31AXjUpWN5KAiyrS9y59TQ8UHhgwtLHovocY/qMDx1LX5nhDLOxyTkm/h1YQ==
X-Received: by 2002:a17:906:bc98:: with SMTP id lv24mr2811769ejb.536.1603471186209;
        Fri, 23 Oct 2020 09:39:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] unop: simplify -(x - y) --> y - x
Date:   Fri, 23 Oct 2020 18:39:34 +0200
Message-Id: <20201023163939.58359-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
References: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 4 ++++
 validation/optim/simplify-neg-sub.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 85c8d1d1df1c..fd486172e6e8 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1478,6 +1478,10 @@ static int simplify_unop(struct instruction *insn)
 			return replace_pseudo(insn, &insn->src1, src);
 		case OP_NEG:		// -(-x) --> x
 			return replace_with_pseudo(insn, def->src);
+		case OP_SUB:		// -(x - y) --> y - x
+			insn->opcode = OP_SUB;
+			use_pseudo(insn, def->src1, &insn->src2);
+			return replace_pseudo(insn, &insn->src1, def->src2);
 		}
 		break;
 	default:
diff --git a/validation/optim/simplify-neg-sub.c b/validation/optim/simplify-neg-sub.c
index b73c9e5e66b4..9a824f09c1db 100644
--- a/validation/optim/simplify-neg-sub.c
+++ b/validation/optim/simplify-neg-sub.c
@@ -3,7 +3,6 @@ int foo(int x, int y) { return -(x - y) == (y - x); }
 /*
  * check-name: simplify-neg-sub
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.28.0

