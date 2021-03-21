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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8CBC433E8
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB996194C
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCUMf1 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCUMfS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1070C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b9so16837918ejc.11
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhHrSsFLQ8zGT4n2tnQ0BNI4MYw/+5QJZ+BU/ZQoXKQ=;
        b=ngW9wWgGxGhD2zXfPXj0dpsgTJn4X9pSCj4m+eEc50BQQMpuxCc/Cw0o7BaCRFjswK
         2nocK/YcFMHN6Pl/2EeqVXUj+qGIKDA03iP7htjmVWbYY0qHTPukhIQ4juerBE5Vwc7z
         j42U3UgqShX8vmAquRlatrGNYqqt0K40n/qWP2t50C57Bnlkbs8g9CvXSL7AZDhc+s9c
         8pfUd4jLXrwTA+ojxV2loddiZX4YJapt+mZul5Sl/mq8feI7MA8cBLJkoN7wD4LMkzwB
         1h1B+AR925YMSOZIw9/OjNislTrYyZgNbbppgF/4zFfbyrOI9+BoUsSB8gQ9T87Y8qHN
         Mmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhHrSsFLQ8zGT4n2tnQ0BNI4MYw/+5QJZ+BU/ZQoXKQ=;
        b=KWpRuoSUaRIYiFyt1LX5s7Z25Sqk7DzzTEvj640eVXq2/cPIsyBOZVqX7ZgCPrPPYC
         xfmeie0nxhAPiOT0WLwVM60Y2mbyHa62jWSAK+Oi4olSn2+Zcblp9Xrn+nDL6GmJAGko
         KAp1LtlTBXePFA20yj0GG/L9EyZhnn+wIgj7X5+JZw1QDEcEXSd7+WmvL8LioaELlfNj
         AkztjTXtsG7e5kpbNoGQEOM7HFSaiAL5cOzO56GA5eE+0ZHmPKFVYkida7wteaEyrJbR
         iNYOc/oaxbTeVukE36IPMQ7JEd50d5ercZPXCv7u6vRQ7aigNepugirAFFjZiY0jT/p+
         7LaQ==
X-Gm-Message-State: AOAM53124wnQvZ5gA5Xn6ceC8mJqsgPpTZzGbd/bTFIGzNl/kx8NTgl6
        gWKcJkrKxU6epIw28Jms8EWkBvrqyYg=
X-Google-Smtp-Source: ABdhPJzDyeBDEPIqLuJvJvHxWs/ZX2Ef0enoqPFK9lHzcysy0oc1aoOG+f7VXZ34uYPfq2Gum4CUOw==
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr14913389ejm.87.1616330116665;
        Sun, 21 Mar 2021 05:35:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/13] move insert_branch() to flow.c
Date:   Sun, 21 Mar 2021 13:34:59 +0100
Message-Id: <20210321123505.27993-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that insert_branch() doesn't need to allocate a new instruction,
there is no more reasons to have it defined in linearize.c

So move it to flow.c which is more concerned with CFG changes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c      | 26 ++++++++++++++++++++++++++
 flow.h      |  1 +
 linearize.c | 26 --------------------------
 linearize.h |  1 -
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/flow.c b/flow.c
index f85c2a30c3cb..1f4b4ff08151 100644
--- a/flow.c
+++ b/flow.c
@@ -709,6 +709,32 @@ void vrfy_flow(struct entrypoint *ep)
 	assert(!entry);
 }
 
+///
+// change a switch or a conditional branch into a branch
+void insert_branch(struct instruction *insn, struct basic_block *target)
+{
+	struct basic_block *bb = insn->bb;
+	struct basic_block *child;
+
+	kill_use(&insn->cond);
+	insn->bb_true = target;
+	insn->bb_false = NULL;
+	insn->cond = NULL;
+	insn->size = 0;
+	insn->opcode = OP_BR;
+
+	FOR_EACH_PTR(bb->children, child) {
+		if (child == target) {
+			target = NULL;	// leave first occurence
+			continue;
+		}
+		DELETE_CURRENT_PTR(child);
+		remove_bb_from_list(&child->parents, bb, 1);
+	} END_FOR_EACH_PTR(child);
+	PACK_PTR_LIST(&bb->children);
+	repeat_phase |= REPEAT_CFG_CLEANUP;
+}
+
 static int retarget_parents(struct basic_block *bb, struct basic_block *target)
 {
 	struct basic_block *parent;
diff --git a/flow.h b/flow.h
index 46d76a780484..f9213306dfd6 100644
--- a/flow.h
+++ b/flow.h
@@ -18,6 +18,7 @@ extern void simplify_symbol_usage(struct entrypoint *ep);
 extern void simplify_memops(struct entrypoint *ep);
 extern void pack_basic_blocks(struct entrypoint *ep);
 extern int simplify_cfg_early(struct entrypoint *ep);
+extern void insert_branch(struct instruction *insn, struct basic_block *target);
 
 extern void convert_instruction_target(struct instruction *insn, pseudo_t src);
 extern void remove_dead_insns(struct entrypoint *);
diff --git a/linearize.c b/linearize.c
index 1d85cf2ba208..e6aa01f1b9fe 100644
--- a/linearize.c
+++ b/linearize.c
@@ -692,32 +692,6 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
 		add_bb(&ep->bbs, bb);
 }
 
-/* Change a "switch" or a conditional branch into a branch */
-void insert_branch(struct instruction *jmp, struct basic_block *target)
-{
-	struct basic_block *bb = jmp->bb;
-	struct basic_block *child;
-
-	kill_use(&jmp->cond);
-	jmp->bb_true = target;
-	jmp->bb_false = NULL;
-	jmp->cond = NULL;
-	jmp->size = 0;
-	jmp->opcode = OP_BR;
-
-	FOR_EACH_PTR(bb->children, child) {
-		if (child == target) {
-			target = NULL;	/* Trigger just once */
-			continue;
-		}
-		DELETE_CURRENT_PTR(child);
-		remove_bb_from_list(&child->parents, bb, 1);
-	} END_FOR_EACH_PTR(child);
-	PACK_PTR_LIST(&bb->children);
-	repeat_phase |= REPEAT_CFG_CLEANUP;
-}
-	
-
 void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi_node, pseudo_t if_true, pseudo_t if_false)
 {
 	pseudo_t target;
diff --git a/linearize.h b/linearize.h
index 1bb9d77eba1f..b6c8bf134065 100644
--- a/linearize.h
+++ b/linearize.h
@@ -319,7 +319,6 @@ struct entrypoint {
 };
 
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
-extern void insert_branch(struct instruction *br, struct basic_block *target);
 
 struct instruction *alloc_phisrc(pseudo_t pseudo, struct symbol *type);
 struct instruction *alloc_phi_node(struct basic_block *bb, struct symbol *type, struct ident *ident);
-- 
2.31.0

