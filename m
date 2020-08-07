Return-Path: <SRS0=Te2Z=BR=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623BDC433E1
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2F62177B
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTzNAB8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgHGUpP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgHGUpO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Aug 2020 16:45:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A3C061756
        for <linux-sparse@vger.kernel.org>; Fri,  7 Aug 2020 13:45:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so3402032ejc.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Aug 2020 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yabDseEFwoeIWFsjEprp8Old7fvi4uHYQ6vv3rBmhIQ=;
        b=OTzNAB8NtWUYRwK9a90sL/PDaFLFA+YyY+JoraNG6CAw/uF3WCcFFupoVObMaZERSf
         V0zN1n89S9DAJ4SZS6zrJcNaqe1NShuDMdaX9dH3VYhZ6XDE6bV45rlUPKeZW3MzJv5l
         ryNTtRGHC1qh5fwX7oj0nvJFNDfYP0uPGnXCrlLTqoLICSAgjSEy1SWqYQk6hbWwgPb5
         2XZpu+6kGGj25x+IuyEdUzLNeJfs3qRsjNaJsYHyPSXp6m7rwZLvsbVsKwtuxSxB+BjL
         aEWOxCp5j1bcg7uEJYAy5BJWn04XtMslIrkkkD5s23SInqCriLhGbGEmDwT5OyMk5vHd
         57fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yabDseEFwoeIWFsjEprp8Old7fvi4uHYQ6vv3rBmhIQ=;
        b=L3TFJXr7spTfleNPGJ/Ih1sTCy+GqI38C2TLIU43ApBbCbI769DBsKuQuKWrasAVfR
         n0BvEO/uXPVO3e2EG1eD6mg9aisXmRs4io6uR6o18hCn3YdK2X512Oxth19R5uTzmchi
         vux8Ts9lCvmrI06xB0DOfQQNZcysOO6V37jDDE4gTaaG7C8aU759rdNGSo9Srj4NZjGr
         bzj5MhzQdOdm9E7MR47jFrRzLoANMw5En3Nwon4KGORAKwHsfmICcHgCefgn4do+LZjA
         tqn++UckdyQbE7locnK+PDs1jmI7v0QY964Wm9hV+g1igImcUG5U7mRO4h/IsfCO5R9D
         bY9w==
X-Gm-Message-State: AOAM532zOIhBHKB4AoNVwHXVuSiO54PdpAg7zh+uUEojk+Wtj8qd9VuX
        m8fXaW4LdPH9+Pc33haDQcdikk5+
X-Google-Smtp-Source: ABdhPJz94nfqtQOuGb03bQ0X/tGXeu/neNknX5M7dd++rICn0T+D6C8Gf66+BkZ4RTJTYC+a2qX9xg==
X-Received: by 2002:a17:906:9618:: with SMTP id s24mr11112369ejx.53.1596833112873;
        Fri, 07 Aug 2020 13:45:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:8076:aed9:5a81:5448])
        by smtp.gmail.com with ESMTPSA id u4sm6120883edy.18.2020.08.07.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:45:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] export evaluate_arguments()
Date:   Fri,  7 Aug 2020 22:45:05 +0200
Message-Id: <20200807204506.1100-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807204506.1100-1-luc.vanoostenryck@gmail.com>
References: <20200807204506.1100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

evaluate_arguments() is local to evaluate.c but the same functionality
is needed for builtins.

So, in order to not duplicate this code:
*) change slightly its interface to accept the expected types as a list
*) make this function extern.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 7 +++----
 evaluate.h | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index dddea76182ad..7c63cc60e91b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2333,14 +2333,13 @@ static struct symbol *evaluate_alignof(struct expression *expr)
 	return size_t_ctype;
 }
 
-static int evaluate_arguments(struct symbol *fn, struct expression_list *head)
+int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *head)
 {
 	struct expression *expr;
-	struct symbol_list *argument_types = fn->arguments;
 	struct symbol *argtype;
 	int i = 1;
 
-	PREPARE_PTR_LIST(argument_types, argtype);
+	PREPARE_PTR_LIST(argtypes, argtype);
 	FOR_EACH_PTR (head, expr) {
 		struct expression **p = THIS_ADDRESS(expr);
 		struct symbol *ctype, *target;
@@ -3149,7 +3148,7 @@ static struct symbol *evaluate_call(struct expression *expr)
 		if (!sym->op->args(expr))
 			return NULL;
 	} else {
-		if (!evaluate_arguments(ctype, arglist))
+		if (!evaluate_arguments(ctype->arguments, arglist))
 			return NULL;
 		args = expression_list_size(expr->args);
 		fnargs = symbol_list_size(ctype->arguments);
diff --git a/evaluate.h b/evaluate.h
index f68f7fb7c367..a16e97036b2a 100644
--- a/evaluate.h
+++ b/evaluate.h
@@ -2,6 +2,7 @@
 #define EVALUATE_H
 
 struct expression;
+struct expression_list;
 struct statement;
 struct symbol;
 struct symbol_list;
@@ -25,4 +26,10 @@ struct symbol *evaluate_statement(struct statement *stmt);
 // @list: the list of the symbol to be evaluated
 void evaluate_symbol_list(struct symbol_list *list);
 
+///
+// evaluate the arguments of a function
+// @argtypes: the list of the types in the prototype
+// @args: the list of the effective arguments
+int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *args);
+
 #endif
-- 
2.28.0

