Return-Path: <SRS0=Ka3J=D5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A11C388F9
	for <linux-sparse@archiver.kernel.org>; Thu, 22 Oct 2020 22:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209FC2245F
	for <linux-sparse@archiver.kernel.org>; Thu, 22 Oct 2020 22:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdniNiwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373135AbgJVWzg (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 22 Oct 2020 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373134AbgJVWzg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 22 Oct 2020 18:55:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B9EC0613CE
        for <linux-sparse@vger.kernel.org>; Thu, 22 Oct 2020 15:55:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lw21so4750419ejb.6
        for <linux-sparse@vger.kernel.org>; Thu, 22 Oct 2020 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40LbRFKnPqtRIsdYUQ3biyKhn46IeafoSCY5DGQgQZs=;
        b=PdniNiwRJ6ZfXSHRoVSKO+TB2irJzdqjFDIfVjYN9X0aJWiAriy9IM0TgUqoDLkxOa
         D5crACsHEfQbFfsdQfuI9KMHzqjebVmHxbadN7YTBdrjytE/lwB2YkWeXYdyDSnus2Ji
         hdMcmOWUMi4xdsT/eP9ZCMytdYt1dB3w2p2NPz/ozGznWgC2AYPHgB5XxGvkvl1QKJF7
         r/2ltqz/DfA3xreT3VDPojsvm8Rfe2jTJi+aMiZPc8nGkEtyLOrcIg1SA+JqhDHGiJgX
         LfEVv42sztc1VDtdgLjl6GMikbJGB1AC03yUKpcMp10WABdu5fmE7M9DUQaWIq5I4Kze
         OK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40LbRFKnPqtRIsdYUQ3biyKhn46IeafoSCY5DGQgQZs=;
        b=efTGzA9D4TGfaNPfuMUbyxtpRI9bRz6gZFgO/2pZoFAQx5yePm0+90cMMKPWnyaK0R
         /GzyMYkJktT8lndmCLT4bn0tkbmtTMOPWkcBjIuu8XlMtGZnUojCAUhDZ/bHPJxSYh9M
         SXQn3VGn9sGUBvrhSzTEWVRvzNL8ELMGyG3ZaPBgwdznuwsDuqXaEv2cyrNvKCxOkS18
         kP3zl8Xvi4d+SBGi183rebj4U0aodeZSmrUZs1cVZQbG4SYb0KXYN941E+pHpttUOFKI
         k8kZgyDZrgWQXtfcrR8bfg5sz4dCyXRyK1DCdUAhJP4b4Dko8z3P3Iu9aZ6RHZFNhANf
         KOHQ==
X-Gm-Message-State: AOAM532jDDQvruaL6SKFRKfVjMnM4ARVXqzkjArL/f1pUqdpY9HcoQk+
        KqQrYN4Dkkgk3SLP2Jgxk8SaeVLHUY0=
X-Google-Smtp-Source: ABdhPJxr1k2yCI2LLCAzSIh87nePX+vftQsQHJpSz/LYeTUJMa1XBNefEuiWObvW/+CChHI9Q0I7wQ==
X-Received: by 2002:a17:906:e55:: with SMTP id q21mr4401521eji.338.1603407332480;
        Thu, 22 Oct 2020 15:55:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c06e:233e:fc9f:6083])
        by smtp.gmail.com with ESMTPSA id r24sm1297482eds.67.2020.10.22.15.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 15:55:31 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: fix crash with llvm-11 / use real phi-nodes
Date:   Fri, 23 Oct 2020 00:53:13 +0200
Message-Id: <20201022225313.33229-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

sparse-llvm crashes with LLVM-11. From what I can see, it's because
LLVM-11 doesn't like anymore that an instruction is first created
unattached to a basic block (LLVMClearInsertionPosition()) and
inserted at some later step (LLVMInsertIntoBuilder()). Since the
corresponding function still exist I suppose they're working correctly
and sparse-llvm somehow misuse them. I don't know.

However, this functionality is only used to create the alloca
instructions used to simulate the phi-nodes.

