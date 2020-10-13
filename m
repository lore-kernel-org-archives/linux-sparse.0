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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B1C433E7
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD68C206F4
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7BUdnFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgJNJan (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgJNJTh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC9C08E935
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so2172282ejb.3
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMRHjmybsutJ1RsIbgn7gcqCH6qc6r1MLM0R5JX9riU=;
        b=N7BUdnFW9yvvkBnwVx7FhWr4VFROVOkYEGKRRJsioEoQ+jKwrIETMbr9wRf2rcSA0S
         iGQqjLxVU4nreTq3JnjDJ5+OBw4OxwfcHFQGQNPBPMjyJAgGT+Rg70wd4HU9IgTFUwfo
         D48SOVA7xI+CDjqidSSUE5AXD6huojN5KzZzrVr7lxa6aEGnBnlMp/v+Y/u9BgU5ig4e
         dJ1jKnxqtDDIs/uso37cTUK2Y1rm0R8BArG75OXO7wFLMG9y0ZqBDL4ICl7YJsGW94LQ
         5WOHiFeTCnFQ07VOUGUZGCWlbWfMEFQMz1D4wvfJC6Ps+cReflSZIrCzbr4cHKP4B6f7
         U1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMRHjmybsutJ1RsIbgn7gcqCH6qc6r1MLM0R5JX9riU=;
        b=OE9MYW8U8ClwCCoHg7AuxPUpZJCOvhbw/t8HvB2/qf+2LaCBM137Z2MtV0iAgOae9D
         PPtRFULtnqZtjcYf6Y8B2YCJXqebPJ9u/fG7rfjr/L7ZR0jTdJqqzdvUhMf5lT3cabZf
         hBWH2OlqbSci6DdB7h6oC3wI/4JQdpgtmvUvFsEt/YWAfM4Y7kh1FIeB2jaaEuOk8VCX
         U6mVAc953wMBRVgcomKzdxPPN4gkXKuJdJ8jA5x9xZLt0UYsV4StxCWsXV5da97Mm2B2
         S2+2TQ8otFUhzh+TBNlRQqaWmUd1mh7giPblBhUXXHiHDT6oXzxho4Kk9mJhrJ0D9FIY
         xvyw==
X-Gm-Message-State: AOAM530vTZjGpQ86KD+5x5NqQZG5J8Bp9000AcCg1AihfkgXJ8GSmTrp
        eezoNr4W7Y2Os9ryBg2BaHh27NXnlPM=
X-Google-Smtp-Source: ABdhPJxGGjOVBsTzYWO7voelpXkQsPOKYY1bw5z+Wt1/b9UrFoPjDZAkTdxNzpDSa6pIqDpvz7WgAw==
X-Received: by 2002:a17:906:b858:: with SMTP id ga24mr2241787ejb.378.1602631372462;
        Tue, 13 Oct 2020 16:22:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/13] format-check: simplify calling of parse_printf_get_fmt()
Date:   Wed, 14 Oct 2020 01:22:31 +0200
Message-Id: <20201013232231.10349-14-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The function parse_printf_get_fmt() was allowed to return a
customized version of its format_type argument but this is
not really needed. So simplify the calling of this function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/verify-format.c b/verify-format.c
index 753e59c167ce..1f5a2798dce4 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -234,8 +234,7 @@ static const char *check_printf_pointer(struct format_type *fmt, struct symbol *
 	return NULL;
 }
 
-static struct format_type *parse_printf_get_fmt(struct format_type *type,
-						const char *msg, const char **msgout)
+static int parse_printf_get_fmt(struct format_type *type, const char *msg, const char **msgout)
 {
 	const char *ptr = msg;
 	int szmod = LEN_none;
@@ -401,11 +400,8 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		break;
 	}
 
-	if (type->test == NULL)
-		return NULL;
-
 	*msgout = ptr;
-	return type;
+	return type->test == NULL;
 }
 
 static int is_printf_flag(char ch)
@@ -505,7 +501,6 @@ static int parse_format_printf(const char **fmtstring,
 			       struct expression_list *args)
 {
 	struct format_type ftype;	/* temp storage for format info */
-	struct format_type *type;	/* type found from the parse */
 	struct expression *expr;
 	const char *fmt = *fmtstring;	/* pointer to parse position */
 	const char *fmtpost = NULL;	/* moved to end of the parsed format */
@@ -554,8 +549,8 @@ static int parse_format_printf(const char **fmtstring,
 			error++;
 	}
 
-	type = parse_printf_get_fmt(&ftype, fmt, &fmtpost);
-	if (type) {
+	ret = parse_printf_get_fmt(&ftype, fmt, &fmtpost);
+	if (!ret) {
 		struct symbol *ctype;
 		const char *typediff;
 
@@ -574,7 +569,7 @@ static int parse_format_printf(const char **fmtstring,
 		typediff = ftype.test(&ftype, ctype);
 		if (typediff) {
 			warning(expr->pos, "incorrect type in argument %d (%s)", pos, typediff);
-			info(expr->pos, "   expected %s", show_typename(type->type));
+			info(expr->pos, "   expected %s", show_typename(ftype.type));
 			info(expr->pos, "   got %s", show_typename(ctype));
 		}
 	} else {
-- 
2.28.0

