Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24381C4742A
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E474E2075F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg9wrhaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgI3XSw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732171AbgI3XSn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5740DC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so3571912wrn.0
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1m4GeymSLrdvni0gyQthurgsXukJu7vZrBewa9DhEoU=;
        b=Kg9wrhafbZ9XNZXfDJWZ/e+haPATk2/3HlZO70mhyZy71MXY1V9hJBBLr9viADIVbw
         hmpeOwPnxYbHftnujaJNT/qt68OXV9eli6N3uFLc5XD/J3qwhr23kVBP7sBxcrigRtD+
         Wpb+3UqeSUB5Ut18IEmtUn2/AMfBVI2nX/NkGktmLTvNzOLxO3ZEL7+nzRTb61V08BjB
         xjkyx8/u5Lo5JykOUEK63PWGnUElwpGpYu02a6HCtx3glIVY0BVslqrpNs8mR3BPQeXa
         bjd8c1DQAVgolX845RbqPaHcZoh0J5gA5rZkkZtaGgxaZCXxRSiC2R2hrdbKlzTKE2Wg
         2hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1m4GeymSLrdvni0gyQthurgsXukJu7vZrBewa9DhEoU=;
        b=AN4DsuUN9g2RL5tkV4h0LieAJFW/UcBDh6kaY3OhQqfkswpDGf2AZX+dyNrJtoMplQ
         TET1Q3lg1mAdBxm2aYKPIHLKmoTGRbD3wVs19JBOa+WyZxLEkRl1TYnfuKJf6YhlBslU
         gttkSAIKlpo7Efk9015VqgLgA4o9Ke4gUzfHuxWlRKriVL3JGjEqksOmOF7BtskPx4K1
         +ot7mXJQWx6mdYfUU2W0KC2+L8PvQ08PSh1JIlVbFdeQl45HZm4hYVG9fBbDQ5Ie4BnU
         25fr7F659QVZvutJmCRNjBiAvRMMl5goFM41PfKOOXBaRq2fX3hIsrj0qF0F3VVtIbtT
         qhVQ==
X-Gm-Message-State: AOAM530IJH+l2cyPcxrTdbQkIaYfcHOiR8yfrl5tFhQ1lW6CT5FUZ+bL
        WKLFlr3UCJz5DmD6eX5W+ieT2wS98H0=
X-Google-Smtp-Source: ABdhPJwj88l8FqJrzrlwDfzti9Z5+Vqb5/SUHKY5eSAugmXrKDLbhzVGa+/7OfU17QyNji9vHMasww==
X-Received: by 2002:adf:e292:: with SMTP id v18mr5462445wri.256.1601507921845;
        Wed, 30 Sep 2020 16:18:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/13] flex-array: warn when using sizeof() on a flexible array
Date:   Thu,  1 Oct 2020 01:18:25 +0200
Message-Id: <20200930231828.66751-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Using sizeof() on a structure containing a flexible array
will ignore the 'flexible' part. This is maybe what is expected
but maybe not, so add an option -Wflexible-array-sizeof to
warn on such usage.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                     | 3 +++
 options.c                      | 2 ++
 options.h                      | 1 +
 sparse.1                       | 7 +++++++
 validation/flex-array-sizeof.c | 1 -
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index c1ef348a475e..cfbb6ada4153 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2253,6 +2253,9 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
 		size = bits_in_char;
 	}
 
+	if (has_flexible_array(type) && Wflexible_array_sizeof)
+		warning(expr->pos, "using sizeof on a flexible structure");
+
 	if (is_array_type(type) && size < 0) {	// VLA, 1-dimension only
 		struct expression *base, *size;
 		struct symbol *base_type;
diff --git a/options.c b/options.c
index 294dfd3be77a..ce88fbf6ed61 100644
--- a/options.c
+++ b/options.c
@@ -100,6 +100,7 @@ int Wdesignated_init = 1;
 int Wdo_while = 0;
 int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
+int Wflexible_array_sizeof = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
@@ -840,6 +841,7 @@ static const struct flag warnings[] = {
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "external-function-has-definition", &Wexternal_function_has_definition },
+	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
 	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
diff --git a/options.h b/options.h
index abdf08645ad2..feb351a36c9e 100644
--- a/options.h
+++ b/options.h
@@ -99,6 +99,7 @@ extern int Wdesignated_init;
 extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
+extern int Wflexible_array_sizeof;
 extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
diff --git a/sparse.1 b/sparse.1
index 48dab7a9a5c1..5f98df33a231 100644
--- a/sparse.1
+++ b/sparse.1
@@ -257,6 +257,13 @@ Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-external\-function\-has\-definition\fR.
 .
 .TP
+.B -Wflexible-array-sizeof
+Warn about using the sizeof operator on a structure containing a flexible array,
+possibly recursively.
+
+Sparse does not issue these warnings by default.
+.
+.TP
 .B \-Winit\-cstring
 Warn about initialization of a char array with a too long constant C string.
 
diff --git a/validation/flex-array-sizeof.c b/validation/flex-array-sizeof.c
index 3359509d0084..05394e19a6b2 100644
--- a/validation/flex-array-sizeof.c
+++ b/validation/flex-array-sizeof.c
@@ -11,7 +11,6 @@ static int foo(struct s *s)
 /*
  * check-name: flex-array-sizeof
  * check-command: sparse -Wflexible-array-sizeof $file
- * check-known-to-fail
  *
  * check-error-start
 flex-array-sizeof.c:8:16: warning: using sizeof on a flexible structure
-- 
2.28.0

