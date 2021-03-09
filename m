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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A73BC43381
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39249650FD
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhCIXms (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhCIXmm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 Mar 2021 18:42:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB8C06174A
        for <linux-sparse@vger.kernel.org>; Tue,  9 Mar 2021 15:42:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bm21so33028555ejb.4
        for <linux-sparse@vger.kernel.org>; Tue, 09 Mar 2021 15:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDOrXrXq3W6dYiwD4LWQb5jtSN56eL5saJFxPOWBAII=;
        b=KkdaxAOL+C/trHOuX2SvP6KBtt/PzFQzRANJ9WDfdGp+Om2tJgmiuhErmzgauZGi3s
         DOmb61QleE6qDGse5EPvEjgRyv8Y1O9QzPvHd8zFqvuP+CHCWLswJOG/srQDUDCCAQvp
         2wP5irjSmRbGLc+6g46uZglu/TvCmgQsxV95x4rCwP7uglusbvtGU3Ux5o2KfFQCoEvG
         vgGBP9zgLNA1uFH9jHp8z7MMR/nistJqd2u0GsOSj+sEzFLD14hiro8a1n3ODEaFsmMd
         Rwiypx3Oi4X+JLJkZzUDY0ygK73j2R7yJVY1jJfKDzkL35dxUUi3gWQx/LDnG1NJ5Eb/
         hdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDOrXrXq3W6dYiwD4LWQb5jtSN56eL5saJFxPOWBAII=;
        b=CDQe/jEKT9IrXbjDw4ZgcxKDFvlNO8qqTYlZotybhDGdemlGp0ZJRdlI6CLd2YDJDl
         3PKrE8M6Epco64dic8RvvBEbuJPhFnYRwjdl70hRRjdSewSVigsbE3dL//Xk3mCgqjIl
         Gu8dMUKee8yHq5D4jz2kPcqC0azrSNAfOaBJpqbIEhIJzdeNGNTzSWHHXqCbgVZFYEe1
         usuBpZXHOaZimX7FSnoHntcfr4XLF7gXwFIn0OKR8jw410H3R/lKpFVYBgCikaoPuQR3
         QZOEKT+jXYVdv4bRDcYwhy4IozZj4ezdP+L7lhUe1poXIyFzKBII9I5kZNOGIcRLeeC8
         WBPg==
X-Gm-Message-State: AOAM532uyJbnnVYnG/ay1nLNYXWqeaETwQ8ssnrqZfjGfdwNdHUDkpNm
        IVso4yIVe9+h+gxyTVELjoGc2PpKMrg=
X-Google-Smtp-Source: ABdhPJxkwPif/YLdwjQzbFJsTqCo92Z/sIORM7uGT7LCqxeyvtjoPUbYYPTei76vWKZg2kbx6/AqSA==
X-Received: by 2002:a17:906:ecf3:: with SMTP id qt19mr502283ejb.467.1615333360540;
        Tue, 09 Mar 2021 15:42:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:1dad:50b9:7959:c788])
        by smtp.gmail.com with ESMTPSA id cw14sm10147984edb.8.2021.03.09.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 15:42:40 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] ssa: fix conversion with mismatched size or offset
Date:   Wed, 10 Mar 2021 00:42:32 +0100
Message-Id: <20210309234232.50889-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
References: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The SSA conversion works under the assumption that all the memory
operations on a given symbol always refer to the same object.

So, exclude the conversion of variables where:
* memory operations do not always match in size or offset
* there is an implicit integer/float conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h                          |  2 +-
 ssa.c                                | 97 ++++++++++++++++++++++------
 validation/mem2reg/not-same-memop0.c |  1 -
 3 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/linearize.h b/linearize.h
