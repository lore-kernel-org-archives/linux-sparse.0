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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80EC6379D
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FDD20727
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsGseyQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKUUxT (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUxT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 15:53:19 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A36C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:17 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so13652607wmh.4
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OoHEIvq++HatUS799FbIS8kFE9qdJKTvlS1kpCyc0M=;
        b=DsGseyQ6bb1IYtx81Vt9Z0y1LEwYZ4VqycYNd37d8YG1XHGr7Xmod0shS0bKZQ2U5Z
         Eg6DeFsVZPZEnxg/t1doWhTp5HZXS+7Ju8vcecHF2LeCyI891/vZWHeZ3dC2xBP9Bshs
         NnL0/VSKCrWCNyCm0YoVqk80+KkodWJNFsciCSV7n/TeOLWHXawrS/553WbK8CjJaZ/d
         ckqfgGITe/lkL279V84eU0Lhdzz/iOt+/fi1Fr2cewHuOo7jvVik9BE1voTamxIDL7VY
         QQe2yzcjVP3o4B8luQG4sNb1cONSsXO8eLlwSQO20XREXLJJvaVmuWVA4bQGvXeanxjL
         ++gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OoHEIvq++HatUS799FbIS8kFE9qdJKTvlS1kpCyc0M=;
        b=UXM0bcSV/HuqKgOoVIYhfRSOj3bUjAlqny8ZvV7eHi3FF3CJ1bxSC1T2GMqV5H+BUe
         BHLXtMGVe3pI3JKu2gtNyAoOqmPDjYFC495PKul7bQGPV2RbiIT0blYPbnC+KNh+e8nF
         T3x+WYpjMpnR3NSzbrGYivhdxSDwOCMQo6JHIUjuH1/aA5YA4x0/LkQ71VpTYXufcQVK
         KNibt7E4AKR0hhr2yeMOY0451eo4OnFBdNwmBAzQHGQLptgUMge8EQZ3PjojwC8bfxPM
         F+DrLcH+2GYXeAco9HfRtqG2ovE69f1jrvY5f8jt8GPrrpZSYR8vM3uxwkka2qlBUm2b
         Ti6w==
X-Gm-Message-State: AOAM530vnwHnO4jMPJTxkMWGm1dSXbJs4XeVR89uNGBmqhrarvHlcX+o
        cWxFbW319B8IGWjcy9rDYAPrulGWINU=
X-Google-Smtp-Source: ABdhPJwfuHB3fSndgbYD0jAWPrrcoN2jwg6KTrN+0Jhn3Ud7bHpfg1YsbtfH9wSgowRnPyo2y7R+Vw==
X-Received: by 2002:a05:600c:22d5:: with SMTP id 21mr14797380wmg.33.1605991996132;
        Sat, 21 Nov 2020 12:53:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id p4sm9369815wmc.46.2020.11.21.12.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:53:15 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] add a new instruction for label-as-value
Date:   Sat, 21 Nov 2020 21:53:00 +0100
Message-Id: <20201121205300.94642-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
References: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Convert OP_SETVAL of a label into a new instruction: OP_LABEL.
There is 2 reasons to do this:
*) there is slightly less checking to be done in later phases
   (since OP_SETVAL can be for labels but also strings)
*) OP_SETVAL is CSEd but this is largely useless because this
   instruction is hashed on the expression's address and these
   are (most) often not shared. With a separate instruction
   for label expressions, their CSE is now OK because the hashing
   is done on the BB.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c                        |  9 +++++++++
 example.c                    |  8 +++++---
 linearize.c                  |  6 ++++++
 liveness.c                   |  1 +
 opcode.def                   |  1 +
 simplify.c                   | 36 ++++++++++++++++++++++++------------
 sparse-llvm.c                | 11 +++++++++++
 validation/optim/cse-label.c |  1 -
 8 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/cse.c b/cse.c
index 22dfd4ba5d19..1e58a973ecf6 100644
--- a/cse.c
+++ b/cse.c
@@ -80,6 +80,10 @@ void cse_collect(struct instruction *insn)
 		hash += hashval(insn->src1);
 		break;
 
+	case OP_LABEL:
+		hash += hashval(insn->bb_true);
+		break;
+
 	case OP_SETVAL:
 		hash += hashval(insn->val);
 		break;
