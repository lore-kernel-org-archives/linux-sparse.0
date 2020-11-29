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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81661C3E8C5
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FA020756
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7Qo4do0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgK2Ouu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 29 Nov 2020 09:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgK2Out (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Nov 2020 09:50:49 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902CC061A04
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:34 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id c7so3930245edv.6
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JprRWokgKtSqghCRmRoVkQ6Lw9MTLOQDlBrl1DACqI0=;
        b=p7Qo4do0Rx/O56SKq2YIhbfZZQ/keGanKd/KRMT8jQEGOEjGdl+/gbxjOkSlvPeqMx
         /Qo7QkwmKkcto0SUtTrzF80yjJIpbgQfQHpczv9nvaR6I/ZTKqTmnSGCUdJoPq46NKSY
         TUvDMh3QtjCWtVL6H2/SzB4GoUr41Hb8x08MY0t1Az3MNZhlj6tu/7dflPyAYnXJxFmm
         Zl4S9N8MfdF2YY6N96VU26Wq/yJQXPDdIdK3gfXbhZ/Sj9ijuhKs/pU5H9bkof3DdbRO
         jWG+INUdatwcTpxDFFOJRJBK2AxLvqIjx5cWIEAlfXiOjcNWHCUoKOmEvC0a/GCfAcjf
         Q0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JprRWokgKtSqghCRmRoVkQ6Lw9MTLOQDlBrl1DACqI0=;
        b=JOiYJ7NXM/vap36Fo1gYANmJwDwLkduwZ3rsiW8hjbUTTOcQjbjhmUeNpwxVdrNHkK
         59Dun+kFvj+zQunZKVkQU6rtwB9W3W4pzoIPMZ8qmXqh5uK2fD1pxCbFKtonixkmU+PH
         20VqpRrA2zX0+BWRwt5huh54dRjjE2mEfGFAnJN/6HsclRGjJ1OgdlasNC4Lm87LpEyb
         pAzTWrk1Ad0gOfiusp5RgOdIppRY8nCbf/SEtQ0dS/W9UKSLLcQ4DtR7eFAbhYu1Tkca
         rmQ3VHo087kJy0x0TAgGtvNYWo93xs2p3q0QaE7du8+Ms4UdpolftD3H8efvbCXSup5L
         vFZA==
X-Gm-Message-State: AOAM530sZrQ9l+arvYKI2pdioYenQbY3D3dTjg93frU3JGFKN0tHVplI
        Cc2A62WeORebJ3Yr4lWrYJ/mGoYLK40=
X-Google-Smtp-Source: ABdhPJw8BM+4PlaJNdlVDjdj0WdpSoCZPoPC+MrxpL4DKiihGc7Y/wmKVnQWayyRhe0JsutxEC9URw==
X-Received: by 2002:a50:9ee6:: with SMTP id a93mr12062426edf.174.1606661372875;
        Sun, 29 Nov 2020 06:49:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:149a:de72:e1c0:dd0f])
        by smtp.gmail.com with ESMTPSA id p25sm7435649eju.63.2020.11.29.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 06:49:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] replace convert_load_instruction() by replace_with_pseudo()
Date:   Sun, 29 Nov 2020 15:49:22 +0100
Message-Id: <20201129144922.56209-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
References: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These two functions are now exactly the same, so replace the
first one by the second one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c   | 7 +------
 flow.h   | 1 -
 memops.c | 7 ++++---
 ssa.c    | 9 +++++----
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/flow.c b/flow.c
index 20827acce88b..95e44ac104f6 100644
--- a/flow.c
+++ b/flow.c
@@ -16,6 +16,7 @@
 #include "parse.h"
 #include "expression.h"
 #include "linearize.h"
+#include "simplify.h"
 #include "flow.h"
 #include "target.h"
 #include "flowgraph.h"
@@ -453,12 +454,6 @@ void convert_instruction_target(struct instruction *insn, pseudo_t src)
 	target->users = NULL;
 }
 
