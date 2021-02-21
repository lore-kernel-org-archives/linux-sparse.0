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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5CC433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C825064DF2
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhBUWSL (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhBUWSK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:18:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C5BC061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:17:30 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jt13so26255549ejb.0
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqdGmpIQnoERxU3rYryLAbC0i/zhwDPnWP6SzeaTjJ8=;
        b=TcDyr5paA9C9CTPJMvxLS4PXXJozppH/BmwImtaa+/n2QLhTRwxYpxE2s6JEGr+Ni0
         pVYhk8XGWrXxEgJukhipAGIruC4NmKTz/A3HheTCf2vNNeVDyFZvQ0p42SjVy5++29LC
         lgi8iSZrfLPB+gPU+hU2Jc5CJ5uVjTRKJuTBcR0fPCplnPfyvfZjwQuVPtGVrN8D7ft4
         0zyHaF08E6Ze0LXSLjfyQaLxa1oIKbsr2+sUyi1tSOYYM5r6IMEvnJS8a/aGwYZK+ba0
         5tioYJc53NgUAylUdRAubAJtNocdJOJVkPqD8NKRyHuyfkc7MbHn2H79Rbl63VzohFLL
         qw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqdGmpIQnoERxU3rYryLAbC0i/zhwDPnWP6SzeaTjJ8=;
        b=LooX6qSMl3VaqTeOatSHJQVxoDxP1CjPQWAR6UAYDsMVnZXTb4voY2mE0sE3RZmQnF
         nIEqUv8sEsDM5b2NJqq3UfWnhgs5yZBkKnKkE8JrZKYNo3TbHByvi0y/EHHCKtwQSr3g
         jqnmYTtXVZKUP+eiwOz1mx94K+B2zwHgUX3P6bclH4CxlsYuhbbK4coMALS+uJs/Wd5H
         CXNd+Nt4alfmZjJI+lZbDatH8nda/EfGMYDUmZKkgJK8uYTxSRabunWe5XSX5G+yD41l
         sRnJK1KSLGSh9SvE4XX9wDc4mJAbj/FUIwfNuK86bPvMVbqw/r6tiLQgKi05PrfMGVBj
         LVWg==
X-Gm-Message-State: AOAM533nluFd7AVELGKNYRk6QRqxWT1/PM6G92d7UcgpaPz9Y8v5pOlT
        1DXbZcShYp+qE4TAPs5YkM21zCzpX/U=
X-Google-Smtp-Source: ABdhPJzvfWkO8mraRgV4GWr+XQGlfSq3Ewue2KyXho6G1IdxoM84Bm//ML1zhqwjre/VZ7BkMDE3zQ==
X-Received: by 2002:a17:906:c051:: with SMTP id bm17mr17826175ejb.493.1613945848727;
        Sun, 21 Feb 2021 14:17:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id q16sm8992705ejd.39.2021.02.21.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:17:27 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] expand __builtin_object_size()
Date:   Sun, 21 Feb 2021 23:17:23 +0100
Message-Id: <20210221221723.7868-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

__builtin_object_size() is one of these builtins that must be
somehow expanded because it can't possibly be implemented at
runtime. It's used by the kernel's copy_{to,from}_user() and
the 'fortified' string functions, as well as by userspace's
'checked string/memory functions' like __builtin___memcpy_chk().

So, use the normal builtin expansion interface for this one too.
This gets rid of 2/3 of them when used on the kernel and shaves
~0.5% of the total IR code (with x86's defconfig).

Notes:
1) What is covered is an object symbol, with an optional designator
   of arbitrary complexity, ignoring casts and accessed via
   an optional chain of simple dereferences. Maybe some access
   path need to be added.
2) Anything with dynamic value is currently considered as unknown.
   For example VLAs or dynamically allocated memory (attribute
   alloc_size() is not supported).
3) It's not totally clear to me when to give up (and thus return
   'size unknown') and when things can or must be left to the
   simplification phase. This matters because __builtin_object_size()
   is relatively often used with __builtin_constant_p().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 ptrlist.h |  4 ++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index 5c7321cad3e4..38cd7b847860 100644
--- a/builtin.c
+++ b/builtin.c
@@ -454,6 +454,73 @@ static struct symbol_op atomic_op = {
 };
 
 
+static int expand_object_size(struct expression *expr, int cost)
+{
+	struct expression *arg = first_expression(expr->args);
+	int type = get_expression_value_silent(ptr_list_nth(expr->args, 1));
+	unsigned long val = -1, off = 0;
+
+	// Note: type 1 and type 3 are not supported because
+	// they can't be done after convert_designators().
+	if (type & 1)
+		return UNSAFE;
+
+	while (arg) {
+		switch (arg->type) {
+		case EXPR_IMPLIED_CAST:
+		case EXPR_CAST:
+			// ignore those
+			arg = arg->cast_expression;
+			continue;
+		case EXPR_BINOP:
+			// a constant add is (maybe) an offset
+			if (!arg->right || arg->op != '+' || arg->right->type != EXPR_VALUE)
+				break;
+			off += arg->right->value;
+			arg = arg->left;
+			continue;
+		case EXPR_PREOP:
+			// a deref is just intermediate variable
+			// and so the offset needs to be zeroed.
+			if (arg->op == '*') {
+				arg = arg->unop;
+				off = 0;
+				switch (arg->type) {
+				case EXPR_SYMBOL:
+					arg = arg->symbol->initializer;
+					continue;
+				default:
+					break;
+				}
+			}
+			break;
+		case EXPR_SYMBOL:
+			// the symbol we'e looking after
+			val = bits_to_bytes(arg->symbol->bit_size);
+			break;
+		case EXPR_CALL:
+			// use alloc_size() attribute but only after linearization.
+			return UNSAFE;
+		default:
+			break;
+		}
+		break;
+	}
+
+	if (val == -1)
+		return UNSAFE;
+
+	expr->flags |= CEF_SET_ICE;
+	expr->type = EXPR_VALUE;
+	expr->value = val;
+	expr->taint = 0;
+	return cost;
+}
+
+static struct symbol_op object_size_op = {
+	.expand = expand_object_size,
+};
+
 /*
  * Builtin functions
  */
@@ -598,7 +665,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__builtin_nan", &double_ctype, 0, { &const_string_ctype }},
 	{ "__builtin_nanf", &float_ctype, 0, { &const_string_ctype }},
 	{ "__builtin_nanl", &ldouble_ctype, 0, { &const_string_ctype }},
-	{ "__builtin_object_size", size_t_ctype, 0, { &const_ptr_ctype, &int_ctype }},
+	{ "__builtin_object_size", size_t_ctype, 0, { &const_ptr_ctype, &int_ctype }, .op = &object_size_op},
 	{ "__builtin_parity", &int_ctype, 0, { &uint_ctype }, .op = &parity_op },
 	{ "__builtin_parityl", &int_ctype, 0, { &ulong_ctype }, .op = &parity_op },
 	{ "__builtin_parityll", &int_ctype, 0, { &ullong_ctype }, .op = &parity_op },
diff --git a/ptrlist.h b/ptrlist.h
index 4bf8c709ac08..c5fa4cdd94cb 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -73,6 +73,10 @@ extern void __free_ptr_list(struct ptr_list **);
 		__free_ptr_list((struct ptr_list **)(list));		\
 	} while (0)
 
+#define ptr_list_nth(lst, nth) ({					\
+		struct ptr_list* head = (struct ptr_list*)(lst);	\
+		(__typeof__((lst)->list[0])) ptr_list_nth_entry(head, nth);\
+	})
 
 ////////////////////////////////////////////////////////////////////////
 // API
-- 
2.30.0

