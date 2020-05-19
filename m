Return-Path: <SRS0=O/Ee=7B=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB269C433E0
	for <linux-sparse@archiver.kernel.org>; Tue, 19 May 2020 00:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B77720674
	for <linux-sparse@archiver.kernel.org>; Tue, 19 May 2020 00:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZUhU3Gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgESA5s (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 18 May 2020 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C823C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so10368319ejd.8
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4vym3m30bXrDqT8nFaLYfKbXkGFM2zXixe1XrD0pyU=;
        b=pZUhU3GtibK7qtP49ZNjpGo1yBQSpNM1u0ZDuRV+Lnt7IqPi/TIp9edySZkOl02d5x
         dSZnFGIvUMQMaxM2t2Ea2MJhLCdDfz4zSmLH1iQkyMg0fYk3nu3YGfPIb+CjPpT022R8
         lD/Uii9+QDWHnVxsybZjJL27kxEYTO+Hcikp/IJ4mbYKhYzUBHSji71EKwyVEKIVh/y/
         9RCfryKf2Qy75ZIO7zpr42ISPaZR3R6jnpkXwrUPb66hXvxX7By75Dy7ZYMSApwRuNS6
         2kNbOaSwaJAnmPGpHZ8m0K8WsVEP4KlkdqKzDgHbtlk2O4ENa2If6Z4q5YS9VVw9CqAc
         b/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4vym3m30bXrDqT8nFaLYfKbXkGFM2zXixe1XrD0pyU=;
        b=lzz8kpekRaYxe6dInlmOevC2sg6hmVJrNYtrttNa6MiFHs6+COQZAJXoCx28aRDzUf
         kVK2z7kkezfqXeOiBsvoYqaJ52cDzkrvsttmaPZO0j8Lo93/1C2Uyfa51x/sybNQ1dut
         QoL0vbYdghq7SPRy94SEMUQX6iYK5iUYdah+Y4K2J42dBA4G2CbgbSUFFHRomkTgIJPF
         D4EeVG6/0xMJQe+ZVi0JxATvoAI3cJkcDACBeWbIt+KWg3ndSSECf7Tb+8eflYg0WAG2
         eGTzG2IDbZ3yf+lUDUWVxfmCHPwDCLRP3HI78BDkDMbUVHFyQ84LZbZHiWjCzlejpIPq
         Imrg==
X-Gm-Message-State: AOAM532R/gb405hITuhxyVUPYrFO7r4ID1alazdY/0fqKL9r5efeQtRi
        ReKQ4Xut2iACFm+K3bbVRJFrIkZt
X-Google-Smtp-Source: ABdhPJx4K0NPPFuvADRLBwR1nX6djcWfYPkou5k7EAQbPX9wG3EfiMxwPYRN5fbRCkTfpsCe02NIbQ==
X-Received: by 2002:a17:906:584e:: with SMTP id h14mr16724943ejs.257.1589849865918;
        Mon, 18 May 2020 17:57:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:98be:2081:4f7:29e4])
        by smtp.gmail.com with ESMTPSA id h25sm702737ejx.7.2020.05.18.17.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 17:57:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 13/28] scope: move scope opening/ending inside compound_statement()
Date:   Tue, 19 May 2020 02:57:13 +0200
Message-ID: <20200519005728.84594-14-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200519005713.AW3HlK7jTkr1lxO2m9jcAfss8_5W5oGJaV01QzJuaeA@z>

A compound statement starts and ends a block scope, so
it's better to start & end this scope inside the function
parsing the statement: compound_statement.
The only exception is for the body of a function where
the scope also enclose the parameter declaration but that
is fine since the function is special anyway.

Move the calls to start & close the block scope inside
compound_statement() and directly call statement_list()
for the function body.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c |  2 --
 parse.c      | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/expression.c b/expression.c
index 5b9bddfe456e..78e577cf10a1 100644
--- a/expression.c
+++ b/expression.c
@@ -71,9 +71,7 @@ struct token *parens_expression(struct token *token, struct expression **expr, c
 		struct statement *stmt = alloc_statement(token->pos, STMT_COMPOUND);
 		*expr = e;
 		e->statement = stmt;
-		start_symbol_scope();
 		token = compound_statement(token->next, stmt);
-		end_symbol_scope();
 		token = expect(token, '}', "at end of statement expression");
 	} else
 		token = parse_expression(token, expr);
diff --git a/parse.c b/parse.c
index 9e7b74f98638..e23c5b64e8be 100644
--- a/parse.c
+++ b/parse.c
@@ -2555,11 +2555,7 @@ static struct token *statement(struct token *token, struct statement **tree)
 	}
 
 	if (match_op(token, '{')) {
-		stmt->type = STMT_COMPOUND;
-		start_symbol_scope();
 		token = compound_statement(token->next, stmt);
-		end_symbol_scope();
-		
 		return expect(token, '}', "at end of compound statement");
 	}
 			
@@ -2666,7 +2662,10 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 
 struct token *compound_statement(struct token *token, struct statement *stmt)
 {
+	stmt->type = STMT_COMPOUND;
+	start_symbol_scope();
 	token = statement_list(token, &stmt->stmts);
+	end_symbol_scope();
 	return token;
 }
 
@@ -2818,15 +2817,15 @@ static struct token *parse_function_body(struct token *token, struct symbol *dec
 		decl->ctype.modifiers |= MOD_EXTERN;
 
 	stmt = start_function(decl);
-
 	*p = stmt;
+
 	FOR_EACH_PTR (base_type->arguments, arg) {
 		declare_argument(arg, base_type);
 	} END_FOR_EACH_PTR(arg);
 
-	token = compound_statement(token->next, stmt);
-
+	token = statement_list(token->next, &stmt->stmts);
 	end_function(decl);
+
 	if (!(decl->ctype.modifiers & MOD_INLINE))
 		add_symbol(list, decl);
 	check_declaration(decl);
-- 
2.26.2

