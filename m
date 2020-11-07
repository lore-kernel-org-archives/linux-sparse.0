Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D33C388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 12:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9EC206D4
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 12:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INsOKJZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKGM6C (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 07:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGM6B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 07:58:01 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4449C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 04:57:59 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o23so5765524ejn.11
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yngtVqYWqXd/8aJRLuDD3SJIcnF/58p4ncV6X/eU6CE=;
        b=INsOKJZfYAHu37lZX7HI+mRgU0H//zqQVgCgsto+LCOS0smULMbYVEUVGCOs/TBUXo
         7dn8FsK70EMPYPDn6PZxPIInfBY+Gd0pq1Fv5It13a1SmFn2p8DSJV4DYB+8E6ZUbEi4
         E6lOhcLHUFy8qph63QGBxw5QIPvwOT/vrkLQeMQ/Vga3elbG3LY7PQ6L+aE/ZcPsbxtp
         91b1c27Yij8OMgyYYTR1m/OP4tYDiztkeEcjVZ5alOeS+8/7c+Bb/nBgiVz3DdVUKAKX
         t9AMWGamiiBiIp+XDkailC2Qgsrtkw7TQp1CnChXk0jeGPohUKwCdPuZgxYaFn37wPdU
         3CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yngtVqYWqXd/8aJRLuDD3SJIcnF/58p4ncV6X/eU6CE=;
        b=juc5Xv3WwEWA/kc1e4wC47U2zQOx7HY1gk3nQNBVm26TfMQ+5GH478AkRjPhyHzkhu
         88TkCiAyhCzS2ItBVQzDiL+UB/1dQ4W10+EM/EKvb1eXTUfRul9p4p09hcNhZbMTXhme
         MTSqLdgcUjsaZz00//YGX0+N+P4BB9mdEJTORnkk4DdzKu+1Oco248ewMPjxw7i+8SD0
         3DYeDi77NfwJW9KgmEJniSO45NHbH8FXJS+b8F5Cp/oGjWXH5KkDvWnfiFNoYjNk63nZ
         G5HVt4m1U7dY1N06a3f5jVYQ0CzvC1tzt7l+Cg5/VBHp6mIKRWYVfEWmhycUYdCjL2Tx
         WbgQ==
X-Gm-Message-State: AOAM530rqET6ousvhr8i/DrBU9en2Pi49e3cEXVkwNj6S9S/wYpf/1g0
        EfE3FHrqw/P/Ec/GQazV/5CYCg+tWSg=
X-Google-Smtp-Source: ABdhPJwkFyejfANAXhgCq2oNdvbFkoSQExOVXcf808K1jilw+XTHwNF9kMMJ4TGvtroXhKljt1y63A==
X-Received: by 2002:a17:906:3795:: with SMTP id n21mr6527265ejc.502.1604753878025;
        Sat, 07 Nov 2020 04:57:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:59a2:5681:b2fc:1a9])
        by smtp.gmail.com with ESMTPSA id rp13sm3239095ejb.79.2020.11.07.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 04:57:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] do not call simplify_instruction() if already removed
Date:   Sat,  7 Nov 2020 13:57:49 +0100
Message-Id: <20201107125749.12618-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

simplify_instruction() is called on every instructions, even
those already removed. It's useless (and annoying when debugging).

So, filter out removed instructions before calling simplify_instruction().

Fixes: c5ba883e6ac47381f8112ed33f22a931a79ac517
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 optimize.c | 2 ++
 simplify.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/optimize.c b/optimize.c
index 31d94e6158ef..bfab74c01b62 100644
--- a/optimize.c
+++ b/optimize.c
@@ -34,6 +34,8 @@ static void clean_up_insns(struct entrypoint *ep)
 	FOR_EACH_PTR(ep->bbs, bb) {
 		struct instruction *insn;
 		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
 			repeat_phase |= simplify_instruction(insn);
 			if (!insn->bb)
 				continue;
diff --git a/simplify.c b/simplify.c
index f2aaa52de84b..ba63f28a3231 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1916,9 +1916,6 @@ int simplify_instruction(struct instruction *insn)
 	unsigned flags;
 	int changed = 0;
 
-	if (!insn->bb)
-		return 0;
-
 	flags = opcode_table[insn->opcode].flags;
 	if (flags & OPF_TARGET) {
 		if (!has_users(insn->target))
-- 
2.29.2

