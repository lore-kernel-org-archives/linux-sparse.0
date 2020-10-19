Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB141C43467
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810AA2225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT4F/jnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgJSQMj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgJSQMj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84BC0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so14650419ejd.13
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qN5yCGhvpsmG38TjTMXDiGRL63uwD0nbnF7j0HLcS/M=;
        b=XT4F/jnBnI8e6DUOdV0yyHDoZfduer+Osy+MwkoroLXvEMgI3Op73CXz4FZctCjREK
         GyFhszj3Lmymd/kywzscUqe9IuJhxhOhXcCKZSgR0rcdfKYIkmfEGbKYF5JaKY24BMkO
         QEOnLgpRrbtVFnobfdnjLos+dSih9aEAKMUvdEcRr3WFYNjam1PxKvBmP87JciJP3ZHR
         PwjocBOG+BcHlWUd6nnh/Ov39nJn1UeBDJNCIe7RSyIjVpnbmYc71oLFbO6rggpw4iap
         A2UpjsD0HqaWqpmLMXc2hF6PYovlcgxyFPKZhBRBNtps6cEg+BtcU9bZo6rUJAWA+YIg
         EeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qN5yCGhvpsmG38TjTMXDiGRL63uwD0nbnF7j0HLcS/M=;
        b=I2KEPNh23RAOaH993WCfS179O+jQ7sNthFzIry0Ip/dbsxhNG/emDXWDDFCg9z2iQF
         bRSpih1NwdiVHiw5oVyI78598Ww+VmFEivLJYaLc4c/1IYczp2p6jGalZhMIi7al3oRS
         KHgY+SCdUMOhmCVU1EzjfjAm9AZ1A1Cg345KY53zAXTmTwv3TgKc3sQ92JtxX/b2skFi
         uq43VFGlShSntGvyLCQvPn95Xdkw+/2kJfVbOGWtKmTmOKgkcl9JSEQk72FZ4efQKmov
         duMHU0Yi5Qen7wTUlFm/4e24moPc+6PBrFMfAPoegMrlJAL7zpmLg9Y5s519n/D+avmF
         ra1A==
X-Gm-Message-State: AOAM530WrL9gWOBgSJ6oW8yIYQlvmI7A1B1J2TguCIchP37VmT+EQthJ
        T7hFTGTGE94umXGoIRKyPZnyTtCKLJA=
X-Google-Smtp-Source: ABdhPJzJSmagA/7F3kl3f9w8IJp3lwCH0Rki1+XpLywmBTU56tD1pmz6YdxYMwShdG6Sm9otKszicw==
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr581960ejz.341.1603123957251;
        Mon, 19 Oct 2020 09:12:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 03/12] builtin: make eval_sync_compare_and_swap() more generic
Date:   Mon, 19 Oct 2020 18:12:17 +0200
Message-Id: <20201019161226.97429-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Most __sync_* or __atomic_* builtin functions have one or
more arguments having its real type determined by the first
argument: either the same type (a pointer to an integral type)
or the type of the object it points to.

Currently, only __sync_{bool,val}_compare_and_swap() are handled
but lots of very similar variants would be needed for the others.
So, make it a generic function, able to handle all these builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/builtin.c b/builtin.c
index 0d4cb12cca22..a1c925725942 100644
--- a/builtin.c
+++ b/builtin.c
@@ -31,6 +31,14 @@
 #include "compat/bswap.h"
 #include <stdarg.h>
 
+#define dyntype incomplete_ctype
+static bool is_dynamic_type(struct symbol *t)
+{
+	if (t->type == SYM_NODE)
+		t = t->ctype.base_type;
+	return t == &dyntype;
+}
+
 static int evaluate_to_int_const_expr(struct expression *expr)
 {
 	expr->ctype = &int_ctype;
@@ -362,29 +370,32 @@ static struct symbol_op overflow_p_op = {
 };
 
 
-static int eval_sync_compare_and_swap(struct expression *expr)
+static int eval_atomic_common(struct expression *expr)
 {
+	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
 	struct symbol_list *types = NULL;
 	struct symbol *ctype = NULL;
+	struct symbol *t;
 	struct expression *arg;
 	int n = 0;
 
-	/* the first arg is a pointer type; we'd already verified that */
+	// The number of arguments has already be verified.
+	// The first arg must be a pointer to an integral type.
+	PREPARE_PTR_LIST(fntype->arguments, t);
 	FOR_EACH_PTR(expr->args, arg) {
-		struct symbol *t = arg->ctype;
+		struct symbol *ptrtype = NULL;
 
-		if (!t)
-			return 0;
-
-		// 2nd & 3rd args must be a basic integer type or a pointer
-		// 1st arg must be a pointer to such a type.
 		if (++n == 1) {
+			t = arg->ctype;
+			if (!t)
+				return 0;
 			if (t->type == SYM_NODE)
 				t = t->ctype.base_type;
 			if (!t)
 				return 0;
 			if (t->type != SYM_PTR)
 				goto err;
+			ptrtype = t;
 			t = t->ctype.base_type;
 			if (!t)
 				return 0;
@@ -395,13 +406,16 @@ static int eval_sync_compare_and_swap(struct expression *expr)
 			if (t->type != SYM_PTR && t->ctype.base_type != &int_type)
 				goto err;
 			ctype = t;
-			add_ptr_list(&types, arg->ctype);
-		} else {
-			add_ptr_list(&types, ctype);
+			t = ptrtype;
+		} else if (is_dynamic_type(t)) {
+			t = ctype;
 		}
+		add_ptr_list(&types, t);
+		NEXT_PTR_LIST(t);
 	} END_FOR_EACH_PTR(arg);
+	FINISH_PTR_LIST(t);
 
-	if (!expr->ctype)	// __sync_val_compare_and_swap()
+	if (!expr->ctype)	// set the return type, if needed
 		expr->ctype = ctype;
 	return evaluate_arguments(types, expr->args);
 
@@ -412,9 +426,9 @@ err:
 	return 0;
 }
 
-static struct symbol_op sync_compare_and_swap_op = {
-	.args = args_triadic,
-	.evaluate = eval_sync_compare_and_swap,
+static struct symbol_op atomic_op = {
+	.args = args_prototype,
+	.evaluate = eval_atomic_common,
 };
 
 
@@ -464,6 +478,7 @@ static void declare_builtins(int stream, const struct builtin_fn tbl[])
 static const struct builtin_fn builtins_common[] = {
 #define size_t_ctype	&size_t_alias
 #define va_list_ctype	&ptr_ctype
+#define vol_ptr		&volatile_ptr_ctype
 	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
 	{ "__builtin_constant_p", NULL, 1, .op = &constant_p_op },
 	{ "__builtin_expect", &long_ctype, 0, { &long_ctype ,&long_ctype }, .op = &expect_op },
@@ -614,7 +629,7 @@ static const struct builtin_fn builtins_common[] = {
 
 	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { &ptr_ctype }, .op = &sync_compare_and_swap_op},
+	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op},
 	{ "__sync_fetch_and_add", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_fetch_and_and", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_fetch_and_nand", &int_ctype, 1, { &ptr_ctype }},
@@ -627,7 +642,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__sync_or_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_sub_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_synchronize", &void_ctype, 0 },
-	{ "__sync_val_compare_and_swap", NULL, 1, { &ptr_ctype }, .op = &sync_compare_and_swap_op },
+	{ "__sync_val_compare_and_swap", NULL, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op },
 	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 
 	{ }
-- 
2.28.0

