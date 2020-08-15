Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B553C433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6891820639
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlhe7Qey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgHOVvZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgHOVvY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EA7C09B049
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so12977634ejx.6
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vvEvB/Rt/gQET+Q2V8zco3STgeZML4cIwynYccYaRA=;
        b=Wlhe7QeyCDFfPQmJSiNAe7ro3yMmjkjZwNbo2n1E0RkL/DDrwp+vOdzxqLs/wy0FPQ
         5KofllQcQvg9SsOs7Pd1Gd55XGbNlaaq85yrbUl0//a/h4XVkCqGTg5qhFFaXqzOkwMY
         hMkaP7RWWWSmMVPUS10A47fo5DXIS6KxbWoQD14mSa6at3XKM88PtpUFZ0W4mZ+D+Q67
         BS+ud2jtnyd1m9UfNxwQHWA2GCLgxn50RaxrghOceOTxcqVFpLmUNtWTmuFuu4bbcKlf
         2gC92giiKbcQ5eRKDbK8dMmCEKXA2Mt1Sq4pO/AZ6jKfgJL7PfT4IBZNxmHcXwGbMR1h
         lLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vvEvB/Rt/gQET+Q2V8zco3STgeZML4cIwynYccYaRA=;
        b=rQpC49SGA+hpUiFLM0E6fAi2HfF6ANZCvX1qz0tIFn93hRN4ic8yaT0v3dYvtnu8pv
         u2Mz5ojdZDSW7XDpdzwFZQlgvmihPPFpXGpR/uBAB91D0onzFmCTEq/3rU94KD+heJRd
         hGWusAFecFjEQl72AGG+KyqQQGoupnVBGxkfqhkl/+saqLfl170m26/HddswSW/8wj97
         +lHjVS2RlBuVY5oyJeGI5A6aNGtJ58jYVqmOtyImR7J3Vk+U1S6DMbCCnnbff17hMPpw
         q/llHc0/Mqg3mS2m9cTCzn+vSkIdAFiEmVOO1U7SoSw7r1uEvBAeddaxpDdomCrFBYOx
         K4aw==
X-Gm-Message-State: AOAM532xSnbpuyYuJnzFo9gRMe7ZmewzWTegoklgr6cWzIufF/D/xMNB
        +cER2216701hxzvyL2EKiLrfjTRJMc0=
X-Google-Smtp-Source: ABdhPJxNOsPQrm+1InnK5CsOF+g2EYG233LvZWnd9veNj9Vgp3jZg600ZDqBHT7nyUOxlIW4FkszqQ==
X-Received: by 2002:a17:906:a201:: with SMTP id r1mr7284120ejy.432.1597505291945;
        Sat, 15 Aug 2020 08:28:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:9042:5c68:7405:68b0])
        by smtp.gmail.com with ESMTPSA id o7sm9065091edq.53.2020.08.15.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 08:28:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] union-cast: teach sparse about union casts
Date:   Sat, 15 Aug 2020 17:28:03 +0200
Message-Id: <20200815152803.2788-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200815152803.2788-1-luc.vanoostenryck@gmail.com>
References: <20200815152803.2788-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Casts to union type are a GCC extension and are similar to
compound literals.

However, sparse doesn't know about them and treats them like
other casts to non-scalars.

So, teach sparse about them, convert them to the corresponding
compound literal and add a warning flag to enable/disable the
associated warning: -W[no-]union-cast.

Note: a difference between union casts and compound literals
      is that the union casts yield rvalues while compound
      literals are lvalues but this distinction is not yet done
      in this series.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/release-notes/v0.6.3.rst |  5 +++
 evaluate.c                             | 47 +++++++++++++++++++++++++-
 options.c                              |  2 ++
 options.h                              |  1 +
 sparse.1                               |  6 ++++
 validation/eval/union-cast-no.c        |  1 -
 validation/eval/union-cast.c           |  1 -
 7 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/Documentation/release-notes/v0.6.3.rst b/Documentation/release-notes/v0.6.3.rst
new file mode 100644
index 000000000000..1aae742e42de
--- /dev/null
+++ b/Documentation/release-notes/v0.6.3.rst
@@ -0,0 +1,5 @@
+v0.6.3 (2020-xx-xy)
+===================
+
+* Changes in warnings:
+    "warning: cast to union type" [disable with -Wno-union-cast]
diff --git a/evaluate.c b/evaluate.c
index 0563be939f23..847137250d05 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2948,6 +2948,26 @@ static int cast_flags(struct expression *expr, struct expression *old)
 	return flags;
 }
 