index 7909b01f29c5..86ae119c82e6 100644
--- a/linearize.h
+++ b/linearize.h
@@ -18,7 +18,7 @@ struct pseudo_user {
 
 DECLARE_ALLOCATOR(pseudo_user);
 DECLARE_PTR_LIST(pseudo_user_list, struct pseudo_user);
-DECLARE_PTRMAP(phi_map, struct symbol *, pseudo_t);
+DECLARE_PTRMAP(phi_map, struct symbol *, struct instruction *);
 
 
 enum pseudo_type {
diff --git a/ssa.c b/ssa.c
index 26d46baaa16c..f61672a0b530 100644
--- a/ssa.c
+++ b/ssa.c
@@ -96,10 +96,22 @@ static void kill_store(struct instruction *insn)
 	insn->bb = NULL;
 }
 
+static bool same_memop(struct instruction *a, struct instruction *b)
+{
+	if (a->size != b->size || a->offset != b->offset)
+		return false;
+	if (is_integral_type(a->type) && is_float_type(b->type))
+		return false;
+	if (is_float_type(a->type) && is_integral_type(b->type))
+		return false;
+	return true;
+}
+
 static void rewrite_local_var(struct basic_block *bb, pseudo_t addr, int nbr_stores, int nbr_uses)
 {
+	struct instruction *store = NULL;
 	struct instruction *insn;
-	pseudo_t val = NULL;
+	bool remove = false;
 
 	if (!bb)
 		return;
@@ -110,18 +122,21 @@ static void rewrite_local_var(struct basic_block *bb, pseudo_t addr, int nbr_sto
 			continue;
 		switch (insn->opcode) {
 		case OP_LOAD:
-			if (!val)
-				val = undef_pseudo();
-			replace_with_pseudo(insn, val);
+			if (!store)
+				replace_with_pseudo(insn, undef_pseudo());
+			else if (same_memop(store, insn))
+				replace_with_pseudo(insn, store->target);
+			else
+				remove = false;
 			break;
 		case OP_STORE:
-			val = insn->target;
-			// can't use kill_instruction() unless
-			// we add a fake user to val
-			kill_store(insn);
+			store = insn;
+			remove = true;
 			break;
 		}
 	} END_FOR_EACH_PTR(insn);
+	if (remove)
+		kill_store(store);
 }
 
 static bool rewrite_single_store(struct instruction *store)
@@ -139,6 +154,8 @@ static bool rewrite_single_store(struct instruction *store)
 		// by the value from the store. This is only valid
 		// if the store dominate the load.
 
+		if (!same_memop(store, insn))
+			continue;
 		if (insn->bb == store->bb) {
 			// the load and the store are in the same BB
 			// we can convert if the load is after the store.
@@ -257,21 +274,40 @@ external_visibility:
 	kill_dead_stores(ep, addr, !mod);
 }
 
-static pseudo_t lookup_var(struct basic_block *bb, struct symbol *var)
+static struct instruction *lookup_var(struct basic_block *bb, struct symbol *var)
 {
 	do {
-		pseudo_t val = phi_map_lookup(bb->phi_map, var);
-		if (val)
-			return val;
+		struct instruction *insn = phi_map_lookup(bb->phi_map, var);
+		if (insn)
+			return insn;
 	} while ((bb = bb->idom));
-	return undef_pseudo();
+	return NULL;
 }
 
 static struct instruction_list *phis_all;
 static struct instruction_list *phis_used;
+static struct instruction_list *stores;
+
+static bool matching_load(struct instruction *def, struct instruction *insn)
+{
+	if (insn->size != def->size)
+		return false;
+	switch (def->opcode) {
+	case OP_STORE:
+	case OP_LOAD:
+		if (insn->offset != def->offset)
+			return false;
+	case OP_PHI:
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
 
 static void ssa_rename_insn(struct basic_block *bb, struct instruction *insn)
 {
+	struct instruction *def;
 	struct symbol *var;
 	pseudo_t addr;
 	pseudo_t val;
@@ -284,8 +320,8 @@ static void ssa_rename_insn(struct basic_block *bb, struct instruction *insn)
 		var = addr->sym;
 		if (!var || !var->torename)
 			break;
-		phi_map_update(&bb->phi_map, var, insn->target);
-		kill_store(insn);
+		phi_map_update(&bb->phi_map, var, insn);
+		add_instruction(&stores, insn);
 		break;
 	case OP_LOAD:
 		addr = insn->src;
@@ -294,14 +330,22 @@ static void ssa_rename_insn(struct basic_block *bb, struct instruction *insn)
 		var = addr->sym;
 		if (!var || !var->torename)
 			break;
-		val = lookup_var(bb, var);
+		def = lookup_var(bb, var);
+		if (!def) {
+			val = undef_pseudo();
+		} else if (!matching_load(def, insn)) {
+			var->torename = false;
+			break;
+		} else {
+			val = def->target;
+		}
 		replace_with_pseudo(insn, val);
 		break;
 	case OP_PHI:
 		var = insn->type;
 		if (!var || !var->torename)
 			break;
-		phi_map_update(&bb->phi_map, var, insn->target);
+		phi_map_update(&bb->phi_map, var, insn);
 		add_instruction(&phis_all, insn);
 		break;
 	}
@@ -348,7 +392,8 @@ static void ssa_rename_phi(struct instruction *insn)
 		return;
 	FOR_EACH_PTR(insn->bb->parents, par) {
 		struct instruction *term = delete_last_instruction(&par->insns);
-		pseudo_t val = lookup_var(par, var);
+		struct instruction *def = lookup_var(par, var);
+		pseudo_t val = def ? def->target : undef_pseudo();
 		pseudo_t phi = alloc_phi(par, val, var);
 		phi->ident = var->ident;
 		add_instruction(&par->insns, term);
@@ -376,6 +421,18 @@ static void ssa_rename_phis(struct entrypoint *ep)
 	} END_FOR_EACH_PTR(phi);
 }
 
+static void remove_dead_stores(struct instruction_list *stores)
+{
+	struct instruction *store;
+
+	FOR_EACH_PTR(stores, store) {
+		struct symbol *var = store->addr->sym;
+
+		if (var->torename)
+			kill_store(store);
+	} END_FOR_EACH_PTR(store);
+}
+
 void ssa_convert(struct entrypoint *ep)
 {
 	struct basic_block *bb;
@@ -393,6 +450,7 @@ void ssa_convert(struct entrypoint *ep)
 	} END_FOR_EACH_PTR(bb);
 
 	// try to promote memory accesses to pseudos
+	stores = NULL;
 	FOR_EACH_PTR(ep->accesses, pseudo) {
 		ssa_convert_one_var(ep, pseudo->sym);
 	} END_FOR_EACH_PTR(pseudo);
@@ -401,4 +459,7 @@ void ssa_convert(struct entrypoint *ep)
 	phis_all = phis_used = NULL;
 	ssa_rename_insns(ep);
 	ssa_rename_phis(ep);
+
+	// remove now dead stores
+	remove_dead_stores(stores);
 }
diff --git a/validation/mem2reg/not-same-memop0.c b/validation/mem2reg/not-same-memop0.c
index 7a84ddce4efc..4de981956b74 100644
--- a/validation/mem2reg/not-same-memop0.c
+++ b/validation/mem2reg/not-same-memop0.c
@@ -16,7 +16,6 @@ static void foo(struct s s)
 /*
  * check-name: not-same-memop0
  * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
- * check-known-to-fail
  *
  * check-output-start
 local:
-- 
2.30.0

