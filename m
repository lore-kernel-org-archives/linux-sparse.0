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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145D4C47425
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D396A2076B
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suCCZQau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbgI3XSv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgI3XSp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC0C0613D1
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v12so1118444wmh.3
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WKLM2C6qMLkIZKOBs5AbUjGucYg3UVIUWBwmAZ7iUc=;
        b=suCCZQaucZ+MgkqK9Rb370zLfwqghNOWgGU5gGO/xEeI7vCCPTmyVt8T3fmjtz7+wE
         odi0M0yggU87p86n7jrmVjqp+NNQAxYMRS89HgPXJFgljjjK5MBkz7ZJb1SG/kB/NzuL
         oPnGdMLU6JKj8rwW+x4ffpEvRq2cZ3DpyccrRxArnLNkTBy+/X4zAv/hjKxNfQwKEoIh
         vFlq1olLAzq7tkYYzdjLq1EQYKEwbVAxSFP+1/CHm2ju6t55tfNtGaVgvZIB+vGxKQSk
         I5z/i4zWVDytate2M6jOWDv7t9iMylAZqp9eJh9X2Xs3knlIoZC4Aqz5A6xDi8VWdRJs
         hamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WKLM2C6qMLkIZKOBs5AbUjGucYg3UVIUWBwmAZ7iUc=;
        b=kL8zKMXbiCXFnHxVdJgWarcTS1ozmZRibFjkRFa341NAMjZYjdQxAsqoZrX5I3NYKv
         infjhFYhKskmGiDhiiSJ5REAlKtlgeAQ4dFbT7g5SoPbY5ou88uZcF+X+KVuX5sbpaYn
         HB4vXFOw9rZywt5J50waJoeyd8X56ElY+VG+WHv5RBl5UQgpUebOOUmKR1apmB61d62o
         1Z6LY2T7DwxdLEAAKCa2qKkJ56Tsjm77HLKilr12GyPeLyL1jrxJ4/MDBxwwWQHW39c/
         AQAsXBEabh3geByDnWd0NGvUlmKJHaNZ7grvLswf9N/bL95QaXAbLeYy3snz+OU1Xj/Z
         06fg==
X-Gm-Message-State: AOAM532W8A9u5ub3TW0zSRWJJeNKSH3E7T5cgaMslMOfGFVoKxEHXxCW
        KpRc0xIHh/SxIRI1b0U9yyq/zxxLaEk=
X-Google-Smtp-Source: ABdhPJzdWJOeVt2NnFUIqJVeC0IwlqmUQrdQ7+WxpK1CncZjlfcciQUOQi8k6pgy5SGrlbLulgrNYg==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr5489188wmg.72.1601507923383;
        Wed, 30 Sep 2020 16:18:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/13] flex-array: warn on flexible array in nested aggregate types
Date:   Thu,  1 Oct 2020 01:18:27 +0200
Message-Id: <20200930231828.66751-13-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A structure or a union containing another aggregate type containing,
possibly recursively, a flexible array is quite error prone and make
not much sense. So, add an option -Wflexible-array-nested to warn
on such usage.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c                      | 2 ++
 options.h                      | 1 +
 sparse.1                       | 7 +++++++
 symbol.c                       | 4 ++++
 validation/flex-array-nested.c | 1 -
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/options.c b/options.c
index a8129ac1e952..b46900b973a6 100644
--- a/options.c
+++ b/options.c
@@ -101,6 +101,7 @@ int Wdo_while = 0;
 int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
 int Wflexible_array_array = 1;
+int Wflexible_array_nested = 0;
 int Wflexible_array_sizeof = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
@@ -843,6 +844,7 @@ static const struct flag warnings[] = {
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "external-function-has-definition", &Wexternal_function_has_definition },
 	{ "flexible-array-array", &Wflexible_array_array },
+	{ "flexible-array-nested", &Wflexible_array_nested },
 	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
diff --git a/options.h b/options.h
index 7bcf925b6912..d23ed472eaac 100644
--- a/options.h
+++ b/options.h
@@ -100,6 +100,7 @@ extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
 extern int Wflexible_array_array;
+extern int Wflexible_array_nested;
 extern int Wflexible_array_sizeof;
 extern int Wimplicit_int;
 extern int Winit_cstring;
diff --git a/sparse.1 b/sparse.1
index c1a74153c618..9b1a59c6b9d4 100644
--- a/sparse.1
+++ b/sparse.1
@@ -264,6 +264,13 @@ Sparse issues these warnings by default. To turn them off, use
 \fB-Wno-flexible-array-array\fR.
 .
 .TP
+.B -Wflexible-array-nested
+Warn about structures containing a flexible array being contained into
+another structure, union or array.
+
+Sparse does not issue these warnings by default.
+.
+.TP
 .B -Wflexible-array-sizeof
 Warn about using the sizeof operator on a structure containing a flexible array,
 possibly recursively.
diff --git a/symbol.c b/symbol.c
index 02b9066e966a..a9f646eb053f 100644
--- a/symbol.c
+++ b/symbol.c
@@ -197,6 +197,10 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 				info.max_align = member->ctype.alignment;
 		}
 
+		if (has_flexible_array(member))
+			info.has_flex_array = 1;
+		if (has_flexible_array(member) && Wflexible_array_nested)
+			warning(sym->pos, "nested flexible arrays");
 		fn(member, &info);
 	} END_FOR_EACH_PTR(member);
 
diff --git a/validation/flex-array-nested.c b/validation/flex-array-nested.c
index 3503c329d7c3..63767683c56a 100644
--- a/validation/flex-array-nested.c
+++ b/validation/flex-array-nested.c
@@ -21,7 +21,6 @@ static int foo(struct s *s, union u *u)
 /*
  * check-name: flex-array-nested
  * check-command: sparse -Wflexible-array-nested $file
- * check-known-to-fail
  *
  * check-error-start
 flex-array-nested.c:6:8: warning: nested flexible arrays
-- 
2.28.0

