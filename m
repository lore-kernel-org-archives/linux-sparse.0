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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09302C43457
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71FC206DD
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+8ee3q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgJNJX7 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbgJNJWk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF30C08E89B
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ce10so2157738ejc.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/TY+e+Lbq2HlSlnsOUd7exF2XekpBxGp4qisQ9IMUc=;
        b=M+8ee3q/SEXyOdUSmcKd3C9YLQRsS0Hc2QBUbuVa1nL0vZY4J4QF23PJMg51mD0yQq
         GziCF+AY5cpDxYcMKrLWz4H7ZlWMeqD7PmW2k0BgA1MWAnqiNiISHqP+jl7nXkwZSRzu
         PWtw9EDDMTVnkuDfOko1BLrpQhJi2sgkL+WRPkltLjKjWtkzay5xEYJgt59sBZTd22NQ
         HUnRHAjRTh+KH8s8hJhPXtK6GecxnPTjg60UPqIm7taOhoHt5ns9Bu3i5Ry3rrZ4JWby
         Ui9VPl+NTCPaDaAucEb8suGjcZBVyzBFiujS3xv0Ak/LHaRSguHTId4NzwBD2fUxxO9u
         xqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/TY+e+Lbq2HlSlnsOUd7exF2XekpBxGp4qisQ9IMUc=;
        b=jaNhXwreXNmmCff7A6nTmG69ZBLjLklcBapey5yf9MJ5zTb26e3XE95iLK0+gEy/YR
         cGBU0/aI5BvnTV9B/2JbDTVynucEJLls2KDmOc6ZWVqgoQMrYewRQM4hXNFiY796WTSF
         FO2mCrBO7ufX7WrYYJCu/EfJ/vRRGZo4dOm93gVRGFpZ7jlu5rkbXpPvW2/aTQATO7aZ
         AQgGx1d1VAsgCZQ91fq6YZ+Nf68w4H4+nptU3fh97zf06pysU4YS5CV9G8VwkTbLPWaI
         6SwtQtXaqHo9e+uaUs5vvR+GYwo6ZJ2e+tFHcOrn2bZ4Eh8Y7+HzVU3u1x4RzE9J1tn9
         E24w==
X-Gm-Message-State: AOAM532SMPr1MLRIYkG3LzD4lfQm+0RdIPpC1dlIe3ePYxMZO+geUOda
        UExKAbL+nQR01KxLBPPZfY8DeO77l+I=
X-Google-Smtp-Source: ABdhPJwdt44t4Qw+rfX5Ve7QA39Ehwy+++aKpb1PavuWuWKhehzQ5HGdUcwaiRhN0WzPw1XlMflgoA==
X-Received: by 2002:a17:906:e103:: with SMTP id gj3mr2230280ejb.442.1602631370826;
        Tue, 13 Oct 2020 16:22:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/13] format-check: add a function to check the type of integers
Date:   Wed, 14 Oct 2020 01:22:29 +0200
Message-Id: <20201013232231.10349-12-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This checking is currently done by check_assignment_types()
for all numeric types but this is not adequate because we
want to have a better control over what is allowed or not

So, add a custom checking function:
*) checking if the argument is one of the integer types.
*) currently accepting bitwise types too
*) easily extended to handle -Wformat-signedness

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 74 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index 6bcbfdfef1b4..fdfe9c22e858 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -98,12 +98,76 @@ static inline int type_class(struct symbol *type, struct symbol **base)
 	return CLASS_OTHER;
 }
 
-static int printf_fmt_numtype(struct format_type *fmt,
+static struct symbol *normalize_sint(struct symbol *s)
+{
+	if (s == &sint_ctype)
+		return &int_ctype;
+	if (s == &slong_ctype)
+		return &long_ctype;
+	if (s == &sllong_ctype)
+		return &llong_ctype;
+	if (s == &sint128_ctype)
+		return &int128_ctype;
+	return s;
+}
+
+static struct symbol *normalize_uint(struct symbol *s)
+{
+	if (s == &uint_ctype)
+		return &int_ctype;
+	if (s == &ulong_ctype)
+		return &long_ctype;
+	if (s == &ullong_ctype)
+		return &llong_ctype;
+	if (s == &uint128_ctype)
+		return &int128_ctype;
+	return s;
+}
+
+static const char *check_printf_int(struct format_type *fmt, struct symbol *source, int sign)
+{
+	const char *typediff = "different base types";
+	struct symbol *target = fmt->type;
+	int class = type_class(source, &source);
+
+	if (class == CLASS_BITWISE)
+		class = type_class(source->ctype.base_type, &source);
+	if (class != CLASS_INT)
+		return typediff;
+
+	// For now, ignore the signedness
+	target = normalize_uint(target);
+	source = normalize_uint(source);
+	source = normalize_sint(source);
+	if (source == target)
+		return NULL;
+	return typediff;
+}
+
+static const char *check_printf_sint(struct format_type *fmt, struct symbol *source)
+{
+	return check_printf_int(fmt, source, 1);
+}
+
+static int printf_fmt_sint(struct format_type *fmt,
+			      struct expression **expr,
+			      struct symbol *ctype,
+			      const char **typediff)
+{
+	return !(*typediff = check_printf_sint(fmt, ctype));
+}
+
+static const char *check_printf_uint(struct format_type *fmt, struct symbol *source)
+{
+	return check_printf_int(fmt, source, 0);
+}
+
+static int printf_fmt_uint(struct format_type *fmt,
 			      struct expression **expr,
 			      struct symbol *ctype,
 			      const char **typediff)
 {
-	return check_assignment_types(fmt->type, expr, typediff);
+	return !(*typediff = check_printf_uint(fmt, ctype));
 }
 
 static const char *check_printf_float(struct format_type *fmt, struct symbol *source)
@@ -274,7 +338,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 
 	switch (*ptr++) {
 	case 'd': case 'i':
-		type->test = printf_fmt_numtype;
+		type->test = printf_fmt_sint;
 		switch (szmod) {
 		case LEN_hh:
 		case LEN_h:
@@ -302,7 +366,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		}
 		break;
 	case 'u': case 'o': case 'x': case 'X':
-		type->test = printf_fmt_numtype;
+		type->test = printf_fmt_uint;
 		switch (szmod) {
 		case LEN_hh:
 		case LEN_h:
@@ -344,7 +408,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		}
 		break;
 	case 'c':
-		type->test = printf_fmt_numtype;
+		type->test = printf_fmt_sint;	// FIXME: need its own check?
 		switch (szmod) {
 		case LEN_none:
 			type->type = &int_ctype;
-- 
2.28.0

