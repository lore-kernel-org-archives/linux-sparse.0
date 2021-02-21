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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC20C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4695164EBE
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhBUW3V (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhBUW3U (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:29:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC77C06178A
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:28:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h25so5947238eds.4
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaQKWBtND5iMGgbPJRM56FQVBFx5cBOmcDOmGicPlYk=;
        b=NcvAAh9SQcyoeW3j8oAeq2sKM328dGDzt1O5s/x3SpvI5bkyfCfol2qM8LJ9uLOeCu
         Gw5okyeOvKMPqLo4LPQVK9PmvBfdGEST/aaBv43PuWIjp4uV/eGOQjM2temM2NFJny+a
         5Rb+WpCEc4W00m3+f7IN2ynF85+5q7nftjrtyQpiru85iR+rUOVdd0bvKmCFFdTJErZj
         9dlkErPcwXNwmG/VvhkZyiP5BQEJxoJfahI7qUdLCks8HI/3ER06nCQY0SddmGw8i/0y
         27bHDTOoIXz698QWaA7hDYGE0QyDamYxeelJZywYAbh8i5keNEIUY9BVvPRXJMvJZJ0N
         0DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaQKWBtND5iMGgbPJRM56FQVBFx5cBOmcDOmGicPlYk=;
        b=KbdnY4qIn1xg2zg/MECel28m1v17yRsdNiggsYt+RfUIOOgzQQz3bgBn25f3TRn1R0
         a8LbKVFxarr0skbViyrkoogYo6SUbnj3treM2ROrPDn6v2CJ3WHdMsn5ANp4hhqgJrW0
         DwYXbAmXyIidcJKfepvkkzL/ImzTRyNyJNxKXdHFUfPz0PpqxVz9XAjJE03twJ4TpG46
         9PoVOWDipARKrAuLY13CJtFnzzCU26I4d/QjZpbfH/GeUROQly0kR4iRyM4peRsZdCqj
         WVSjjmEcv4/UyIyyIp5JXYP/9EezMUs5/oI7ZvrmaRz32Mzyz2k0HrWsAgDsxYSczJLe
         KoLA==
X-Gm-Message-State: AOAM533QI+j6ZagzKifTM+5s7CfKRujaX3pi3w1yLe3Yf000FtbcZwt0
        LpQzLo4hAN1nbaJ3TKlhl1Gnfz2thfw=
X-Google-Smtp-Source: ABdhPJzIejC709m9pCKrMqDa/WTWPqRLV/pg8Swx70DAy+XEeh7juwKSBqu5t7nlJIXbj7WcMiR7tg==
X-Received: by 2002:a05:6402:160b:: with SMTP id f11mr3009574edv.225.1613946519123;
        Sun, 21 Feb 2021 14:28:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id d6sm297744ejr.59.2021.02.21.14.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:28:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] asm: factor out add_asm_rule() from add_asm_{in,out}put()
Date:   Sun, 21 Feb 2021 23:28:33 +0100
Message-Id: <20210221222834.7974-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221222834.7974-1-luc.vanoostenryck@gmail.com>
References: <20210221222834.7974-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The functions add_asm_input() and add_asm_output() are very similar.
So, factorize out the common part.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/linearize.c b/linearize.c
index 7a6f745fd4fc..6efa47492869 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2127,22 +2127,27 @@ static pseudo_t linearize_range(struct entrypoint *ep, struct statement *stmt)
 ALLOCATOR(asm_rules, "asm rules");
 ALLOCATOR(asm_constraint, "asm constraints");
 
-static void add_asm_input(struct entrypoint *ep, struct instruction *insn, struct asm_operand *op)
+static void add_asm_rule(struct instruction *insn, struct asm_constraint_list **list, struct asm_operand *op, pseudo_t pseudo)
 {
-	pseudo_t pseudo = linearize_expression(ep, op->expr);
 	struct asm_constraint *rule = __alloc_asm_constraint(0);
-
+	rule->is_memory = op->is_memory;
 	rule->ident = op->name;
 	rule->constraint = op->constraint ? op->constraint->string->data : "";
 	use_pseudo(insn, pseudo, &rule->pseudo);
-	add_ptr_list(&insn->asm_rules->inputs, rule);
+	add_ptr_list(list, rule);
+}
+
+static void add_asm_input(struct entrypoint *ep, struct instruction *insn, struct asm_operand *op)
+{
+	pseudo_t pseudo = linearize_expression(ep, op->expr);
+
+	add_asm_rule(insn, &insn->asm_rules->inputs, op, pseudo);
 }
 
 static void add_asm_output(struct entrypoint *ep, struct instruction *insn, struct asm_operand *op)
 {
 	struct access_data ad = { NULL, };
 	pseudo_t pseudo;
-	struct asm_constraint *rule;
 
 	if (op->is_memory) {
 		pseudo = linearize_expression(ep, op->expr);
@@ -2152,12 +2157,8 @@ static void add_asm_output(struct entrypoint *ep, struct instruction *insn, stru
 		pseudo = alloc_pseudo(insn);
 		linearize_store_gen(ep, pseudo, &ad);
 	}
-	rule = __alloc_asm_constraint(0);
-	rule->is_memory = op->is_memory;
-	rule->ident = op->name;
-	rule->constraint = op->constraint ? op->constraint->string->data : "";
-	use_pseudo(insn, pseudo, &rule->pseudo);
-	add_ptr_list(&insn->asm_rules->outputs, rule);
+
+	add_asm_rule(insn, &insn->asm_rules->outputs, op, pseudo);
 }
 
 static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement *stmt)
-- 
2.30.0

