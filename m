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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B2C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE53D207CF
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 10:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgL0KJR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 27 Dec 2020 05:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgL0KJQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Dec 2020 05:09:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45BC061794
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 02:08:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v14so7019318wml.1
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Kpux7LtnXjnElmtFZEqedHd9obm5A6EC/pj8BsOyn0=;
        b=AA2vIGTEvqy6rlRZ6bsOac1GdO8qImCGEpUifO5JC0490iVohFadquZPqhafsr+T3j
         Fbkv3zr4kIck7gFPZrYRh0rbLHKDdDMlS/FaNRp2hIKKvepS3HAFS1H2qaYoqZhaucvc
         VGn+S30k2xU6VNRxwnyD1vS1Plx5VzvAqRDN2VJ5Ry7sTe+bP7c8GbfHe31VfpNyHpI+
         Kcmr0KdZZ5u+5nD47JwOrDkJnlU7LxCkXJjtCzzjA6VrDbKauzY9GatTJeA5w/NRuLRA
         f6ogd2aKEgLze53ADuKHXdQ05cOsVp9ny0GEVFdiZkUNWeQbFdSMugU9t/J01Dgp417X
         SfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Kpux7LtnXjnElmtFZEqedHd9obm5A6EC/pj8BsOyn0=;
        b=kQmnlR2k1GqBz30YNimANIiI7USXxXg9fseE3rJkFbgRVpEraOoWwb80ZrxTCcIPgW
         xUezH/cZjaHY1ugKLtZ1icf2tW3v1FqTsD8q19lPnurYG1SK2ZyibXrWZeOUkUV7Z/tX
         pkTqLL0ocFa/7pjL+xDnVPwo6uSkhj6vjaHKXwIl+7z4yk3Y4x/dN/fk8eYVnhXBKdwV
         kqSAPp+8OSz+AOWtrxM03p14IZI5Ur02gPWg18xkAgvnGq9By0mActt3yJXASBtvC2Hw
         CW6p0kzgNIdHuWk0XOJB/mek8GSHhJY+FliQc6UqFFYKfxo4hhIm6mJv4fROb8f3spNf
         nHrg==
X-Gm-Message-State: AOAM532K21El/FdgIaxpgfqryQwslUUQMW2WK6LF2QZoiLlquRrHfYws
        LkmVeIVr8nTBOEyPyZV58kUH5jtztWA=
X-Google-Smtp-Source: ABdhPJxaD9QdSHkv91VVyyiCstRRBX6kUOzj+d/4vU4VfT8No/5oXhglC05ZWpHk0l7N/70Tz5Ic/w==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr15868367wmc.33.1609063713594;
        Sun, 27 Dec 2020 02:08:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c99c:3949:2fe7:7420])
        by smtp.gmail.com with ESMTPSA id u3sm58128494wre.54.2020.12.27.02.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 02:08:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] shrink struct BB
Date:   Sun, 27 Dec 2020 11:08:29 +0100
Message-Id: <20201227100829.33456-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reorganize the members of struct BB, avoiding padding and making better
use of the union, to shrink its size from 104 to 96 bytes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 12 +++++-------
 ssa.c       |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/linearize.h b/linearize.h
index 2c548d43526f..7093a815312a 100644
--- a/linearize.h
+++ b/linearize.h
@@ -160,21 +160,19 @@ struct instruction_list;
 struct basic_block {
 	struct position pos;
 	unsigned long generation;
-	union {
-		int context;
-		int postorder_nr;	/* postorder number */
-		int dom_level;		/* level in the dominance tree */
-	};
 	struct entrypoint *ep;
 	struct basic_block_list *parents; /* sources */
 	struct basic_block_list *children; /* destinations */
 	struct instruction_list *insns;	/* Linear list of instructions */
 	struct basic_block *idom;	/* link to the immediate dominator */
+	unsigned int nr;		/* unique id for label's names */
+	int dom_level;			/* level in the dominance tree */
 	struct basic_block_list *doms;	/* list of BB idominated by this one */
-	struct phi_map *phi_map;
 	struct pseudo_list *needs, *defines;
 	union {
-		unsigned int nr;	/* unique id for label's names */
+		struct phi_map *phi_map;/* needed during SSA conversion */
+		int postorder_nr;	/* postorder number */
+		int context;		/* needed during context checking */
 		void *priv;
 	};
 };
diff --git a/ssa.c b/ssa.c
index a2e27030e4b6..4c86c55c2ec1 100644
--- a/ssa.c
+++ b/ssa.c
@@ -387,6 +387,7 @@ void ssa_convert(struct entrypoint *ep)
 		int nr = bb->nr;
 		if (nr > last)
 			last = nr;
+		bb->phi_map = NULL;
 	} END_FOR_EACH_PTR(bb);
 
 	processed = sset_init(first, last);
-- 
2.29.2

