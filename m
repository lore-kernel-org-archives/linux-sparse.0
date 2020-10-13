Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED1C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A722054F
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeBUsn8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgJNJWj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbgJNJU6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F2BC08E8AE
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:53 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x7so2134365eje.8
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8QmiRwirVDp6HKcCgLC7vxyr7WnRgng5guQ9sgP90Q=;
        b=IeBUsn8IZvGUtuVPcdB/8v9VRpXtgRGOdgnbajemnDLKZ8cgPxUNMkQXTyTjJptWSa
         GzoOMaswE0rFcPUDVlYVqxxABSzpRmcC6nnN6jP3lpSjylnaz55r3Mu7eAhl8es4Q/Dd
         uLAXCT7kYrVqTR/7TnwE94rqRwRrtueFfnIw7xo5z/xC3K2RMUvYkIRHCf/HEbiT0AJq
         raFTe2e9O3/wLvu4A9sljReJEIT0v0jcz/3ZjI4o7B1uVVATyWtSeJOyfh9ei6x/4JD5
         UHYvuRPqfX7VsCSg+KyJvRVIl8+8F9fm5y/c3Sji3vSZh4f5P/6jsy6cDJBP4UnUgLgc
         nYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8QmiRwirVDp6HKcCgLC7vxyr7WnRgng5guQ9sgP90Q=;
        b=J/XjiYTQ1Q/bsh/6VjMoy5POUvwNfrSWrmkr6V7SJYPJuR0NvZhzNsLMwNrUdMv1NP
         jckaf01/8IWUWHL76VTaWEThiAKZe7oWSt4s9cB/CBx91XOQFCm7+fnprI3qv4S5X5u2
         X85kDrrT/MYsAzqnAo1OYRmYRSOcK4bSy5so82breBw+H+yZdIYr3BnJABdP66SGPAjE
         sRH7//egc/yBp4r9qQm6LXgsKoFC2Px9VS7mrEnOh8vyJrYD/d6D4u9WG3geItp+0VKH
         dZolhklr6um4pXa0ifYgEdkNFGgmp30x/XINLRJfBsKc9227MdeinfsXr1qZH7f++IXE
         zCRg==
X-Gm-Message-State: AOAM530/9WTbRbj/js7yz0uNIOXxrB1Fo0+++XGLJkb26b4g4Du9VBpd
        jQ2zq0tNKvSUlrzFfz0h7BiTEhQXCO0=
X-Google-Smtp-Source: ABdhPJyK8tb7mSayJRzxoHqX3/X1D7Hfni0c9xb16zR77WmE7CihcZYT06s30oaxMmUiyjxZmCHOKQ==
X-Received: by 2002:a17:906:a988:: with SMTP id jr8mr2269739ejb.508.1602631371616;
        Tue, 13 Oct 2020 16:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/13] format-check: remove wrappers around type checking methods
