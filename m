Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E140C4727D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2A520757
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiHnNxAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgJECAS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJECAQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4DC061787
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so1954476wrq.2
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCEyELoVH8XRyPWAiyQx08ewxKkaNHdJ7cxYj0FXCwI=;
        b=JiHnNxACqQaqdoYBDJteAsAqDq6YyR3OqLrdMMgG6kEO4tl8tHt2ybz20ukPqEF9n8
         5+7984ClHGhQIGYR08Ftpo4HMSO5SViKU4ZwKpsU552JLLLkdFUPf+Xcz4aaZvxv1T0O
         hFFoDNzG76Fa9MOD//ho6JsYB5GCKfYEmpfYTFhgeCck40rnrd4SuXuidFtXYRn33DEJ
         /8ug2x6cftiKQlxDoeRaFRBkrqf6bk0tNSNqwG75ifEkfXafbH/hQRlQnov/bQtoxtil
         JOjuY1DkkkFZEtyyu6iSM1NaWS58YwSzhWuUu+e19E+M4FIGQPZzJ6QBWNdT7uhdJAKq
         lRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCEyELoVH8XRyPWAiyQx08ewxKkaNHdJ7cxYj0FXCwI=;
        b=jaAPgxKQTMypr537PYabJ8PAYKKNjsImxuupCgl28go1RgvZQMkbe3mj97KETvZ65e
         a1LCv+7DgR47K5GCHEL8WV3pzDkI1UYMEes4XFeKDrReDh3FxaHPpsfvJy0haR37WDLC
         913ZRtUFA9UmhD3qvPhm7auGRM1UP9h+vLKwaeCP4qoBavIePJhrvP4uhdQNugg8DjMe
         8GZUMrGMrVDp7NNIOZ16tYyyk3ICNnEol5lfDbznIwPvICrO2coUXrfuaYCDdU5XPRE7
         jVRHtnrWZVnolZReSSLF1fZ+2EaHgFAsYzNVA1myLIJb4A8MCBWlWqgPih1BbzOZ+mj9
         puig==
X-Gm-Message-State: AOAM531WcBTPaopKf4wp6BUu68FoEw/F75BSxbx5nmv3lQWHfKG+PQb4
        WP80sMs1+WtPhCH2dRfavQrTR6Q3yM4=
X-Google-Smtp-Source: ABdhPJwfNqcl+SndPjOTTOl7g8V7799DzQC5iAM890pvAnaHCUFboruMh/qQnAt8oxrhn04Ttd39GA==
X-Received: by 2002:adf:8484:: with SMTP id 4mr5401589wrg.334.1601863212642;
        Sun, 04 Oct 2020 19:00:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] s/data/type/ for struct format_type
Date:   Mon,  5 Oct 2020 04:00:00 +0200
Message-Id: <20201005020002.1108-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The name of the field 'data' in struct format_type seems to indicate
that it can contain arbitrary untyped stuff but it's a 'struct symbol'
pointer and always contains the expected type of the argument.

So use a more specific name for it 'type'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index 2eaba6653686..95ff524c03cf 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -51,7 +51,7 @@ struct format_type {
 				struct symbol *ctype,
 				struct symbol **target,
 				const char **typediff);
-	struct symbol	*data;
+	struct symbol	*type;
 };
 
 struct format_state {
@@ -67,7 +67,7 @@ static int printf_fmt_numtype(struct format_type *fmt,
 			      struct symbol *ctype,
 			      struct symbol **target, const char **typediff)
 {
-	struct symbol *type = fmt->data;
+	struct symbol *type = fmt->type;
 	*target = type;
 	return check_assignment_types(*target, expr, typediff);
 }
@@ -133,7 +133,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 	} else if (*ptr == 'c') {
 		ptr++;
 		type->test = printf_fmt_numtype;
-		type->data = &char_ctype;
+		type->type = &char_ctype;
 	} else if (*ptr == 'p') {
 		ptr++;
 		type->test = printf_fmt_print_pointer;
@@ -152,12 +152,12 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		if (*ptr == 'd' || *ptr == 'i') {
 			ptr++;
 			type->test = printf_fmt_numtype;
-			type->data = ssize_t_ctype;
+			type->type = ssize_t_ctype;
 		} else if (*ptr == 'u' || *ptr == 'x' || *ptr == 'X' ||
 			   *ptr == 'o') {
 			ptr++;
 			type->test = printf_fmt_numtype;
-			type->data = size_t_ctype;
+			type->type = size_t_ctype;
 		}
 	} else {
 		if (*ptr == 'l') {
@@ -190,16 +190,16 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 			type->test = printf_fmt_numtype;
 			switch (szmod) {
 			case -1:
-				type->data = &ushort_ctype;
+				type->type = &ushort_ctype;
 				break;
 			case 0:
-				type->data = &uint_ctype;
+				type->type = &uint_ctype;
 				break;
 			case 1:
-				type->data = &ulong_ctype;
+				type->type = &ulong_ctype;
 				break;
 			case 2:
-				type->data = &ullong_ctype;
+				type->type = &ullong_ctype;
 				break;
 			default:
 				type->test = NULL;
@@ -209,27 +209,27 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 			type->test = printf_fmt_numtype;
 			switch (szmod) {
 			case -1:
-				type->data = &short_ctype;
+				type->type = &short_ctype;
 				break;
 			case 0:
-				type->data = &int_ctype;
+				type->type = &int_ctype;
 				break;
 			case 1:
-				type->data = &long_ctype;
+				type->type = &long_ctype;
 				break;
 			case 2:
-				type->data = &llong_ctype;
+				type->type = &llong_ctype;
 				break;
 			default:
 				type->test = NULL;
 			}
 		} else if (*ptr == 'L' && is_float_spec(ptr[1])) {
 			type->test = printf_fmt_numtype;
-			type->data = &ldouble_ctype;
+			type->type = &ldouble_ctype;
 			ptr += 2;
 		} else if (is_float_spec(*ptr)) {
 			type->test = printf_fmt_numtype;
-			type->data = szmod == 1 ? &ldouble_ctype :  &double_ctype;
+			type->type = szmod == 1 ? &ldouble_ctype :  &double_ctype;
 			ptr++;
 		} else if (*ptr == 'n') {	/* pointer to an de-referenced int/etc */
 			// todo - we should construct pointer to int/etc //
-- 
2.28.0

