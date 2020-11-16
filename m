Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC12CC5519F
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A19120E65
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSYl9dDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgKPW3n (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbgKPW3n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:43 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB21C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:41 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so20383781edt.9
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ovcgFCBeKX8imgvBSGlqNn+DZPHjfrOkSCFV+vltzo=;
        b=sSYl9dDs9D0FHF+80aRV5UUNYCpeZSyNX20/MYn6rGPn5YubTfdeO2yG3jtyy0B0cP
         nFH6wCzqieq7lZZSRbgY4gSi691FaNRxzWPLUhYQC33FZefdaQdVpgwkkOiB9ZhCzCp+
         aQyYOQIEfBXQQPbcbGhgkpHu7NjTocBIaTpyyb+BR/BFS0KFOS9NIVtF71mpdso8d9AN
         QF5Xurh72mYPAsEU6cOX8grv0VAvpStooazURHLxpHidgM4O4J1MxAPgCouJ1a2w6X3C
         3cQ1xSWCuj3Z0xeUQ71SkfEp2BAHAe2ben5EFj+st4FziknTiaTZ32ALEPQFMy1SaD7J
         05tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ovcgFCBeKX8imgvBSGlqNn+DZPHjfrOkSCFV+vltzo=;
        b=F/N9bGgiSdxfkHPE+a3K4r1eh32d2Q2U3XLoH2+V7J/T42SNeZH26WrXUMK4MuKysO
         fqNkYizBffKpYh7qY6acd82lh3diX26R4cFP4xtqmGgGHdlRNvBp7mcIB/+/grWR1OTR
         cy/tEVhefpUElhxJwCZ97+8ZyOVQy+aO50wVkDF/oyZuExRT9tbWFJodPQzcrwjOkt2c
         OhSrZAffv0S6qRnfW9xfAvDLDf80ZzZifiZxFv7GrqWt7hUKyDl7hJxOL98T/z4btRF2
         CgLkjhKCIOX3arpJO2UOLZpkPx0hHgF3Y/bjHOnfXAOpBdX65a9BZqRTp2k39nvCR62D
         A7YQ==
X-Gm-Message-State: AOAM533vU/MDN8llx7CUsxGqEu9S5EHei+PLUOLOhH2GIDiDlSdUMPXL
        lw/IeyB2K4Q1neC02SijrgXmP2NXpIY=
X-Google-Smtp-Source: ABdhPJw43gi6DJdHgau2KUz7wa043jg7lbXxZ9PiHSCqOJfstnv1iydHRo35SqVgeFFtSCqUyp5oNQ==
X-Received: by 2002:aa7:d1d8:: with SMTP id g24mr18814837edp.324.1605565780307;
        Mon, 16 Nov 2020 14:29:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] cfg: early CFG simplification
Date:   Mon, 16 Nov 2020 23:29:27 +0100
Message-Id: <20201116222927.51939-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The linearization step sometimes creates a lot of intermediate
basic blocks, often containing just a branch. Their presence often
make things more complicated than needed (more work to do in later
phases, visual clutter when inspection the IR 'by hand') and they
can sometimes, indirectly hinder some optimizations.

Happily, most of them can trivially be optimized away.
So, add a CFG simplification phase running very early and doing:
*) jump threading (eliminate jump to jump)
*) merge single-child/sinle-parents basic blocks.

These changes slightly decrease the number of 'context imbalance'
warnings (32 less on a total of 995 warnings) and the size of
the generated IR (only ~0.4% but this is very significant relatively
to most other simplifications).

They also seem to improve the kernel tests' running time:
	before			after
	real   4m19.261s	real   4m17.548s
	user  72m03.634s	user  71m34.642s
	sys   29m05.573s	sys   29m01.856s
but it's probably just noise.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                                       | 78 ++++++++++++++++++++
 flow.h                                       |  1 +
 optimize.c                                   |  5 ++
 validation/call-inlined.c                    |  4 +
 validation/expand/builtin_constant_inline0.c |  1 +
 validation/inline_base0.c                    |  3 +
 validation/linear/builtin_unreachable0.c     |  4 +-
 validation/linear/builtin_unreachable1.c     |  4 +-
 validation/linear/call-inline.c              |  2 +-
 validation/mem2reg/cond-expr.c               |  4 +-
 validation/mem2reg/cond-expr5.c              |  5 +-
 validation/optim/cse-size.c                  |  2 +-
 12 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/flow.c b/flow.c
index 23886f9d84fa..f56e72db470c 100644
--- a/flow.c
+++ b/flow.c
@@ -121,6 +121,31 @@ static int bb_depends_on_phi(struct basic_block *target, struct basic_block *src
 	return 0;
 }
 
