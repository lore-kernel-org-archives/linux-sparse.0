Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097F2C43334
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 13:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiFZNIF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiFZNID (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 09:08:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97801151
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 06:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E8B3B80D8E
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 13:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C829C341CA;
        Sun, 26 Jun 2022 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656248879;
        bh=WViLtkh4M0IfYdsXOjabRJdmXKarw/L4MRoWslmvz48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoP8EHCSpFJomyP2oC1LGBWmLY+U4ECLLUewSByt0oYjQjy8Lqx5BaTHjGqE1EB8f
         osD2KhlKSBYim2v0e4WdEaRRShAL44McWQyrhCHxfOMBrJDYvmG8WQsTJiWpXFY6F2
         VNuosi3ED6mKe3pX3fKqGusd4u3ADdS7MOd8H/18NaL+OwsiosCAHSaBIpSdlVOCUN
         7Zjp148xWsqddN7ENl4hrexNAv5sZUQHeseNVYMq3v2m53QkbQwLXd03h4f75A+Ext
         mxnZysPzQ9+66gZAyp12tesV6oZzspsFZOiOaz8nksJCSWnoUQAVzOuWj/8e61ZG7C
         8Ojlw4g4wx6lw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] inline: avoid needless intermediate vars
Date:   Sun, 26 Jun 2022 15:07:46 +0200
Message-Id: <20220626130748.74163-5-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626130748.74163-1-lucvoo@kernel.org>
References: <20220626130748.74163-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In inline_function(), the we need to iterate over the parameters
and the (effective) arguments. An itermediate variable is used for
each: "name_list" and "arg_list".

These confuse me a lot (especially "name_list", "param_list" would
be much more OK) and are just used once.

So, avoid using an intermediate variable for these.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 inline.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/inline.c b/inline.c
index 4696eb509f9a..a6f9252ab0ff 100644
--- a/inline.c
+++ b/inline.c
@@ -516,9 +516,8 @@ int inline_function(struct expression *expr, struct symbol *sym)
 {
 	struct symbol_list * fn_symbol_list;
 	struct symbol *fn = sym->ctype.base_type;
-	struct expression_list *arg_list = expr->args;
 	struct statement *stmt = alloc_statement(expr->pos, STMT_COMPOUND);
-	struct symbol_list *name_list, *arg_decl;
+	struct symbol_list *arg_decl;
 	struct symbol *name;
 	struct expression *arg;
 
@@ -529,8 +528,6 @@ int inline_function(struct expression *expr, struct symbol *sym)
 	if (fn->expanding)
 		return 0;
 
-	name_list = fn->arguments;
-
 	expr->type = EXPR_STATEMENT;
 	expr->statement = stmt;
 	expr->ctype = fn->ctype.base_type;
@@ -538,8 +535,8 @@ int inline_function(struct expression *expr, struct symbol *sym)
 	fn_symbol_list = create_symbol_list(sym->inline_symbol_list);
 
 	arg_decl = NULL;
-	PREPARE_PTR_LIST(name_list, name);
-	FOR_EACH_PTR(arg_list, arg) {
+	PREPARE_PTR_LIST(fn->arguments, name);
+	FOR_EACH_PTR(expr->args, arg) {
 		struct symbol *a = alloc_symbol(arg->pos, SYM_NODE);
 
 		if (name) {
-- 
2.36.1

