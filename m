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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE601C43457
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBDC206DD
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQGr2nqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgJNJXg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731253AbgJNJWz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F59C05BD3C
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ce10so2157501ejc.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cq3ZpLYnkZzbzSCYWFDaS4KCdWAHKEfNSAdJkuiEDC4=;
        b=aQGr2nqGLuEfJIN86uWLyxIDUmwbWxAadVo2gmBPaGG6LBmFHBZ+BVKqBJxDBoTcVI
         oEXU9iKafmDmpvYNSK6nTKBBAgs9t27wUIZzI/vT9DTSHnurBNSQXm+KhZ8+swAIZqIi
         fwMMtDra4I+osMWWhIpP8DzlPf6Xri3Bst8RtaX4gktYtQslcRlXt4VXMsZNDbc4VM4f
         gSsG2Icq8wsWJlHSaY0dh6PWHw9L6kiAXf8JekLIHmcCpf5gjeadZweusmMnoDAK/Bu3
         fcYvBNFh6lk6N/HdEblPb8jNsND6IUCoDobR0KHgYPp175ifTE7gVCKgkwg5Tbnq00UW
         tCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cq3ZpLYnkZzbzSCYWFDaS4KCdWAHKEfNSAdJkuiEDC4=;
        b=NSDOM3THqHKfaOZzhVep5lwvEigGKRucd0I2mxA9LefVPHOQnK9Dw3On7Mn0Kbq4qb
         7tU9cs5OL6E7We87BEI8vSfFdB+egjEBX+Tbiq/7kvCP0dFA0M26gP1CPYk/mFBq+iws
         5JBznl921IFo9u2wKsk28GSyW+4I0Lu4Q1V8vM7MFuWRm5KQB0dtDQntHJB0UGsI4Vaq
         STuCYTsnWl6qUOREdO9i66sr8qcLsRA1gz9nQmtqYwB/9ff4yuqIGJjfILVLzmJnEw7W
         1GolJyiOaKCNrgwjw3h8yTZcbtxhh7MesnKmxwy9F257KIeV+PWjK5+oq4H0+SP4jyUk
         VjTQ==
X-Gm-Message-State: AOAM532zCQiiROf2VIcgcuDUf44Nlhq34PFdpdEmmT8J88s5GSlbp+77
        kGXIpJlFasHcLC+aqF6v1/tK5OlSeos=
X-Google-Smtp-Source: ABdhPJzW6zKFC2WGwTgBIzPjaEcOoP9zAOogNPjAgtg9KbIoj0oHEwei7z8FlVqLaxPHNVy+3oj9wA==
X-Received: by 2002:a17:906:1f53:: with SMTP id d19mr2206488ejk.255.1602631365198;
        Tue, 13 Oct 2020 16:22:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/13] format-check: remove unneeded member: target
Date:   Wed, 14 Oct 2020 01:22:23 +0200
Message-Id: <20201013232231.10349-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The signature of the checking method allow to return the target
type. But this is never needed as it is always statically known.

So, remove this argument.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index 99a36c8eef5f..0ef2cb863ae9 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -57,7 +57,6 @@ struct format_type {
 	int		(*test)(struct format_type *fmt,
 				struct expression **expr,
 				struct symbol *ctype,
-				struct symbol **target,
 				const char **typediff);
 	struct symbol	*type;
 };
@@ -102,41 +101,35 @@ static inline int type_class(struct symbol *type, struct symbol **base)
 static int printf_fmt_numtype(struct format_type *fmt,
 			      struct expression **expr,
 			      struct symbol *ctype,
-			      struct symbol **target, const char **typediff)
+			      const char **typediff)
 {
-	struct symbol *type = fmt->type;
-	*target = type;
-	return check_assignment_types(*target, expr, typediff);
+	return check_assignment_types(fmt->type, expr, typediff);
 }
 
 static int printf_fmt_string(struct format_type *fmt,
 			     struct expression **expr,
 			     struct symbol *ctype,
-			     struct symbol **target, const char **typediff)
+			     const char **typediff)
 {
-	*target = fmt->type;
-	return check_assignment_types(*target, expr, typediff);
+	return check_assignment_types(fmt->type, expr, typediff);
 }
 
 static int printf_fmt_pointer(struct format_type *fmt,
 			      struct expression **expr,
 			      struct symbol *ctype,
-			      struct symbol **target, const char **typediff)
+			      const char **typediff)
 {
-	*target = &const_ptr_ctype;
-	return check_assignment_types(*target, expr, typediff);
+	return check_assignment_types(fmt->type, expr, typediff);
 }
 
 static int printf_fmt_print_pointer(struct format_type *fmt,
 				    struct expression **expr,
 				    struct symbol *ctype,
-				    struct symbol **target,
 				    const char **typediff)
 {
 	// TODO TODO: fix this here!!!
 	int ret;
-	*target = &const_ptr_ctype;
-	ret = check_assignment_types(*target, expr, typediff);
+	ret = check_assignment_types(fmt->type, expr, typediff);
 	if (ret == 0) {
 		/* if just printing, ignore address-space mismatches */
 		if (strcmp(*typediff, "different address spaces") == 0)
@@ -148,6 +141,7 @@ static int printf_fmt_print_pointer(struct format_type *fmt,
 static struct format_type printf_fmt_ptr_ref = {
 	.format = "p",
 	.test = printf_fmt_pointer,
+	.type = &const_ptr_ctype,
 };
 
 static struct format_type *parse_printf_get_fmt(struct format_type *type,
@@ -295,6 +289,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		break;
 	case 'p':
 		type->test = printf_fmt_print_pointer;
+		type->type = &const_ptr_ctype;
 		/* check for pointer being printed as hex explicitly */
 		if (*ptr == 'x' || *ptr == 'X') {
 			ptr++;
@@ -309,6 +304,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		// todo - we should construct pointer to int/etc //
 		// also should not have any flags or widths for this
 		type->test = printf_fmt_pointer;
+		type->type = &const_ptr_ctype;
 		break;
 	default:
 		// anything else here?
@@ -474,7 +470,7 @@ static int parse_format_printf(const char **fmtstring,
 		type = &printf_fmt_ptr_ref;	/* probably some extension */
 
 	if (type) {
-		struct symbol *ctype, *target = NULL;
+		struct symbol *ctype;
 		const char *typediff = "different types";
 		int ret;
 
@@ -490,13 +486,10 @@ static int parse_format_printf(const char **fmtstring,
 		if (!ctype)
 			return -3;
 
-		ret = type->test(type, &expr, ctype, &target, &typediff);
-		if (!target)	/* shouldn't happen, but catch anyway */
-			return -4;
-
+		ret = type->test(type, &expr, ctype, &typediff);
 		if (ret == 0) {
 			warning(expr->pos, "incorrect type in argument %d (%s)", pos, typediff);
-			info(expr->pos, "   expected %s", show_typename(target));
+			info(expr->pos, "   expected %s", show_typename(type->type));
 			info(expr->pos, "   got %s", show_typename(ctype));
 		}
 	} else {
-- 
2.28.0