+///
+// does the BB contains ignorable instructions but a final branch?
+// :note: something could be done for phi-sources but ... we'll see.
+static bool bb_is_forwarder(struct basic_block *bb)
+{
+	struct instruction *insn;
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
+		switch (insn->opcode) {
+		case OP_NOP:
+		case OP_INLINED_CALL:
+			continue;
+		case OP_CBR:
+		case OP_BR:
+			return true;
+		default:
+			goto out;
+		}
+	} END_FOR_EACH_PTR(insn);
+out:
+	return false;
+}
+
 /*
  * When we reach here, we have:
  *  - a basic block that ends in a conditional branch and
@@ -742,6 +767,22 @@ void vrfy_flow(struct entrypoint *ep)
 	assert(!entry);
 }
 
+static int retarget_parents(struct basic_block *bb, struct basic_block *target)
+{
+	struct basic_block *parent;
+
+	/*
+	 * We can't do FOR_EACH_PTR() here, because the parent list
+	 * may change when we rewrite the parent.
+	 */
+	while ((parent = first_basic_block(bb->parents))) {
+		if (!rewrite_parent_branch(parent, bb, target))
+			return 0;
+	}
+	kill_bb(bb);
+	return REPEAT_CFG_CLEANUP;
+}
+
 static void adjust_phisrc(struct basic_block *top, struct instruction *insn)
 {
 	struct instruction *user = get_phinode(insn);
@@ -821,6 +862,43 @@ static int merge_bb(struct basic_block *top, struct basic_block *bot)
 	return REPEAT_CFG_CLEANUP;
 }
 
