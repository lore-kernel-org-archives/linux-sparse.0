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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6332BC388F9
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E65920E65
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvVBNuyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgKPW3h (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKPW3g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:36 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA0C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:36 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id za3so26684451ejb.5
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81wWsgCfCpRqHeMvLjRhUTOdhmlgnZ/Rg1IK7eWxBcc=;
        b=OvVBNuyIuML8B8xc95eMMjIatxE0ym+WGkYOhpv3t2pgO1M6O2O416wuSOmaQqVYWB
         Oh2+XUV+3xmDgW0AMAmCbsyrYPnoHzLa0nMK6NV+CJshZOnC+uNkfuZfffJdkHg30N9x
         U/zTTx2TkU+YFREbFkpcEXjJ655XqRiAhZTlkp6lEW2EZxKIrj3zdoqfJwuwFVy4ChrR
         tJUwZjYbVQMuipjfx/RwHoWER83Ckrs5KvvrZyt+FBANxHCZ7jBGBvth8UA95qsVbdiL
         YebTvI/llywQSGIOYKBYtIhajJzp9FsMvLigu2bliXFbkF2KGIhvXxm5M+3j+B2idLFK
         lwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81wWsgCfCpRqHeMvLjRhUTOdhmlgnZ/Rg1IK7eWxBcc=;
        b=jThARrBOKcWzTiZJ4gVbWy0fTcZIkSSlFuLFfYyiBrzt90Xj21M8cb979edmQeSFO2
         8uhUT0W8zs3G/8STt4QrK7QxElrUuLJI6yVx/7JZABblK0Qf1ehJgEr9cCPZctG8jdOl
         kkp2vxYNw+H2stYHRml+wjshZNtyCk0X5+uOPHYMvdxMviZxLUQ/4cH3jbsrPzTgdnM9
         /tJFEOy/XumDrT/jevTeVtwAceYqDQmAC7FTdB5RPnR28UZ9ZHsPycLioJDeWOii13+k
         HrL+BzE3GCHwVUOHCSjarF8g8amjYT6Y5MJI7QdupBPyLn+BR3Tu4TDit6MNRIVp+BLx
         h5eA==
X-Gm-Message-State: AOAM533uJcEZfNLSemW5sljvwEQT3ILa2kWNg2CSVtJ9oUe/QBwQEQh+
        Ll2ulUV+oOneM8fUOZnwaUySXvXf20Y=
X-Google-Smtp-Source: ABdhPJyCH5mM2FIk/9//G/0sGj4iqQ+WLmy4Mox07oVLhptdVHbEhfu9Jp8zm/CM2jGoR4xxpe3xhg==
X-Received: by 2002:a17:906:a891:: with SMTP id ha17mr16648850ejb.116.1605565775143;
        Mon, 16 Nov 2020 14:29:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:34 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] cfg: extract merge_bb() from pack_basic_blocks()
Date:   Mon, 16 Nov 2020 23:29:22 +0100
Message-Id: <20201116222927.51939-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Extract merge_bb() from pack_basic_blocks() in order to reuse this
part of the code in other simplification/finer grained version of
pack_basic_blocks().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 58 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/flow.c b/flow.c
index ef8d04e5827f..9ae8612a2312 100644
--- a/flow.c
+++ b/flow.c
@@ -723,13 +723,46 @@ void vrfy_flow(struct entrypoint *ep)
 	assert(!entry);
 }
 
+///
+// merge two BBs
+// @top: the first BB to be merged
+// @bot: the second BB to be merged
+static int merge_bb(struct basic_block *top, struct basic_block *bot)
+{
+	struct instruction *insn;
+	struct basic_block *bb;
+
+	if (top == bot)
+		return 0;
+
+	top->children = bot->children;
+	bot->children = NULL;
+	bot->parents = NULL;
+
+	FOR_EACH_PTR(top->children, bb) {
+		replace_bb_in_list(&bb->parents, bot, top, 1);
+	} END_FOR_EACH_PTR(bb);
+
+	kill_instruction(delete_last_instruction(&top->insns));
+	FOR_EACH_PTR(bot->insns, insn) {
+		if (!insn->bb)
+			continue;
+		assert(insn->bb == bot);
+		insn->bb = top;
+		add_instruction(&top->insns, insn);
+	} END_FOR_EACH_PTR(insn);
+	bot->insns = NULL;
+	bot->ep = NULL;
+	return REPEAT_CFG_CLEANUP;
+}
+
 void pack_basic_blocks(struct entrypoint *ep)
 {
 	struct basic_block *bb;
 
 	/* See if we can merge a bb into another one.. */
 	FOR_EACH_PTR(ep->bbs, bb) {
-		struct instruction *first, *insn;
+		struct instruction *first;
 		struct basic_block *parent, *child, *last;
 
 		if (!bb_reachable(bb))
@@ -786,28 +819,7 @@ out:
 				goto no_merge;
 		} END_FOR_EACH_PTR(child);
 
-		/*
-		 * Merge the two.
-		 */
-		repeat_phase |= REPEAT_CFG_CLEANUP;
-
-		parent->children = bb->children;
-		bb->children = NULL;
-		bb->parents = NULL;
-
-		FOR_EACH_PTR(parent->children, child) {
-			replace_bb_in_list(&child->parents, bb, parent, 0);
-		} END_FOR_EACH_PTR(child);
-
-		kill_instruction(delete_last_instruction(&parent->insns));
-		FOR_EACH_PTR(bb->insns, insn) {
-			if (!insn->bb)
-				continue;
-			assert(insn->bb == bb);
-			insn->bb = parent;
-			add_instruction(&parent->insns, insn);
-		} END_FOR_EACH_PTR(insn);
-		bb->insns = NULL;
+		repeat_phase |= merge_bb(parent, bb);
 
 	no_merge:
 		/* nothing to do */;
-- 
2.29.2

