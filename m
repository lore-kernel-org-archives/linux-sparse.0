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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F52C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A062A20B1F
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjUiZ3jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgJNJVq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730982AbgJNJUj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1BDC05BD38
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg9so1167008edb.12
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+zkJ03K5vSEXGu4c5ywj2JKU3ucT/LNqO+Tre+9sZQ=;
        b=OjUiZ3jfVkgomqorwcCLn/osuPnLxaqVLo5FGOvAe3r9yUaNpyN0cYzKacQXfPzCga
         hq/MDdV81NdVQjvqrtSUeX9xWGahzLQ41XKu76xBfcFJqMCqyy2r+rgGL0VQnLs+gvH0
         nsGOh4BTRGcO2sq9MGqpReFbpYzzBIvhxJIeIqhMym7F0oRx+RncVBc7zepgYFgsbu9q
         3tAFIEfHo+82bRxUptP27I9r3VKsPYcyKwxkrohPlUyXFGkDXAwW9kPtdSzc34K1fYLB
         iUU8EXYnmwzZNItIudMlOGgtvbZ52xsHa2OuY0fxZGpfbCM4dCqORamF+2QKYVdCPCE+
         7mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+zkJ03K5vSEXGu4c5ywj2JKU3ucT/LNqO+Tre+9sZQ=;
        b=B4uezfg1fqFkWfFHjjgbAcaNBPqHuX1pYck5pAQbBEJYqWr+6w9Thr2OQyjSVQBNM8
         j6G9jmJB2fOz/RHtn/Q9GGpe2GlEOwZom6fiYIj2wLbdijnBmv0Dh5jwa9HJkodBT2HQ
         bG5dxhFwOfbkcY7c3pwQgCYsN2AXlAjC91n6jcK39M6cSE++hNkhlKGr5V8N+Q43tEVu
         sGhx6Wfwz/sJqA5Im5eNwkrPHMAzoqbkFCG7/H0oVKcOzRVo958GYksKuxmr+J5bmRGH
         0KcfbcwkNLsSF4XX1Kx+vrNShq4eD8dQ6qaQGiFeYys/UCANLH6NKV8AvaTlHP6nvJoC
         eHMQ==
X-Gm-Message-State: AOAM5324gw29Cali9+Jzl1XMPrW1nrP5oquEazVaBfKJzntsTDF0oF3+
        rfQq+fn/l6GlrA/9T5F+WN+XoqMC1So=
X-Google-Smtp-Source: ABdhPJz2m9b4NgbXPf91KLdMWM+OwHd0I3CHfMtUggUozw5TjV2JorXOJGYXF0aQpBgIP6TgRYQAMg==
X-Received: by 2002:a05:6402:1a43:: with SMTP id bf3mr2297455edb.8.1602631362282;
        Tue, 13 Oct 2020 16:22:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/13] format-check: more complete parsing of the length & type modifiers
Date:   Wed, 14 Oct 2020 01:22:20 +0200
Message-Id: <20201013232231.10349-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reorganize the parsing the length modifiers to follow more closely
the specs and handle some missing cases like 'hh' or '%[ieEaA]'.
Also, treats 'L' and 'll' synonymously as done by GCC.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 265 +++++++++++++++++++++++++++---------------------
 1 file changed, 151 insertions(+), 114 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index 4b4730285237..ae5bb2e6e985 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -44,6 +44,14 @@
 #include "expression.h"
 #include "verify-format.h"
 