@@ -215,6 +219,11 @@ static int insn_compare(const void *_i1, const void *_i2)
 			return i1->src1 < i2->src1 ? -1 : 1;
 		break;
 
+	case OP_LABEL:
+		if (i1->bb_true != i2->bb_true)
+			return i1->bb_true < i2->bb_true ? -1 : 1;
+		break;
+
 	case OP_SETVAL:
 		if (i1->val != i2->val)
 			return i1->val < i2->val ? -1 : 1;
diff --git a/example.c b/example.c
index 8a2b1ab46fe8..0c2ddf50c015 100644
--- a/example.c
+++ b/example.c
@@ -66,6 +66,7 @@ static const char *opcodes[] = {
 	/* Memory */
 	[OP_LOAD] = "load",
 	[OP_STORE] = "store",
+	[OP_LABEL] = "label",
 	[OP_SETVAL] = "set",
 
 	/* Other */
@@ -619,7 +620,7 @@ static struct hardreg *fill_reg(struct bb_state *state, struct hardreg *hardreg,
 	case PSEUDO_ARG:
 	case PSEUDO_REG:
 		def = pseudo->def;
-		if (def && def->opcode == OP_SETVAL) {
+		if (def && (def->opcode == OP_SETVAL || def->opcode == OP_LABEL)) {
 			output_insn(state, "movl $<%s>,%s", show_pseudo(def->target), hardreg->name);
 			break;
 		}
@@ -1375,10 +1376,11 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 	}
 
 	/*
-	 * OP_SETVAL likewise doesn't actually generate any
+	 * OP_LABEL & OP_SETVAL likewise doesn't actually generate any
 	 * code. On use, the "def" of the pseudo will be
 	 * looked up.
 	 */
+	case OP_LABEL:
 	case OP_SETVAL:
 		break;
 
@@ -1531,7 +1533,7 @@ static void fill_output(struct bb_state *state, pseudo_t pseudo, struct storage
 		return;
 	case PSEUDO_REG:
 		def = pseudo->def;
-		if (def && def->opcode == OP_SETVAL) {
+		if (def && (def->opcode == OP_SETVAL || def->opcode == OP_LABEL)) {
 			write_val_to_storage(state, pseudo, out);
 			return;
 		}
diff --git a/linearize.c b/linearize.c
index ab91113d00eb..4391f09cb0da 100644
--- a/linearize.c
+++ b/linearize.c
@@ -249,6 +249,7 @@ static const char *opcodes[] = {
 	/* Memory */
 	[OP_LOAD] = "load",
 	[OP_STORE] = "store",
+	[OP_LABEL] = "label",
 	[OP_SETVAL] = "set",
 	[OP_SETFVAL] = "setfval",
 	[OP_SYMADDR] = "symaddr",
@@ -345,6 +346,11 @@ const char *show_instruction(struct instruction *insn)
 		buf += sprintf(buf, "%s", show_label(insn->bb_true));
 		break;
 
+	case OP_LABEL:
+		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
+		buf += sprintf(buf, "%s", show_label(insn->bb_true));
+		break;
+
 	case OP_SETVAL: {
 		struct expression *expr = insn->val;
 		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
diff --git a/liveness.c b/liveness.c
index 33cd04831fc0..30a9a5b6b169 100644
--- a/liveness.c
+++ b/liveness.c
@@ -92,6 +92,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		USES(src); USES(target);
 		break;
 
+	case OP_LABEL:
 	case OP_SETVAL:
 	case OP_SETFVAL:
 		DEFINES(target);
diff --git a/opcode.def b/opcode.def
index 2627abd4d894..ba757dae3c5a 100644
--- a/opcode.def
+++ b/opcode.def
@@ -98,6 +98,7 @@ OPCODE(STORE,        BADOP,    BADOP,    BADOP, BADOP, 1, OPF_NONE)
 /* Other */
 OPCODE(PHISOURCE,    BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
 OPCODE(PHI,          BADOP,    BADOP,    BADOP, BADOP, 0, OPF_TARGET)
+OPCODE(LABEL,        BADOP,    BADOP,    BADOP, BADOP, 0, OPF_TARGET)
 OPCODE(SETVAL,       BADOP,    BADOP,    BADOP, BADOP, 0, OPF_TARGET)
 OPCODE(SETFVAL,      BADOP,    BADOP,    BADOP, BADOP, 0, OPF_TARGET)
 OPCODE(CALL,         BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
diff --git a/simplify.c b/simplify.c
index 24ecf074206e..e3344434f6d1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -325,7 +325,6 @@ int kill_insn(struct instruction *insn, int force)
 		/* fall through */
 
 	case OP_UNOP ... OP_UNOP_END:
-	case OP_SETVAL:
 	case OP_SLICE:
 		kill_use(&insn->src1);
 		break;
@@ -379,6 +378,8 @@ int kill_insn(struct instruction *insn, int force)
 		return 0;
 
 	case OP_BR:
+	case OP_LABEL:
+	case OP_SETVAL:
 	case OP_SETFVAL:
 	default:
 		break;
@@ -2114,15 +2115,11 @@ found:
 
 static struct basic_block *is_label(pseudo_t pseudo)
 {
-	struct expression *expr;
 	struct instruction *def;
 
-	if (DEF_OPCODE(def, pseudo) != OP_SETVAL)
+	if (DEF_OPCODE(def, pseudo) != OP_LABEL)
 		return NULL;
-	expr = def->val;
-	if (expr->type != EXPR_LABEL)
-		return NULL;
-	return expr->symbol->bb_target;
+	return def->bb_true;
 }
 
 static int simplify_cgoto(struct instruction *insn)
@@ -2141,10 +2138,8 @@ static int simplify_cgoto(struct instruction *insn)
 			return replace_pseudo(insn, &insn->src1, def->cond);
 		}
 		break;
-	case OP_SETVAL:
-		if (def->val->type != EXPR_LABEL)
-			break;
-		target = def->val->symbol->bb_target;
+	case OP_LABEL:
+		target = def->bb_true;
 		if (!target->ep)
 			return 0;
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
@@ -2162,6 +2157,21 @@ static int simplify_cgoto(struct instruction *insn)
 	return 0;
 }
 
+static int simplify_setval(struct instruction *insn)
+{
+	struct expression *val = insn->val;
+
+	switch (val->type) {
+	case EXPR_LABEL:
+		insn->opcode = OP_LABEL;
+		insn->bb_true = val->symbol->bb_target;
+		return REPEAT_CSE;
+	default:
+		break;
+	}
+	return 0;
+}
+
 int simplify_instruction(struct instruction *insn)
 {
 	unsigned flags;
@@ -2227,9 +2237,11 @@ int simplify_instruction(struct instruction *insn)
 		return replace_with_pseudo(insn, insn->src);
 	case OP_SLICE:
 		break;
-	case OP_SETVAL:
+	case OP_LABEL:
 	case OP_SETFVAL:
 		break;
+	case OP_SETVAL:
+		return simplify_setval(insn);
 	case OP_PHI:
 		return clean_up_phi(insn);
 	case OP_PHISOURCE:
diff --git a/sparse-llvm.c b/sparse-llvm.c
index c984dc877a61..972ddfeea54f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -935,6 +935,14 @@ static void output_op_fpcast(struct function *fn, struct instruction *insn)
 	insn->target->priv = target;
 }
 
+static void output_op_label(struct function *fn, struct instruction *insn)
+{
+	LLVMValueRef target;
+
+	target = LLVMBlockAddress(fn->fn, insn->bb_true->priv);
+	insn->target->priv = target;
+}
+
 static void output_op_setval(struct function *fn, struct instruction *insn)
 {
 	struct expression *val = insn->val;
@@ -975,6 +983,9 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_SYMADDR:
 		assert(0);
 		break;
+	case OP_LABEL:
+		output_op_label(fn, insn);
+		break;
 	case OP_SETVAL:
 		output_op_setval(fn, insn);
 		break;
diff --git a/validation/optim/cse-label.c b/validation/optim/cse-label.c
index e42968204615..c3b552d3dec9 100644
--- a/validation/optim/cse-label.c
+++ b/validation/optim/cse-label.c
@@ -7,7 +7,6 @@ label:
 /*
  * check-name: cse-label
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