Date:   Wed, 14 Oct 2020 01:22:30 +0200
Message-Id: <20201013232231.10349-13-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that all types have their own checking functions, the
signature of the methods can be simplified and the wrappers
removed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 86 +++++++------------------------------------------
 1 file changed, 12 insertions(+), 74 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index fdfe9c22e858..753e59c167ce 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -54,10 +54,7 @@ enum length_mod {
 
 struct format_type {
 	const char	*format;
-	int		(*test)(struct format_type *fmt,
-				struct expression **expr,
-				struct symbol *ctype,
-				const char **typediff);
+	const char*	(*test)(struct format_type *fmt, struct symbol *source);
 	struct symbol	*type;
 };
 
@@ -149,27 +146,11 @@ static const char *check_printf_sint(struct format_type *fmt, struct symbol *sou
 	return check_printf_int(fmt, source, 1);
 }
 
-static int printf_fmt_sint(struct format_type *fmt,
-			      struct expression **expr,
-			      struct symbol *ctype,
-			      const char **typediff)
-{
-	return !(*typediff = check_printf_sint(fmt, ctype));
-}
-
 static const char *check_printf_uint(struct format_type *fmt, struct symbol *source)
 {
 	return check_printf_int(fmt, source, 0);
 }
 
-static int printf_fmt_uint(struct format_type *fmt,
-			      struct expression **expr,
-			      struct symbol *ctype,
-			      const char **typediff)
-{
-	return !(*typediff = check_printf_uint(fmt, ctype));
-}
-
 static const char *check_printf_float(struct format_type *fmt, struct symbol *source)
 {
 	const char *typediff = "different base types";
@@ -183,14 +164,6 @@ static const char *check_printf_float(struct format_type *fmt, struct symbol *so
 	return typediff;
 }
 
-static int printf_fmt_float(struct format_type *fmt,
-			      struct expression **expr,
-			      struct symbol *ctype,
-			      const char **typediff)
-{
-	return !(*typediff = check_printf_float(fmt, ctype));
-}
-
 // For 's' & 'S' specifiers
 static const char *check_printf_string(struct format_type *fmt, struct symbol *source)
 {
@@ -223,15 +196,6 @@ static const char *check_printf_string(struct format_type *fmt, struct symbol *s
 	return typediff;
 }
 
-static int printf_fmt_string(struct format_type *fmt,
-			     struct expression **expr,
-			     struct symbol *ctype,
-			     const char **typediff)
-{
-	return !(*typediff = check_printf_string(fmt, ctype));
-}
-
-
 #define MOD_IGN (MOD_QUALIFIER | MOD_FUN_ATTR)
 static inline const char *compare_pointer(struct symbol *target, struct symbol *source)
 {
@@ -258,14 +222,6 @@ static const char *check_printf_length(struct format_type *fmt, struct symbol *s
 	return compare_pointer(target, source);
 }
 
-static int printf_fmt_length(struct format_type *fmt,
-			      struct expression **expr,
-			      struct symbol *ctype,
-			      const char **typediff)
-{
-	return !(*typediff = check_printf_length(fmt, ctype));
-}
-
 // For 'p' specifiers
 static const char *check_printf_pointer(struct format_type *fmt, struct symbol *source)
 {
@@ -278,20 +234,6 @@ static const char *check_printf_pointer(struct format_type *fmt, struct symbol *
 	return NULL;
 }
 
-static int printf_fmt_pointer(struct format_type *fmt,
-			      struct expression **expr,
-			      struct symbol *ctype,
-			      const char **typediff)
-{
-	return !(*typediff = check_printf_pointer(fmt, ctype));
-}
-
-static struct format_type printf_fmt_ptr_ref = {
-	.format = "p",
-	.test = printf_fmt_pointer,
-	.type = &const_ptr_ctype,
-};
-
 static struct format_type *parse_printf_get_fmt(struct format_type *type,
 						const char *msg, const char **msgout)
 {
@@ -338,7 +280,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 
 	switch (*ptr++) {
 	case 'd': case 'i':
-		type->test = printf_fmt_sint;
+		type->test = check_printf_sint;
 		switch (szmod) {
 		case LEN_hh:
 		case LEN_h:
@@ -366,7 +308,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		}
 		break;
 	case 'u': case 'o': case 'x': case 'X':
-		type->test = printf_fmt_uint;
+		type->test = check_printf_uint;
 		switch (szmod) {
 		case LEN_hh:
 		case LEN_h:
@@ -387,6 +329,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 			type->type = size_t_ctype;
 			break;
 		case LEN_t:
+			type->test = check_printf_sint;
 			type->type = ptrdiff_ctype;
 			break;
 		default:
@@ -395,7 +338,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		break;
 	case 'e': case 'E': case 'f': case 'F': case 'g': case 'G':
 	case 'a': case 'A':
-		type->test = printf_fmt_float;
+		type->test = check_printf_float;
 		switch (szmod) {
 		case LEN_none:
 			type->type = &double_ctype;
@@ -408,7 +351,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		}
 		break;
 	case 'c':
-		type->test = printf_fmt_sint;	// FIXME: need its own check?
+		type->test = check_printf_sint;
 		switch (szmod) {
 		case LEN_none:
 			type->type = &int_ctype;
@@ -422,7 +365,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		}
 		break;
 	case 's':
-		type->test = printf_fmt_string;
+		type->test = check_printf_string;
 		switch (szmod) {
 		case LEN_none:
 			type->type = &const_string_ctype;
@@ -436,7 +379,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		}
 		break;
 	case 'p':
-		type->test = printf_fmt_pointer;
+		type->test = check_printf_pointer;
 		type->type = &const_ptr_ctype;
 		/* check for pointer being printed as hex explicitly */
 		if (*ptr == 'x' || *ptr == 'X') {
@@ -450,7 +393,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		/* pointer to an de-referenced int/etc */
 		// todo - we should construct pointer to int/etc //
 		// also should not have any flags or widths for this
-		type->test = printf_fmt_length;
+		type->test = check_printf_length;
 		type->type = &const_ptr_ctype;
 		break;
 	default:
@@ -612,14 +555,9 @@ static int parse_format_printf(const char **fmtstring,
 	}
 
 	type = parse_printf_get_fmt(&ftype, fmt, &fmtpost);
-
-	if (!type && fmt[0] == 'p')
-		type = &printf_fmt_ptr_ref;	/* probably some extension */
-
 	if (type) {
 		struct symbol *ctype;
-		const char *typediff = "different types";
-		int ret;
+		const char *typediff;
 
 		*fmtstring = fmtpost;
 		expr = get_nth_expression(args, pos-1);
@@ -633,8 +571,8 @@ static int parse_format_printf(const char **fmtstring,
 		if (!ctype)
 			return -3;
 
-		ret = type->test(type, &expr, ctype, &typediff);
-		if (ret == 0) {
+		typediff = ftype.test(&ftype, ctype);
+		if (typediff) {
 			warning(expr->pos, "incorrect type in argument %d (%s)", pos, typediff);
 			info(expr->pos, "   expected %s", show_typename(type->type));
 			info(expr->pos, "   got %s", show_typename(ctype));
-- 
2.28.0