+///
+// check if a type matches one of the members of a union type
+// @utype: the union type
+// @type: to type to check
+// @return: to identifier of the matching type in the union.
+static struct symbol *find_member_type(struct symbol *utype, struct symbol *type)
+{
+	struct symbol *t, *member;
+
+	if (utype->type != SYM_UNION)
+		return NULL;
+
+	FOR_EACH_PTR(utype->symbol_list, member) {
+		classify_type(member, &t);
+		if (type == t)
+			return member;
+	} END_FOR_EACH_PTR(member);
+	return NULL;
+}
+
 static struct symbol *evaluate_compound_literal(struct expression *expr, struct expression *source)
 {
 	struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
@@ -2973,6 +2993,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	struct expression *source = expr->cast_expression;
 	struct symbol *ctype;
 	struct symbol *ttype, *stype;
+	struct symbol *member;
 	int tclass, sclass;
 	struct ident *tas = NULL, *sas = NULL;
 
@@ -3022,8 +3043,32 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	if (expr->type == EXPR_FORCE_CAST)
 		goto out;
 
-	if (tclass & (TYPE_COMPOUND | TYPE_FN))
+	if (tclass & (TYPE_COMPOUND | TYPE_FN)) {
+		/*
+		 * Special case: cast to union type (GCC extension)
+		 * The effect is similar to a compound literal except
+		 * that the result is a rvalue.
+		 */
+		if ((member = find_member_type(ttype, stype))) {
+			struct expression *item, *init;
+
+			if (Wunion_cast)
+				warning(expr->pos, "cast to union type");
+
+			item = alloc_expression(source->pos, EXPR_IDENTIFIER);
+			item->expr_ident = member->ident;
+			item->ident_expression = source;
+
+			init = alloc_expression(source->pos, EXPR_INITIALIZER);
+			add_expression(&init->expr_list, item);
+
+			// FIXME: this should be a rvalue
+			evaluate_compound_literal(expr, init);
+			return ctype;
+		}
+
 		warning(expr->pos, "cast to non-scalar");
+	}
 
 	if (sclass & TYPE_COMPOUND)
 		warning(expr->pos, "cast from non-scalar");
diff --git a/options.c b/options.c
index f7e81b84d749..b25f715042f8 100644
--- a/options.c
+++ b/options.c
@@ -129,6 +129,7 @@ int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
+int Wunion_cast = 0;
 int Wuniversal_initializer = 0;
 int Wunknown_attribute = 0;
 int Wvla = 1;
@@ -866,6 +867,7 @@ static const struct flag warnings[] = {
 	{ "typesign", &Wtypesign },
 	{ "undef", &Wundef },
 	{ "uninitialized", &Wuninitialized },
+	{ "union-cast", &Wunion_cast },
 	{ "universal-initializer", &Wuniversal_initializer },
 	{ "unknown-attribute", &Wunknown_attribute },
 	{ "vla", &Wvla },
diff --git a/options.h b/options.h
index 070c0dd87183..40945e287a4a 100644
--- a/options.h
+++ b/options.h
@@ -128,6 +128,7 @@ extern int Wtransparent_union;
 extern int Wtypesign;
 extern int Wundef;
 extern int Wuninitialized;
+extern int Wunion_cast;
 extern int Wuniversal_initializer;
 extern int Wunknown_attribute;
 extern int Wvla;
diff --git a/sparse.1 b/sparse.1
index 60203d5a6463..fecd6dd90d42 100644
--- a/sparse.1
+++ b/sparse.1
@@ -451,6 +451,12 @@ The concerned warnings are, for example, those triggered by
 Sparse does not issue these warnings by default, processing '{\ 0\ }'
 the same as '{\ }'.
 .
+.TP
+.B -Wunion-cast
+Warn on casts to union types.
+
+Sparse does not issues these warnings by default.
+.
 .SH MISC OPTIONS
 .TP
 .B \-\-arch=\fIARCH\fR
diff --git a/validation/eval/union-cast-no.c b/validation/eval/union-cast-no.c
index d06b348d209e..6ba38db8e3f3 100644
--- a/validation/eval/union-cast-no.c
+++ b/validation/eval/union-cast-no.c
@@ -16,7 +16,6 @@ static union u bar(long l)
 /*
  * check-name: union-cast-no
  * check-command: sparse -Wno-union-cast $file
- * check-known-to-fail
  *
  * check-error-start
 eval/union-cast-no.c:13:17: warning: cast to non-scalar
diff --git a/validation/eval/union-cast.c b/validation/eval/union-cast.c
index 1d8167531081..5bee9e0dc705 100644
--- a/validation/eval/union-cast.c
+++ b/validation/eval/union-cast.c
@@ -16,7 +16,6 @@ static union u bar(long a)
 /*
  * check-name: union-cast
  * check-command: sparse -Wunion-cast $file
- * check-known-to-fail
  *
  * check-error-start
 eval/union-cast.c:8:17: warning: cast to union type
-- 
2.28.0

