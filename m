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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD20C433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4C561028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhDJNbM (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhDJNbJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D45C061762
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sd23so4252977ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXBP0BK4rvrYi98UKOMLaLbLxhBUv2Q9UXrRM1XKjNs=;
        b=O3naIuZ0RD+d3n5ncJ0CSATT/IrGXqm02hnx8RU2KxKZaq+Huh1wgCIG+zUMZkX16d
         qPzhfEn6O1IlApqV7hyKMu+VKvhvaQfLLo0Me8wvJ6SXPwfSZ50OSAHwgE/8E4IRq3rc
         i580TS/B153LPK1CiHYUjX2k7/UtCfNz075wzscipGb5GNbnbM7RAMhk3+OFmhe04Is6
         k247osq6NkfPzSwEUCznBJTjPY6hel+xy/tmsvWcvHSvC8NBi2CVvaSpnSO1TE6Vfqn6
         kMrFz5KvGKbC+qvLZ9nK5393dzqSo4ntJrGxvXpgIbVOtwmjOTp9lO+rkcP4HwbahH8Y
         iG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXBP0BK4rvrYi98UKOMLaLbLxhBUv2Q9UXrRM1XKjNs=;
        b=dAXtkLqF5RS+bbTHiogLbVnk+Ju3VXLXWA9u/1iTbpb7W9cm6bwZStaQd7bRRymIh9
         J2hg2i/f2WNdJpRXopEyyBSSHAVR/9dQizm9zPi7IA3lRfXhFApnRYXbC30PLB6S4MfY
         QSJosMC+JAFYKtzBBWBfsZlLV7U2UM7h4d9KJ6oUrYzlhwLM0fSDejX0pZxL7HQwsXvh
         d+oLoddJazgwOg690n+StCI1n+eo55zxH0gkZIvdYR0AQGsxbBBk0Iku0vVTihS3Y5XW
         l/68UGnYGd0txpqCC6scenvhb5yE8CBc0RlIX3qPJRvFJE9cOKPKfx7KHQUoeATprrjy
         tziA==
X-Gm-Message-State: AOAM532BjKat4qfvg1DB9Wiutjuu4cFYAmmeT5lD8Hf0QQdcnWA7K8xs
        o+FQ9dvS+sSSpad/JBO7jsSRkEgL/9o=
X-Google-Smtp-Source: ABdhPJxG9dYt9AZJDtXD8nR822k9VqYmWjHqYq+iDyXBjXtTmqaHnUS6RpYRBFI0MiWX2GR162sKFA==
X-Received: by 2002:a17:906:37da:: with SMTP id o26mr672788ejc.413.1618061453306;
        Sat, 10 Apr 2021 06:30:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:52 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] builtin: define a symbol_op for a generic op acting on integer
Date:   Sat, 10 Apr 2021 15:30:39 +0200
Message-Id: <20210410133045.53189-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This can be used to define some generic (polymorphic) builtin
with a signature like:
	op(T)
	op(T, T)
	op(T,T, ... T)
where T is some integer type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/builtin.c b/builtin.c
index ff03dbab9a06..f03bf109c818 100644
--- a/builtin.c
+++ b/builtin.c
@@ -390,6 +390,56 @@ static struct symbol_op overflow_p_op = {
 };
 
 
+///
+// Evaluate the arguments of 'generic' integer operators.
+//
+// All arguments must be the same basic integer type and
+// their number comes from the prototype and is already checked.
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
+		struct symbol *type;
+
+		if (++n == 1) {
+			t = arg->ctype;
+			if (!arg || !(type = arg->ctype))
+				return 0;
+			if (type->type == SYM_NODE)
+				type = type->ctype.base_type;
+			if (!type)
+				return 0;
+			if (type->ctype.base_type != &int_type || type == &bool_ctype)
+				goto err;
+		} else {
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