So, fix this crash by using real phi instructions for the phi-nodes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 75 ++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 46 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c7a9fbb7eee1..c984dc877a61 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -826,37 +826,14 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 
 static void output_op_phisrc(struct function *fn, struct instruction *insn)
 {
-	LLVMValueRef v;
-	struct instruction *phi;
-
-	assert(insn->target->priv == NULL);
-
-	/* target = src */
-	v = get_operand(fn, insn->type, insn->phi_src);
-
-	FOR_EACH_PTR(insn->phi_users, phi) {
-		LLVMValueRef load, ptr;
-
-		assert(phi->opcode == OP_PHI);
-		/* phi must be load from alloca */
-		load = phi->target->priv;
-		assert(LLVMGetInstructionOpcode(load) == LLVMLoad);
-		ptr = LLVMGetOperand(load, 0);
-		/* store v to alloca */
-		LLVMBuildStore(fn->builder, v, ptr);
-	} END_FOR_EACH_PTR(phi);
+	insn->src->priv = get_operand(fn, insn->type, insn->src);
 }
 
 static void output_op_phi(struct function *fn, struct instruction *insn)
 {
-	LLVMValueRef load = insn->target->priv;
-
-	/* forward load */
-	assert(LLVMGetInstructionOpcode(load) == LLVMLoad);
-	/* forward load has no parent block */
-	assert(!LLVMGetInstructionParent(load));
-	/* finalize load in current block  */
-	LLVMInsertIntoBuilder(fn->builder, load);
+	LLVMTypeRef dst_type = insn_symbol_type(insn);
+
+	insn->target->priv = LLVMBuildPhi(fn->builder, dst_type, "");
 }
 
 static void output_op_ptrcast(struct function *fn, struct instruction *insn)
@@ -1161,30 +1138,11 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 		static int nr_bb;
 		LLVMBasicBlockRef bbr;
 		char bbname[32];
-		struct instruction *insn;
 
 		sprintf(bbname, "L%d", nr_bb++);
 		bbr = LLVMAppendBasicBlock(function.fn, bbname);
 
 		bb->priv = bbr;
-
-		/* allocate alloca for each phi */
-		FOR_EACH_PTR(bb->insns, insn) {
-			LLVMBasicBlockRef entrybbr;
-			LLVMTypeRef phi_type;
-			LLVMValueRef ptr;
-
-			if (!insn->bb || insn->opcode != OP_PHI)
-				continue;
-			/* insert alloca into entry block */
-			entrybbr = LLVMGetEntryBasicBlock(function.fn);
-			LLVMPositionBuilderAtEnd(function.builder, entrybbr);
-			phi_type = insn_symbol_type(insn);
-			ptr = LLVMBuildAlloca(function.builder, phi_type, "");
-			/* emit forward load for phi */
-			LLVMClearInsertionPosition(function.builder);
-			insn->target->priv = LLVMBuildLoad(function.builder, ptr, "phi");
-		} END_FOR_EACH_PTR(insn);
 	}
 	END_FOR_EACH_PTR(bb);
 
@@ -1194,6 +1152,31 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 		output_bb(&function, bb);
 	}
 	END_FOR_EACH_PTR(bb);
+
+	FOR_EACH_PTR(ep->bbs, bb) {	// complete the OP_PHIs
+		struct instruction *insn;
+
+		FOR_EACH_PTR(bb->insns, insn) {
+			pseudo_t phi;
+
+			if (!insn->bb || insn->opcode != OP_PHI)
+				continue;
+
+			FOR_EACH_PTR(insn->phi_list, phi) {
+				struct instruction *phisrc;
+				LLVMBasicBlockRef bref;
+				LLVMValueRef vref;
+
+				if (phi == VOID)
+					continue;
+
+				phisrc = phi->def;
+				bref = phisrc->bb->priv;
+				vref = phisrc->src->priv;
+				LLVMAddIncoming(insn->target->priv, &vref, &bref, 1);
+			} END_FOR_EACH_PTR(phi);
+		} END_FOR_EACH_PTR(insn);
+	} END_FOR_EACH_PTR(bb);
 }
 
 static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)

base-commit: 2d3af347e4a217f95b4f939fed9e76541d8b72f2
-- 
2.28.0