-void convert_load_instruction(struct instruction *insn, pseudo_t src)
-{
-	convert_instruction_target(insn, src);
-	kill_instruction(insn);
-}
-
 static int overlapping_memop(struct instruction *a, struct instruction *b)
 {
 	unsigned int a_start = bytes_to_bits(a->offset);
diff --git a/flow.h b/flow.h
index c55362de848e..46d76a780484 100644
--- a/flow.h
+++ b/flow.h
@@ -38,7 +38,6 @@ static inline int kill_instruction_force(struct instruction *insn)
 }
 
 void check_access(struct instruction *insn);
-void convert_load_instruction(struct instruction *, pseudo_t);
 int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local);
 
 extern void vrfy_flow(struct entrypoint *ep);
diff --git a/memops.c b/memops.c
index 6620688264ad..7efade22c9b5 100644
--- a/memops.c
+++ b/memops.c
@@ -14,6 +14,7 @@
 #include "parse.h"
 #include "expression.h"
 #include "linearize.h"
+#include "simplify.h"
 #include "flow.h"
 
 /*
@@ -40,7 +41,7 @@ static void rewrite_load_instruction(struct instruction *insn, struct pseudo_lis
 	 * and convert the load into a LNOP and replace the
 	 * pseudo.
 	 */
-	convert_load_instruction(insn, new);
+	replace_with_pseudo(insn, new);
 	FOR_EACH_PTR(dominators, phi) {
 		kill_instruction(phi->def);
 	} END_FOR_EACH_PTR(phi);
@@ -167,7 +168,7 @@ static void simplify_loads(struct basic_block *bb)
 					if (!compatible_loads(insn, dom))
 						goto next_load;
 					/* Yeehaa! Found one! */
-					convert_load_instruction(insn, dom->target);
+					replace_with_pseudo(insn, dom->target);
 					goto next_load;
 				}
 			} END_FOR_EACH_PTR_REVERSE(dom);
@@ -181,7 +182,7 @@ static void simplify_loads(struct basic_block *bb)
 				if (!dominators) {
 					if (local) {
 						assert(pseudo->type != PSEUDO_ARG);
-						convert_load_instruction(insn, value_pseudo(0));
+						replace_with_pseudo(insn, value_pseudo(0));
 					}
 					goto next_load;
 				}
diff --git a/ssa.c b/ssa.c
index 3e8800507f63..a2e27030e4b6 100644
--- a/ssa.c
+++ b/ssa.c
@@ -11,7 +11,8 @@
 #include "dominate.h"
 #include "flowgraph.h"
 #include "linearize.h"
-#include "flow.h"			// for convert_load_instruction()
+#include "simplify.h"
+#include "flow.h"
 
 
 // Is it possible and desirable for this to be promoted to a pseudo?
@@ -109,7 +110,7 @@ static void rewrite_local_var(struct basic_block *bb, pseudo_t addr, int nbr_sto
 		case OP_LOAD:
 			if (!val)
 				val = undef_pseudo();
-			convert_load_instruction(insn, val);
+			replace_with_pseudo(insn, val);
 			break;
 		case OP_STORE:
 			val = insn->target;
@@ -150,7 +151,7 @@ static bool rewrite_single_store(struct instruction *store)
 
 		// undefs ?
 
-		convert_load_instruction(insn, store->target);
+		replace_with_pseudo(insn, store->target);
 	} END_FOR_EACH_PTR(pu);
 
 	// is there some unconverted loads?
@@ -292,7 +293,7 @@ static void ssa_rename_insn(struct basic_block *bb, struct instruction *insn)
 		if (!var || !var->torename)
 			break;
 		val = lookup_var(bb, var);
-		convert_load_instruction(insn, val);
+		replace_with_pseudo(insn, val);
 		break;
 	case OP_PHI:
 		var = insn->type;
-- 
2.29.2

