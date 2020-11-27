Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA17C3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C95921D46
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ+6Dpuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgK0W25 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbgK0W1i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024DFC0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so7715777wmb.5
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcJFeupoq2I+Su3kf87HxC6Hjp7Hy0uwsRH4JXL6yj0=;
        b=nJ+6DpuqoAJ/yMy2vcrm3Y1dNcjN1CAsZg9p728c3U+JyGmAKFQPhrqujhBmLEwTeX
         dF9bcLvSiVOC62V8xhYwA4pIgeE0OObG2AccZifmShkgRQhMXFxoLpJx6dAgzfDrOtj/
         DjefD6qiTruwRQhkqztImaR6QxefMKm4xnNZSQBcRb0vi7hGiFbsSMisJ3hmm2MzWyx7
         kQZNOjC09yMyHwev9x9zxymT6B1FX/VbhaVOnepmd0cEXKTPKXw0z8U+iyfplY0y0TX2
         F0RwAk/uwnljnrsowgUZIFhmeO5g5vab/qrHbbPATMjx0Z/UOqH8VMgqW1gvJGoUvQg3
         +KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcJFeupoq2I+Su3kf87HxC6Hjp7Hy0uwsRH4JXL6yj0=;
        b=dEL/JXWiqeQc2D7nurCbM8zprEcaQSF0EjiwWTuWp7cq0SEXfnaoak3VlOE58rojnI
         Y1C5Zg4JNc4ANyIVWiAb8IsVKZrdBYO+RrFRYb8TvLImsv3ya19bWXg9nEmTdH6g4PwG
         q5HmMgpa0ZN7/yf5e1zHkaDCiVbgqPmAimjNE1co8fejUerFoHgwWAOG1hhkrwD280ug
         Zk5FQLy5pFmsihOB/1mdrajpIQ8sLh4jzVkk33fyvB4wbXFDuLg/mJQqiSrbYzZDBUlu
         N5RKfsOJWX5pvipANdMkJRUY0VjXgT28BVjC6gI2FyEdziLJsplPt5FFqUdFOBI9rzK8
         myVQ==
X-Gm-Message-State: AOAM532TVA1XalrizdbBMHtUhb2/9NoaN3wnFxc7Tz6Am+90cCPEqSh+
        vT4V/0uyaU2O+oKCcfp29rxEkZhXRPE=
X-Google-Smtp-Source: ABdhPJzwZfI72OdihnxlfaOM82qBE0uR+N8K5S4GNTK28DxcEDz3ppiCsIKysIr2kfJzrRbbmDHOnQ==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr11613509wml.136.1606516049566;
        Fri, 27 Nov 2020 14:27:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:29 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/7] move up instructions blocking if-conversion
Date:   Fri, 27 Nov 2020 23:25:16 +0100
Message-Id: <20201127222516.44915-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

---
 linearize.h |  6 +++++
 simplify.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/linearize.h b/linearize.h
index 2c548d43526f..71a693960c9e 100644
--- a/linearize.h
+++ b/linearize.h
@@ -300,6 +300,12 @@ static inline void replace_bb_in_list(struct basic_block_list **list,
 	replace_ptr_list_entry((struct ptr_list **)list, old, new, count);
 }
 
+static inline void replace_insn(struct instruction *old, struct instruction *new)
+{
+	replace_ptr_list_entry((struct ptr_list **)&old->bb->insns, old, new, 1);
+}
+
+
 struct entrypoint {
 	struct symbol *name;
 	struct symbol_list *syms;
diff --git a/simplify.c b/simplify.c
index fc64e5b77adf..14a5562c84a4 100644
--- a/simplify.c
+++ b/simplify.c
@@ -61,6 +61,63 @@ static inline bool is_pow2(pseudo_t src)
 	return is_power_of_2(src->value);
 }
 
+///
+// check if a pseudo is defined in a BB
+//
+// :note: this could also use the liveness information if available.
+//
+static inline bool is_defined_at(pseudo_t src, struct basic_block *bb)
+{
+	if (src->type != PSEUDO_REG)
+		return true;
+	return domtree_dominates(src->def->bb, bb);
+}
+
+///
+// move an instruction at the end of the given BB
+static void move_insn(struct instruction *insn, struct basic_block *bb)
+{
+	struct instruction *last = delete_last_instruction(&bb->insns);
+	insn->bb = bb;
+	add_instruction(&bb->insns, insn);
+	add_instruction(&bb->insns, last);
+}
+
+///
+// try to move an instruction into a BB if all its arguments are defined there
+static bool try_to_move_insn(struct instruction *insn, struct basic_block *bb)
+{
+	static struct instruction NOP;	// will later be ignore because !ep
+
+	if (!bb || bb == insn->bb)
+		return 0;
+
+	switch (insn->opcode) {
+	case OP_SEL:
+		if (!is_defined_at(insn->src3, bb))
+			return 0;
+	case OP_ADD: case OP_SUB:
+	case OP_ASR: case OP_LSR: case OP_SHL:
+	case OP_AND: case OP_XOR: case OP_OR:
+	case OP_BINCMP ... OP_BINCMP_END:
+	case OP_FPCMP ... OP_FPCMP_END:
+	case OP_FADD: case OP_FSUB:
+		// basically, all the binops but multiply and divide, just because
+		if (!is_defined_at(insn->src2, bb))
+			return 0;
+	case OP_UNOP ... OP_UNOP_END:
+		if (!is_defined_at(insn->src1, bb))
+			return 0;
+		break;
+	default:
+		return 0;
+	}
+	replace_insn(insn, &NOP);
+	move_insn(insn, bb);
+	repeat_phase |= REPEAT_CSE;
+	return 1;
+}
+
 ///
 // find the trivial parent for a phi-source
 static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseudo)
@@ -68,8 +125,11 @@ static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseud
 	/* Can't go upwards if the pseudo is defined in the bb it came from.. */
 	if (pseudo->type == PSEUDO_REG) {
 		struct instruction *def = pseudo->def;
-		if (def->bb == source)
-			return source;
+		if (def->bb == source) {
+			// unless we can move the defining instruction up
+			if (!try_to_move_insn(def, source->idom))
+				return source;
+		}
 	}
 	if (bb_list_size(source->children) != 1 || bb_list_size(source->parents) != 1)
 		return source;
-- 
2.29.2