+///
+// early simplification of the CFG
+// Three things are done here:
+//    # inactive BB are removed
+//    # branches to a 'forwarder' BB are redirected to the forwardee.
+//    # merge single-child/single-parent BBs.
+int simplify_cfg_early(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+	int changed = 0;
+
+	FOR_EACH_PTR_REVERSE(ep->bbs, bb) {
+		struct instruction *insn;
+		struct basic_block *tgt;
+
+		if (!bb->ep) {
+			DELETE_CURRENT_PTR(bb);
+			changed = REPEAT_CFG_CLEANUP;
+			continue;
+		}
+
+		insn = last_instruction(bb->insns);
+		if (!insn)
+			continue;
+		switch (insn->opcode) {
+		case OP_BR:
+			tgt = insn->bb_true;
+			if (bb_is_forwarder(bb))
+				changed |= retarget_parents(bb, tgt);
+			else if (bb_list_size(tgt->parents) == 1)
+				changed |= merge_bb(bb, tgt);
+			break;
+		}
+	} END_FOR_EACH_PTR_REVERSE(bb);
+	return changed;
+}
+
 void pack_basic_blocks(struct entrypoint *ep)
 {
 	struct basic_block *bb;
diff --git a/flow.h b/flow.h
index 099767d408f5..19a743c83b94 100644
--- a/flow.h
+++ b/flow.h
@@ -18,6 +18,7 @@ extern void kill_dead_stores(struct entrypoint *ep, pseudo_t addr, int local);
 extern void simplify_symbol_usage(struct entrypoint *ep);
 extern void simplify_memops(struct entrypoint *ep);
 extern void pack_basic_blocks(struct entrypoint *ep);
+extern int simplify_cfg_early(struct entrypoint *ep);
 
 extern void convert_instruction_target(struct instruction *insn, pseudo_t src);
 extern void remove_dead_insns(struct entrypoint *);
diff --git a/optimize.c b/optimize.c
index 8ab105bccdce..338714c78e68 100644
--- a/optimize.c
+++ b/optimize.c
@@ -57,6 +57,11 @@ void optimize(struct entrypoint *ep)
 	kill_unreachable_bbs(ep);
 	ir_validate(ep);
 
+	cfg_postorder(ep);
+	if (simplify_cfg_early(ep))
+		kill_unreachable_bbs(ep);
+	ir_validate(ep);
+
 	domtree_build(ep);
 
 	/*
diff --git a/validation/call-inlined.c b/validation/call-inlined.c
index 3612c5c42690..a6cb4b5b0976 100644
--- a/validation/call-inlined.c
+++ b/validation/call-inlined.c
@@ -28,12 +28,14 @@ foo:
 	<entry-point>
 	add.32      %r3 <- %arg1, %arg2
 	add.32      %r5 <- %r3, $1
+	# call      %r6 <- add, %r3, $1
 	ret.32      %r5
 
 
 bar:
 .L3:
 	<entry-point>
+	# call      %r13 <- add, %r10, $1
 	ret
 
 
@@ -41,6 +43,7 @@ bas:
 .L6:
 	<entry-point>
 	add.64      %r16 <- "abc", $1
+	# call      %r17 <- lstrip, %r14
 	ret.64      %r16
 
 
@@ -48,6 +51,7 @@ qus:
 .L9:
 	<entry-point>
 	add.64      %r21 <- messg, $1
+	# call      %r22 <- lstrip, %r19
 	ret.64      %r21
 
 
diff --git a/validation/expand/builtin_constant_inline0.c b/validation/expand/builtin_constant_inline0.c
index a0057f2094b3..d72a211fd267 100644
--- a/validation/expand/builtin_constant_inline0.c
+++ b/validation/expand/builtin_constant_inline0.c
@@ -16,6 +16,7 @@ int foo(void)
 foo:
 .L0:
 	<entry-point>
+	# call      %r1 <- is_const, $42
 	ret.32      $42
 
 
diff --git a/validation/inline_base0.c b/validation/inline_base0.c
index 517ee972ee05..698c760ff0be 100644
--- a/validation/inline_base0.c
+++ b/validation/inline_base0.c
@@ -27,6 +27,7 @@ foo0:
 .L0:
 	<entry-point>
 	add.32      %r5 <- %arg1, %arg2
+	# call      %r6 <- add, %r1, %r2
 	ret.32      %r5
 
 
@@ -34,12 +35,14 @@ foo1:
 .L3:
 	<entry-point>
 	add.32      %r10 <- %arg1, $1
+	# call      %r11 <- add, %r8, $1
 	ret.32      %r10
 
 
 foo2:
 .L6:
 	<entry-point>
+	# call      %r13 <- add, $1, $2
 	ret.32      $3
 
 
diff --git a/validation/linear/builtin_unreachable0.c b/validation/linear/builtin_unreachable0.c
index 911ed7f97f95..4fc564739e76 100644
--- a/validation/linear/builtin_unreachable0.c
+++ b/validation/linear/builtin_unreachable0.c
@@ -14,12 +14,12 @@ foo:
 .L0:
 	<entry-point>
 	seteq.32    %r2 <- %arg1, $3
-	cbr         %r2, .L1, .L3
+	cbr         %r2, .L1, .L2
 
 .L1:
 	unreachable
 
-.L3:
+.L2:
 	ret.32      %arg1
 
 
diff --git a/validation/linear/builtin_unreachable1.c b/validation/linear/builtin_unreachable1.c
index 70f6674c6443..2fc1d728d7d9 100644
--- a/validation/linear/builtin_unreachable1.c
+++ b/validation/linear/builtin_unreachable1.c
@@ -16,9 +16,9 @@ int foo(int c)
 foo:
 .L0:
 	<entry-point>
-	cbr         %arg1, .L3, .L2
+	cbr         %arg1, .L1, .L2
 
-.L3:
+.L1:
 	ret.32      $1
 
 .L2:
diff --git a/validation/linear/call-inline.c b/validation/linear/call-inline.c
index dfd49b62c4b7..1ad785ee678b 100644
--- a/validation/linear/call-inline.c
+++ b/validation/linear/call-inline.c
@@ -13,6 +13,6 @@ int i3(void) { return (***fun)(); }		// C99,C11 6.5.3.2p4
  *
  * check-output-ignore
  * check-output-excludes: load
- * check-output-excludes: call
+ * check-output-excludes: \\tcall
  * check-output-pattern(5): ret\\..* \\$42
  */
diff --git a/validation/mem2reg/cond-expr.c b/validation/mem2reg/cond-expr.c
index 8acb00ac950f..2474d65d8c64 100644
--- a/validation/mem2reg/cond-expr.c
+++ b/validation/mem2reg/cond-expr.c
@@ -9,6 +9,6 @@ int foo(int a, int b, int c)
  * check-name: cond-expr
  * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
  * check-output-ignore
- * check-output-pattern(2): phi\\.
- * check-output-pattern(3): phisrc\\.
+ * check-output-pattern(1): phi\\.
+ * check-output-pattern(2): phisrc\\.
  */
diff --git a/validation/mem2reg/cond-expr5.c b/validation/mem2reg/cond-expr5.c
index a3ce5e3a955e..beef8f258cd9 100644
--- a/validation/mem2reg/cond-expr5.c
+++ b/validation/mem2reg/cond-expr5.c
@@ -15,7 +15,6 @@ int foo(int p, int q, int a)
  * check-output-ignore
  * check-output-excludes: load\\.
  * check-output-excludes: store\\.
- * check-output-excludes: phi\\..*, .*, .*
- * check-output-pattern(3): phi\\.
- * check-output-pattern(5): phisrc\\.
+ * check-output-pattern(2): phi\\.
+ * check-output-pattern(4): phisrc\\.
  */
diff --git a/validation/optim/cse-size.c b/validation/optim/cse-size.c
index e1a5d492a666..0c0c2d1425ed 100644
--- a/validation/optim/cse-size.c
+++ b/validation/optim/cse-size.c
@@ -13,6 +13,6 @@ static void foo(void)
  * check-command: test-linearize -Wno-decl $file
  *
  * check-output-ignore
- * check-output-pattern(0,1): phi\\.
+ * check-output-excludes: phi\\.
  * check-output-excludes: cbr
  */
-- 
2.29.2

