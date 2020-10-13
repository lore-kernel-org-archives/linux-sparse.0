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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9767AC433E7
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E93720BED
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oseX0Jgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgJNJVa (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbgJNJUm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC2C08E88F
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so2102497ejy.11
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfUYoFMaKu/nk3VDPjMeSnhKaLJHp2Qpxho4VbNsmZk=;
        b=oseX0JgfDyrAkf+rAOV30gslYYT6pGQMfo48bjaLJiTjAJV3zIOsDMrxLcxHRH0CNP
         BQ5XUA7Q3rfc6Ilmz2iVZP8otsKNcSyc7T/pPMQ2pDENakrDGjH8hTajFcQQ+oQNf3rY
         vtRf0dT3yDdR8BRplSC2gVCejexMyinJaliZitzUX9BvIJmJOOVR0Wl9nqHbPMfnGMKQ
         FhPI86Pw1ZLX3qzLjbrinRkbViJ2R/KTRUmPaxbmgOqJ5T59T0oryHiwCCCej8Gy4yck
         btN1/jgsp2s0MjNM3nVq1UNgYClprioOciGf6yeclmsI0GkKSufKEQNj8CJqSnxy8hZe
         KWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfUYoFMaKu/nk3VDPjMeSnhKaLJHp2Qpxho4VbNsmZk=;
        b=i4+AwvQfnxI3XlN595d8m/ij97qojwJkOPHj3rSkyv+rnnc0awMaMI9G+YggwHDd3A
         vu4klfHAc7vVK0hZjq1pkybhQJIFjchgrvmScxKwD3eSO7n8TCqboqWtagEgi8FrLNCv
         bXnRqeHUigYtVtpg+/MiocJ53OTVo2Rya92EZHXNGacIzNd3MFfp9dwjauTJaUKeKiyb
         7yYVSj+WnxbrzwN7IWwSpF15T9Y5z6P+rFeHyaPjSPpP0WVKODKqs5SLzb8nJM31+f3b
         G+SdL2qwy7z6WKSJscFaEbN27D3rqILPWmQTfu0o8yiSkSQ0LES3/OxX0jVCx/8AxRfD
         2IhA==
X-Gm-Message-State: AOAM5300MhgoPGVOk5NQFzw6HofO2St6YpqiPJriFGYWDR6yetDLYDQq
        9ZEbUgfaJlb2KaBq+YWTwBRprrWGTaw=
X-Google-Smtp-Source: ABdhPJwPHqz0KdPl0wcgrJOkQx6F2ywIXdzAFkiezn7N/T5lyQwcG2k0epK+ge7Er/zSI3Hg3uR6CQ==
X-Received: by 2002:a17:906:b01:: with SMTP id u1mr2208166ejg.57.1602631369857;
        Tue, 13 Oct 2020 16:22:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:49 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/13] format-check: add a function to check the type of floats
Date:   Wed, 14 Oct 2020 01:22:28 +0200
Message-Id: <20201013232231.10349-11-luc.vanoostenryck@gmail.com>
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

So, add a custom checking function, currently just checking
if the argument is one of the floating-point types.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/verify-format.c b/verify-format.c
index 34c3db96fe3a..6bcbfdfef1b4 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -106,6 +106,27 @@ static int printf_fmt_numtype(struct format_type *fmt,
 	return check_assignment_types(fmt->type, expr, typediff);
 }
 
+static const char *check_printf_float(struct format_type *fmt, struct symbol *source)
+{
+	const char *typediff = "different base types";
+	struct symbol *target = fmt->type;
+	struct symbol *base;
+
+	if (type_class(source, &base) != CLASS_FLOAT)
+		return typediff;
+	if (base == target)
+		return NULL;
+	return typediff;
+}
+
+static int printf_fmt_float(struct format_type *fmt,
+			      struct expression **expr,
+			      struct symbol *ctype,
+			      const char **typediff)
+{
+	return !(*typediff = check_printf_float(fmt, ctype));
+}
+
 // For 's' & 'S' specifiers
 static const char *check_printf_string(struct format_type *fmt, struct symbol *source)
 {
@@ -310,7 +331,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		break;
 	case 'e': case 'E': case 'f': case 'F': case 'g': case 'G':
 	case 'a': case 'A':
-		type->test = printf_fmt_numtype;
+		type->test = printf_fmt_float;
 		switch (szmod) {
 		case LEN_none:
 			type->type = &double_ctype;
-- 
2.28.0

