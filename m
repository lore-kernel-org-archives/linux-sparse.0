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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A715C64E8A
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B858120756
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUzspIty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgK2OuP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 29 Nov 2020 09:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2OuO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Nov 2020 09:50:14 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D832C0617A7
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s13so333680ejr.1
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEVPsw4SBnuuAvXsJvcYWmi9sv5t2fvnMFFCtvDFkw4=;
        b=XUzspItykNgS3nRj6sEMQB6UDtZUPsF1kXK4ppHThWwu+yJ3Hi9Bv/xMdQqKcCh1Kf
         aayumS7lnem/BUWTLC9XGIeFAJjH8alBjHtBbHGmIb6fSrY8Bmf3AXcGl345IayupG8x
         dnJf0gj4WVkwqjYmm9hWn1t2dtmJD7bn1eueL0pph30QvqRjm9ZpMuJH8KjoRb8BohIq
         PX9FIYMMtMwMKKd6ApTiYFaoOwWrFPrON5rDVThKamBcj6UdeLX9Wl6TsIG/0maFjB3Z
         Yvdp7hnXCfEwoflhQpJu+YAj8x/PVBrzX+QPmW/zTsRXChvvY6Mn7lDuwR7/jxarghJD
         Ryfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEVPsw4SBnuuAvXsJvcYWmi9sv5t2fvnMFFCtvDFkw4=;
        b=mYpvnupHyFe8ca/mj1liZ0zCaW6qYJdo2kTQxcBEboOwdILgQ3NodWyxrGvuPmNUKL
         0vcLo2Lhclo7jZo5VGaooqKaVB3lOOeiiTgs2O1kSbYSNIiIO3iXebVv0Nn16gHvchuQ
         SeuFNsTS3+Ywj3ycOFYYkLfF97LVNjPk5ukPIWaqgeNDsVFXVWqHzxp7q7zuptW62b5T
         Jz8Fs955CgfCmeq6TBmHBv5jBeOITqFtx4DNE02aN/+ekOLfPG9yqSO2K7ikrSkFQhxV
         N4I4jZhLrvbjq2IRO0R8ot/8/oGPexgZfOYDfNz4FvZ7nP4pL2k3NK05ugTLIoTApKeq
         jnNg==
X-Gm-Message-State: AOAM530OOLb4qsmtEiLZ4lQ3pZ/KbwAbj8Btna6NBDu5EVSnC31SCDK/
        iWCgU0nQYyrkiW3BSCr8KJpW+AQEk7E=
X-Google-Smtp-Source: ABdhPJyhluD6LhzF+NMk/VsBNFdXHqvO5H8hANXzPvRktsGZxHR5eQjSnQdjbEpYS3UaGCMGBysvjg==
X-Received: by 2002:a17:906:339a:: with SMTP id v26mr15271502eja.107.1606661372077;
        Sun, 29 Nov 2020 06:49:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:149a:de72:e1c0:dd0f])
        by smtp.gmail.com with ESMTPSA id p25sm7435649eju.63.2020.11.29.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 06:49:31 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] memops: move rewrite_load_instruction() here
Date:   Sun, 29 Nov 2020 15:49:21 +0100
Message-Id: <20201129144922.56209-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
References: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The function rewrite_load_instruction() is defined in flow.c but:
* is not directly related to 'flow'
* it's only used in memops.c
* needs some change related to simplify_loads().

So, move this code to memops.c

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c   | 41 -----------------------------------------
 flow.h   |  1 -
 memops.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/flow.c b/flow.c
index 1a871df16bd5..20827acce88b 100644
--- a/flow.c
+++ b/flow.c
@@ -520,47 +520,6 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 	return 1;
 }
 
-/*
- * We should probably sort the phi list just to make it easier to compare
- * later for equality. 
- */
-void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
-{
-	pseudo_t new, phi;
-
-	/*
-	 * Check for somewhat common case of duplicate
-	 * phi nodes.
-	 */
-	new = first_pseudo(dominators)->def->phi_src;
-	FOR_EACH_PTR(dominators, phi) {
-		if (new != phi->def->phi_src)
-			goto complex_phi;
-		new->ident = new->ident ? : phi->ident;
-	} END_FOR_EACH_PTR(phi);
-
-	/*
-	 * All the same pseudo - mark the phi-nodes unused
-	 * and convert the load into a LNOP and replace the
-	 * pseudo.
-	 */
-	convert_load_instruction(insn, new);
-	FOR_EACH_PTR(dominators, phi) {
-		kill_instruction(phi->def);
-	} END_FOR_EACH_PTR(phi);
-	goto end;
-
-complex_phi:
-	/* We leave symbol pseudos with a bogus usage list here */
-	if (insn->src->type != PSEUDO_SYM)
-		kill_use(&insn->src);
-	insn->opcode = OP_PHI;
-	insn->phi_list = dominators;
-
-end:
-	repeat_phase |= REPEAT_CSE;
-}
-
 /* Kill a pseudo that is dead on exit from the bb */
 // The context is:
 // * the variable is not global but may have its address used (local/non-local)
diff --git a/flow.h b/flow.h
index 7cdc7c2a496b..c55362de848e 100644
--- a/flow.h
+++ b/flow.h
@@ -39,7 +39,6 @@ static inline int kill_instruction_force(struct instruction *insn)
 
 void check_access(struct instruction *insn);
 void convert_load_instruction(struct instruction *, pseudo_t);
-void rewrite_load_instruction(struct instruction *, struct pseudo_list *);
 int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local);
 
 extern void vrfy_flow(struct entrypoint *ep);
diff --git a/memops.c b/memops.c
index badcdbbb9378..6620688264ad 100644
--- a/memops.c
+++ b/memops.c
@@ -16,6 +16,47 @@
 #include "linearize.h"
 #include "flow.h"
 
+/*
+ * We should probably sort the phi list just to make it easier to compare
+ * later for equality.
+ */
+static void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
+{
+	pseudo_t new, phi;
+
+	/*
+	 * Check for somewhat common case of duplicate
+	 * phi nodes.
+	 */
+	new = first_pseudo(dominators)->def->phi_src;
+	FOR_EACH_PTR(dominators, phi) {
+		if (new != phi->def->phi_src)
+			goto complex_phi;
+		new->ident = new->ident ? : phi->ident;
+	} END_FOR_EACH_PTR(phi);
+
+	/*
+	 * All the same pseudo - mark the phi-nodes unused
+	 * and convert the load into a LNOP and replace the
+	 * pseudo.
+	 */
+	convert_load_instruction(insn, new);
+	FOR_EACH_PTR(dominators, phi) {
+		kill_instruction(phi->def);
+	} END_FOR_EACH_PTR(phi);
+	goto end;
+
+complex_phi:
+	/* We leave symbol pseudos with a bogus usage list here */
+	if (insn->src->type != PSEUDO_SYM)
+		kill_use(&insn->src);
+	insn->opcode = OP_PHI;
+	insn->phi_list = dominators;
+
+end:
+	repeat_phase |= REPEAT_CSE;
+}
+
 static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
 	int local)
-- 
2.29.2

