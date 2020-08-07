Return-Path: <SRS0=Te2Z=BR=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35821C433E0
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7C52177B
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt+N37/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHGUpR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgHGUpR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Aug 2020 16:45:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C0C061756
        for <linux-sparse@vger.kernel.org>; Fri,  7 Aug 2020 13:45:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id jp10so3407433ejb.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Aug 2020 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zditJLafGqMz5D3ZdhxncvEvlCYw1dXmwxaJvmelPTc=;
        b=jt+N37/bqgc3+TrDebBj2rXnGK0yaAKldWt1wlEx/Ajozrg/2hOCA8h/ngBU9t251E
         hF/abx0xJLi7ASvlMyOLnR5q6H3dM+iTfmojN7jl/YdrFEhFeY1XYfIILCUVOK2bKXsc
         AL14h6/Q/nzhnZ60vFt22jlt46o5wVZ6iA9a30bJ6N7gjOzz0DicTuouyixoFzOaT3P9
         sla1eFCC2JxeS4bxNJSiEeHrzDJrPwi5NL9R+oObPmU2frr4GmbUZtOiszUzi5WM5fE1
         ZgsaN4nI6xcU1B7q7Nk7gMnqQ6tWeE/F0aTXMNPj0wVp71pAfy50cq1iG3uQ4n47oRqd
         KM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zditJLafGqMz5D3ZdhxncvEvlCYw1dXmwxaJvmelPTc=;
        b=itgBJpNf/SUycDar1nY7nkxXIsWrciGCoBlzzHXOA5b+VtFgBPoiZ9KiooSWXndO5G
         ipOdn9Dn2PMIeRwJHRWzqI8mXX4hnE+WLoN+fA/8Sz20Z3OGekSeLZmWOmP7SpVeqYRV
         Qlfl7CnMttCp+0jeLeZFmFd+OwJWk7xAjUmyVoJ1fNj6uqRbxGwu+ARvFENAA4lQ7yB/
         YlXIxtSrFc+cQhyUPrmBTXsEwZG3z7ZHRoRTteb7KxM5qU1HfJCn6xGHFzPrZzJ+9Cj/
         zjrxOO1N7cwfLHVYUfswhZcz2D7XkjfKqbFBqFU/OZOHFhPC+TtBH/FAmfZXORLt+gpH
         LjKg==
X-Gm-Message-State: AOAM531mRODWFDhhO5v2kM012JWoJdHETTOlyp/hX9mTG2KUDyH/DtZ6
        rpHjzxc7W1dJXsa4OAE5emkr7afC
X-Google-Smtp-Source: ABdhPJw8vZX026ELWy83vXvupzubd6156bHR9ThTS4L7Bn8bwkoiL9zpZ/HkzOqpDcm29tWGpQypdQ==
X-Received: by 2002:a17:907:40bf:: with SMTP id nu23mr4749981ejb.243.1596833114409;
        Fri, 07 Aug 2020 13:45:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:8076:aed9:5a81:5448])
        by smtp.gmail.com with ESMTPSA id u4sm6120883edy.18.2020.08.07.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:45:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] add builtin support for __sync_{bool,val}_compare_and_swap()
Date:   Fri,  7 Aug 2020 22:45:06 +0200
Message-Id: <20200807204506.1100-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807204506.1100-1-luc.vanoostenryck@gmail.com>
References: <20200807204506.1100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In the kernel, the architecture s390 uses these builtins to
implement __atomic_cmpxchg() and friends. These builtins
are polymorphic, so they need some special evaluation.
These builtins are known to sparse but with a return type
of 'int' and the argument's types being ignored.

A problem occurs when used on a pointer type: the expected
type doesn't match 'int' and it can give warnings like:
	warning: non size-preserving integer to pointer cast

So, improve the support for these builtins by:
*) checking the number of arguments
*) extract the type from the 1st argument
*) set the returned type to this type if needed
*) finally, do the typechecking by calling evaluate_arguments()

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202008072005.Myrby1lg%25lkp@intel.com/
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                     | 60 +++++++++++++++++++++++++++++++++--
 validation/builtin-sync-cas.c |  1 -
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/builtin.c b/builtin.c
index f29b4a8d518c..2e9be8be8adb 100644
--- a/builtin.c
+++ b/builtin.c
@@ -355,6 +355,62 @@ static struct symbol_op overflow_p_op = {
 };
 
 
+static int eval_sync_compare_and_swap(struct expression *expr)
+{
+	struct symbol_list *types = NULL;
+	struct symbol *ctype = NULL;
+	struct expression *arg;
+	int n = 0;
+
+	/* the first arg is a pointer type; we'd already verified that */
+	FOR_EACH_PTR(expr->args, arg) {
+		struct symbol *t = arg->ctype;
+
+		if (!t)
+			return 0;
+
+		// 2nd & 3rd args must be a basic integer type or a pointer
+		// 1st arg must be a pointer to such a type.
+		if (++n == 1) {
+			if (t->type == SYM_NODE)
+				t = t->ctype.base_type;
+			if (!t)
+				return 0;
+			if (t->type != SYM_PTR)
+				goto err;
+			t = t->ctype.base_type;
+			if (!t)
+				return 0;
+			if (t->type == SYM_NODE)
+				t = t->ctype.base_type;
+			if (!t)
+				return 0;
+			if (t->type != SYM_PTR && t->ctype.base_type != &int_type)
+				goto err;
+			ctype = t;
+			add_ptr_list(&types, arg->ctype);
+		} else {
+			add_ptr_list(&types, ctype);
+		}
+	} END_FOR_EACH_PTR(arg);
+
+	if (!expr->ctype)	// __sync_val_compare_and_swap()
+		expr->ctype = ctype;
+	return evaluate_arguments(types, expr->args);
+
+err:
+	sparse_error(arg->pos, "invalid type for argument %d:", n);
+	info(arg->pos, "        %s", show_typename(arg->ctype));
+	expr->ctype = &bad_ctype;
+	return 0;
+}
+
+static struct symbol_op sync_compare_and_swap_op = {
+	.args = args_triadic,
+	.evaluate = eval_sync_compare_and_swap,
+};
+
+
 /*
  * Builtin functions
  */
@@ -548,7 +604,7 @@ static const struct builtin_fn builtins_common[] = {
 
 	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_bool_compare_and_swap", &int_ctype, 1, { &ptr_ctype }},
+	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { &ptr_ctype }, .op = &sync_compare_and_swap_op},
 	{ "__sync_fetch_and_add", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_fetch_and_and", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_fetch_and_nand", &int_ctype, 1, { &ptr_ctype }},
@@ -561,7 +617,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__sync_or_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_sub_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_synchronize", &void_ctype, 0 },
-	{ "__sync_val_compare_and_swap", &int_ctype, 1, { &ptr_ctype }},
+	{ "__sync_val_compare_and_swap", NULL, 1, { &ptr_ctype }, .op = &sync_compare_and_swap_op },
 	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 
 	{ }
diff --git a/validation/builtin-sync-cas.c b/validation/builtin-sync-cas.c
index e289eba2949b..846e21bb2fbb 100644
--- a/validation/builtin-sync-cas.c
+++ b/validation/builtin-sync-cas.c
@@ -16,7 +16,6 @@ static _Bool boz(_Bool *ptr)
 
 /*
  * check-name: builtin-sync-cas
- * check-known-to-fail
  *
  * check-error-start
 builtin-sync-cas.c:9:49: warning: incorrect type in argument 2 (different base types)
-- 
2.28.0

