Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8CEC433ED
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F53E6135C
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbhDLVVn (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbhDLVVl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BCDC061574
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v6so21322748ejo.6
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6x5qFu2A5sg0AfaOENDQ6CDYdDY/tuVTs61SwYKy2Tg=;
        b=VjcsCTCiw1X8Lp5thqw3IScZMLOE8WFyaVHh6p0rRP6976N8+FVkdI7bgweaKGvOTi
         aPjl47V4ho6xgZyZ/x4HCI518oBL/Bkzt6bBsxrYJK5vzpg/HXjzMuig0HiDClU3u35U
         yOpCgP6MOgaJa/3YdIOA7aNfPlpFmN1ezAnJlTUjmd6RwJLQyhYRqAQ+NwenU+Z6Tg0q
         x5DWJqf1LlOwNjd39wDVWIGEgO/KP/Se2aPw3HW3aBrhBXRsb8Hn9KDO5uVMADYt5fNR
         DRMyEjGKDRBVEdvbA3bl7U1tQDoITu2kRQmr4i8e29zvc6M7plk+gKJPcj42JTK+qKuU
         XlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6x5qFu2A5sg0AfaOENDQ6CDYdDY/tuVTs61SwYKy2Tg=;
        b=brcADKoaKHhNDiVwEPDwkoTsJqmjbBd7Koa9lt4NAQod875YlMzun0FSDEh6QrWFUd
         JuO4T3vHdjZ0GL5QZcd4iNmDxD8tTgU5+AqXc7gQ56D5RG21Glx6Q6AWRsKc1++oOc8w
         3AFTmynznnVlE+0sFXOrCkHCu8tKmGvCuQebCWD3FhjBG/T4V7XwAfKYZTrDl4L9yJnu
         R4Cxed8kAmiZZWNdsXab5LDSfMMs9cjeI6RVUsSuhiZdSCuTUY/GdvC1bDP0OTTehOiB
         BGerZtw5yoKO3G3vhHlV6rFWz+/49+At3FC7mDJZIn2mxzXfx79aCjktCAREPIwurelK
         DUUw==
X-Gm-Message-State: AOAM531euxweaecVW+0bOSYLNi+qTO3WFKKMgBT67D49Qui3ZE/GP5ss
        81yBebH6NBOVOoFflxZpjNYP96QMYzE=
X-Google-Smtp-Source: ABdhPJzEsD9dzSc79wsP2nI83gtMtIMujCviwqiLlT2DH8aYOLEAplZpY0oNlD2u8ORbpt/tui647g==
X-Received: by 2002:a17:906:7795:: with SMTP id s21mr14350877ejm.309.1618262481775;
        Mon, 12 Apr 2021 14:21:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:21 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/8] builtin: define a symbol_op for a generic op acting on integer
Date:   Mon, 12 Apr 2021 23:21:05 +0200
Message-Id: <20210412212111.29186-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This can be used to define some generic (polymorphic) builtin
with a signature like:
	<name>(int)
	<name>(T, T)
	<name>(int, T)
	<name>(int, T, long, T, ... T)
where T is some integer type which will be instantiated at each call.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h |  2 ++
 2 files changed, 63 insertions(+)

diff --git a/builtin.c b/builtin.c
index ff03dbab9a06..928e03050375 100644
--- a/builtin.c
+++ b/builtin.c
@@ -390,6 +390,67 @@ static struct symbol_op overflow_p_op = {
 };
 
 
+///
+// Evaluate the arguments of 'generic' integer operators.
+//
+// Parameters with a complete type are used like in a normal prototype.
+// The first parameter with a 'dynamic' type will be consider
+// as polymorphic and for each calls will be instancied with the type
+// of its effective argument.
+// The next dynamic parameters will the use this polymorphic type.
+// This allows to declare functions with some parameters having
+// a type variably defined at call time:
+//	int foo(int, T, T);
+static int evaluate_generic_int_op(struct expression *expr)
+{
+	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
+	struct symbol_list *types = NULL;
+	struct symbol *ctype = NULL;
+	struct expression *arg;
+	struct symbol *t;
+	int n = 0;
+
+	PREPARE_PTR_LIST(fntype->arguments, t);
+	FOR_EACH_PTR(expr->args, arg) {
+		if (!is_dynamic_type(t)) {
+			;
+		} else if (!ctype) {
+			// fist 'dynamic' type, chat that it is an integer
+			t = arg->ctype;
+			if (!t)
+				return 0;
+			if (t->type == SYM_NODE)
+				t = t->ctype.base_type;
+			if (!t)
+				return 0;
+			if (t->ctype.base_type != &int_type)
+				goto err;
+
+			// next 'dynamic' arguments will use this type
+			ctype = t;
+		} else {
+			// use the previous 'dynamic' type
+			t = ctype;
+		}
+		add_ptr_list(&types, t);
+		NEXT_PTR_LIST(t);
+	} END_FOR_EACH_PTR(arg);
+	FINISH_PTR_LIST(t);
+	return evaluate_arguments(types, expr->args);
+
+err:
+	sparse_error(arg->pos, "non-integer type for argument %d:", n);
+	info(arg->pos, "        %s", show_typename(arg->ctype));
+	expr->ctype = &bad_ctype;
+	return 0;
+}
+
+struct symbol_op generic_int_op = {
+	.args = args_prototype,
+	.evaluate = evaluate_generic_int_op,
+};
+
+
 static int eval_atomic_common(struct expression *expr)
 {
 	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
diff --git a/builtin.h b/builtin.h
index 9cb6728444fe..5fe77c926244 100644
--- a/builtin.h
+++ b/builtin.h
@@ -14,4 +14,6 @@ struct builtin_fn {
 
 void declare_builtins(int stream, const struct builtin_fn tbl[]);
 
+extern struct symbol_op generic_int_op;
+
 #endif
-- 
2.31.1

