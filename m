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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE2FC3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE51C22228
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg3U1hd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgK0Wcw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbgK0W10 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:26 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A77C0613D4
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:26 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so7727350wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdFsuFEoV7kfT1dhDUS8+TraI8Fo/krZo/2ACS2fyhc=;
        b=Dg3U1hd7czbmNJT2U2KivQyl4WxrZPENotn+Qnel8iunEHlBonkTBUUGpTYoVNbUqJ
         5DI4myvATwPPhDrvO2hyyauWncZ0aNafMzbQa9BzQnsGV2Cu+QCgFPvucogu6dtOemmp
         viRv4loT0SyI0cZBdviluJWgl47j9DA/ENJUt+Bcfo8N/p0aVedJY+eXf7D26qT+jxGD
         nuwedCpzN72K9hT19AlqMvQxrClBlvboIHt7qHKpujnlIzTY+ao8WR7/0ZJ7aI6odFfw
         p5i5eFPenHFKZJK4xiLkRQDEYhj5n+/7u3i2K6rkz/+R0TZ0yVdHLJJZZ1W1zU39MHwj
         NJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdFsuFEoV7kfT1dhDUS8+TraI8Fo/krZo/2ACS2fyhc=;
        b=e/Kom/+UUz+LEq9hDjNdfX3bi6DbWkCqKEKusjGaxvt5fJDq2V5R+zQHWWOz7/+vZt
         KPzQ4TX7VrbjukhOdtK0aN2a6KE+T4r1Vs4E+CB7x7Pxhyp3m3GHc3SLmIt3awxE0JWa
         aIMKPXvyy4EIZS0uJ+B3Xhp+4AMqJNfbe8hv/JNHYfpNfwJTkprk8tBpFdN6dP6ly/1d
         B5YKHEZ3y3aPh2la6nWJ+xjEJfwokFEJvqY5cPSwi6MYUSNfFphWXeoMydUp3krTbMVu
         TAQ5K2QhUH5SwrAPziGSpEGqrFJYEh7tCsG91prOah2Ta9JpRJYQJcmoUboLZ31ea912
         92yg==
X-Gm-Message-State: AOAM532Wi61MBluszPS/jdjRnxfco3ciuzlzjCuiG6jdGwoaX3K9P3xc
        1NbeB8JO1xg0bCB0F5Yci3KZQ59RBAM=
X-Google-Smtp-Source: ABdhPJyL2bQUFDRvwrPAq7WE/yW8c1ghv6K6NDTpgTU5T28v8f3byrX/S3oicMJ/q4NYfBfC1wnyZQ==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr11988422wma.48.1606516044812;
        Fri, 27 Nov 2020 14:27:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:24 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] factorize SEL(x, OP(y,z), y) into OP(SEL(x, z, 0), y)
Date:   Fri, 27 Nov 2020 23:25:11 +0100
Message-Id: <20201127222516.44915-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

'Factorize' and expression like:
	x ? (y | z) : y;
into
	(x ? z : 0) | y;

and some positional variants as well as replacing '|' by '+' or '^'.

Note: it's not very clear if this is really an improvement but it
      allows some very nice simplification of 'bits translations'.
Note: the same can be done for others operations, for example it can
      be done for '&' if '0' (the neuter value for '|', '+' and '^')
      by '~0' (same with '*' and '1').

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 40 ++++++++++++++++++++++++++++++++
 validation/optim/fact-select01.c |  1 -
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 89a064b93e85..d729b390ae76 100644
--- a/simplify.c
+++ b/simplify.c
@@ -554,6 +554,16 @@ static inline int swap_insn(struct instruction *out, struct instruction *in, pse
 	return replace_insn_pair(out, in->opcode, in, out->opcode, a, b, c);
 }
 
+///
+// create an instruction pair OUT(SELECT(a, b, c), d)
+static int swap_select(struct instruction *out, struct instruction *in, pseudo_t a, pseudo_t b, pseudo_t c, pseudo_t d)
+{
+	use_pseudo(in, c, &in->src3);
+	swap_insn(out, in, a, b, d);
+	kill_use(&out->src3);
+	return REPEAT_CSE;
+}
+
 static inline int def_opcode(pseudo_t p)
 {
 	if (p->type != PSEUDO_REG)
@@ -2254,6 +2264,36 @@ static int simplify_select(struct instruction *insn)
 		}
 		break;
 	}
+
+	switch (DEF_OPCODE(def, src1)) {
+	case OP_ADD: case OP_OR: case OP_XOR:
+		if ((def->src1 == src2) && can_move_to(cond, def)) {
+			// SEL(x, OP(y,z), y) --> OP(SEL(x, z, 0), y)
+			swap_select(insn, def, cond, def->src2, value_pseudo(0), src2);
+			return REPEAT_CSE;
+		}
+		if ((def->src2 == src2) && can_move_to(cond, def)) {
+			// SEL(x, OP(z,y), y) --> OP(SEL(x, z, 0), y)
+			swap_select(insn, def, cond, def->src1, value_pseudo(0), src2);
+			return REPEAT_CSE;
+		}
+		break;
+	}
+
+	switch (DEF_OPCODE(def, src2)) {
+	case OP_ADD: case OP_OR: case OP_XOR:
+		if ((def->src1 == src1) && can_move_to(cond, def)) {
+			// SEL(x, y, OP(y,z)) --> OP(SEL(x, 0, z), y)
+			swap_select(insn, def, cond, value_pseudo(0), def->src2, src1);
+			return REPEAT_CSE;
+		}
+		if ((def->src2 == src1) && can_move_to(cond, def)) {
+			// SEL(x, y, OP(z,y)) --> OP(SEL(x, 0, z), y)
+			swap_select(insn, def, cond, value_pseudo(0), def->src1, src1);
+			return REPEAT_CSE;
+		}
+		break;
+	}
 	return 0;
 }
 
diff --git a/validation/optim/fact-select01.c b/validation/optim/fact-select01.c
index ef4e5e89a7be..9232fc908e34 100644
--- a/validation/optim/fact-select01.c
+++ b/validation/optim/fact-select01.c
@@ -19,7 +19,6 @@ int xor_y_yx(int p, int x, int y) { return (p ? y : (y^x)) == ((p ? 0 : x) ^ y);
 /*
  * check-name: fact-select01
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