+enum length_mod {
+	LEN_none,
+	LEN_hh, LEN_h,
+	LEN_l, LEN_ll,
+	LEN_L,
+	LEN_j, LEN_z, LEN_t,
+};
+
 struct format_type {
 	const char	*format;
 	int		(*test)(struct format_type *fmt,
@@ -113,140 +121,169 @@ static struct format_type printf_fmt_ptr_ref = {
 	.test = printf_fmt_pointer,
 };
 
-static int is_float_spec(char t)
-{
-	return t == 'f' || t == 'g' || t == 'F' || t == 'G';
-}
-
 static struct format_type *parse_printf_get_fmt(struct format_type *type,
 						const char *msg, const char **msgout)
 {
 	const char *ptr = msg;
-	int szmod=0;
+	int szmod = LEN_none;
 
 	type->test = NULL;
 	*msgout = ptr;
 
-	if (*ptr == 's') {
-		ptr++;
-		type->test = printf_fmt_string;
-		type->type = &const_string_ctype;
-	} else if (*ptr == 'c') {
-		ptr++;
-		type->test = printf_fmt_numtype;
-		type->type = &char_ctype;
-	} else if (*ptr == 'p') {
-		ptr++;
-		type->test = printf_fmt_print_pointer;
-		/* check for pointer being printed as hex explicitly */
-		if (*ptr == 'x' || *ptr == 'X') {
+	switch (*ptr++) {
+	case 'h':
+		szmod = LEN_h;
+		if (*ptr == 'h') {
+			szmod = LEN_hh;
 			ptr++;
-		} else if (isalpha(*ptr)) {
-			/* probably some extra specifiers after %p */
+		}
+		break;
+	case 'l':
+		szmod = LEN_l;
+		if (*ptr == 'l') {
+			szmod = LEN_ll;
 			ptr++;
-			type->test = printf_fmt_pointer;
 		}
-	} else if (*ptr == 'z') {
-		// todo - we should construct pointer to int/etc //
+		break;
+	case 'q':
+		szmod = LEN_ll;
+		break;
+	case 'L':
+		szmod = LEN_L;
+		break;
+	case 'j':
+		szmod = LEN_j;
+		break;
+	case 'z':
+		szmod = LEN_z;
+		break;
+	case 't':
+		szmod = LEN_t;
+		break;
+	default:
+		ptr--;
+		break;
+	}
 
-		ptr++;
-		if (*ptr == 'd' || *ptr == 'i') {
-			ptr++;
-			type->test = printf_fmt_numtype;
+	switch (*ptr++) {
+	case 'd': case 'i':
+		type->test = printf_fmt_numtype;
+		switch (szmod) {
+		case LEN_hh:
+		case LEN_h:
+		case LEN_none:
+			type->type = &int_ctype;
+			break;
+		case LEN_l:
+			type->type = &long_ctype;
+			break;
+		case LEN_L:
+		case LEN_ll:
+			type->type = &llong_ctype;
+			break;
+		case LEN_j:
+			type->type = intmax_ctype;
+			break;
+		case LEN_z:
 			type->type = ssize_t_ctype;
-		} else if (*ptr == 'u' || *ptr == 'x' || *ptr == 'X' ||
-			   *ptr == 'o') {
-			ptr++;
-			type->test = printf_fmt_numtype;
-			type->type = size_t_ctype;
+			break;
+		case LEN_t:
+			type->type = ptrdiff_ctype;
+			break;
+		default:
+			type->test = NULL;
 		}
-	} else {
-		if (*ptr == 'l') {
-			szmod++;
-			ptr++;
-			if (*ptr == 'l') {
-				szmod++;
-				ptr++;
-			}
-		} else if (*ptr == 'L') {
-			szmod++;
-			ptr++;
-		} else {
-			if (*ptr == 'h') { // short/char to int
-				szmod = -1;
-				ptr++;
-				if (*ptr == 'h')  // promotion from char
-					ptr++;
-			}
-			if (*ptr == 't') {  // ptrdiff_t
-				szmod = 2;
-				ptr++;
-			}
-			if (*ptr == 'j') { // intmax_t
-				// todo - replace iwth intmax_ctype when added
-				szmod = 1;
-				ptr++;
-			}
+		break;
+	case 'u': case 'o': case 'x': case 'X':
+		type->test = printf_fmt_numtype;
+		switch (szmod) {
+		case LEN_hh:
+		case LEN_h:
+		case LEN_none:
+			type->type = &uint_ctype;
+			break;
+		case LEN_l:
+			type->type = &ulong_ctype;
+			break;
+		case LEN_L:
+		case LEN_ll:
+			type->type = &ullong_ctype;
+			break;
+		case LEN_j:
+			type->type = uintmax_ctype;
+			break;
+		case LEN_z:
+			type->type = size_t_ctype;
+			break;
+		case LEN_t:
+			type->type = ptrdiff_ctype;
+			break;
+		default:
+			type->test = NULL;
 		}
-
-		if (*ptr == 'x' || *ptr == 'X' || *ptr == 'u' || *ptr == 'o') {
-			ptr++;
-			type->test = printf_fmt_numtype;
-			switch (szmod) {
-			case -1:
-				type->type = &ushort_ctype;
-				break;
-			case 0:
-				type->type = &uint_ctype;
-				break;
-			case 1:
-				type->type = &ulong_ctype;
-				break;
-			case 2:
-				type->type = &ullong_ctype;
-				break;
-			default:
-				type->test = NULL;
-			}
-		} else if (*ptr == 'i' || *ptr == 'd') {
-			ptr++;
-			type->test = printf_fmt_numtype;
-			switch (szmod) {
-			case -1:
-				type->type = &short_ctype;
-				break;
-			case 0:
-				type->type = &int_ctype;
-				break;
-			case 1:
-				type->type = &long_ctype;
-				break;
-			case 2:
-				type->type = &llong_ctype;
-				break;
-			default:
-				type->test = NULL;
-			}
-		} else if (*ptr == 'L' && is_float_spec(ptr[1])) {
-			type->test = printf_fmt_numtype;
+		break;
+	case 'e': case 'E': case 'f': case 'F': case 'g': case 'G':
+	case 'a': case 'A':
+		type->test = printf_fmt_numtype;
+		switch (szmod) {
+		case LEN_none:
+			type->type = &double_ctype;
+			break;
+		case LEN_L:
 			type->type = &ldouble_ctype;
-			ptr += 2;
-		} else if (is_float_spec(*ptr)) {
-			type->test = printf_fmt_numtype;
-			type->type = szmod == 1 ? &ldouble_ctype :  &double_ctype;
-			ptr++;
-		} else if (*ptr == 's') {
-			type->test = printf_fmt_string;
+			break;
+		default:
+			break;
+		}
+		break;
+	case 'c':
+		type->test = printf_fmt_numtype;
+		switch (szmod) {
+		case LEN_none:
+			type->type = &int_ctype;
+			break;
+		case LEN_L:
+		case LEN_l:
+			type->type = wint_ctype;
+			break;
+		default:
+			break;
+		}
+		break;
+	case 's':
+		type->test = printf_fmt_string;
+		switch (szmod) {
+		case LEN_none:
+			type->type = &const_string_ctype;
+			break;
+		case LEN_L:
+		case LEN_l:
 			type->type = &const_wstring_ctype;
+			break;
+		default:
+			break;
+		}
+		break;
+	case 'p':
+		type->test = printf_fmt_print_pointer;
+		/* check for pointer being printed as hex explicitly */
+		if (*ptr == 'x' || *ptr == 'X') {
 			ptr++;
-		} else if (*ptr == 'n') {	/* pointer to an de-referenced int/etc */
-			// todo - we should construct pointer to int/etc //
-			// also should not have any flags or widths for this
-			type->test = printf_fmt_pointer;
+		} else if (isalpha(*ptr)) {
+			/* probably some extra specifiers after %p */
 			ptr++;
-		} else {
-			// anything else here?
+			type->test = printf_fmt_pointer;
 		}
+		break;
+	case 'n':
+		/* pointer to an de-referenced int/etc */
+		// todo - we should construct pointer to int/etc //
+		// also should not have any flags or widths for this
+		type->test = printf_fmt_pointer;
+		break;
+	default:
+		// anything else here?
+		break;
 	}
 
 	if (type->test == NULL)
-- 
2.28.0

