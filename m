Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CB9C43467
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A321B20897
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia5MSPo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbgJQW4n (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439817AbgJQW4n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA346C061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so2892055ejw.7
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJjGEijVEjKo6kAdm2Le4F1XCtWuym+9/UfsGOO/5ds=;
        b=ia5MSPo8HxcOxNYPLSr0uVE+sN5iMb0ugczcsz/vRVps5AyfSHmj1txe1SAIdoobGi
         TjTiQx5rkxGv8yEfn1ue53buSWG1jMGOrocdZ5Jn87t7DvRvR7Fszpexb0Lomt9kxFds
         kYQGH0fgjeAA4L5PvtgUHhvgMlUWPIP76mGZsvrAW1mw46YWtC0je5AaMYOGTQrxh/bp
         yk+e+1iUtWGDJ8oWPd+veyn+aKiPIsMD+VaTD6BpwMls1Ps9kVGW3u0u5Yr5cyFA2e8I
         Om8d9BzrNuEqdz2Z/NPIvx5SmEndaSm7B/AtpqD4XDtiihEnUjeulwgpo0r9FQLPGwiO
         eYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJjGEijVEjKo6kAdm2Le4F1XCtWuym+9/UfsGOO/5ds=;
        b=rWm20AIglH39fBBkcXgwaRL4ai5+TEIQpI6iSqIeqCFuwURdfpTLGwocXZM/KKJyj6
         rJW5O/y8rEg1jDzKFNoesTA6JDmrAauKMYOwRrZIB8NbiOoFIsiohU7OYusqQgqr101a
         s046RK4Wgv1bWQDZMs6y0Uhfvh+5kCemypA3BQJhkly6htESvKVIjzrAcqH13O4eKu7Q
         27ZdiNEoZG2l6mjyaykZa0CJtkp10tePtLYXBkpbP8eyvyKlnAUbEslDyEYkZMaunAiW
         iLo3ErjSwiFXScW0jUMCJQvULTh7b5ndguD0Ne9FpY2OOKyjVPPL8A4LDoUeo697sy/U
         s4aw==
X-Gm-Message-State: AOAM532vzpoWN7mPKLxy8jBEjSo+BxH5sVcQaCR/NJIjpLsns/r22Z8C
        houAPrL+jmoB+LGYYEii6c2jwPz47H0=
X-Google-Smtp-Source: ABdhPJxwwEYZUp4nYR37DpYHjy5uorwW5kCgZv36Tml8FtSfG28henNT6QdP60MTcHVXhbsjcUkYHw==
X-Received: by 2002:a17:906:3b8e:: with SMTP id u14mr10212432ejf.127.1602975399952;
        Sat, 17 Oct 2020 15:56:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/12] builtin: add builtin type for volatile void *
Date:   Sun, 18 Oct 2020 00:56:23 +0200
Message-Id: <20201017225633.53274-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is the type of most __sync_* or __atomic_* builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 3 +++
 symbol.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/symbol.c b/symbol.c
index 5e7f07969f96..ec514eb45df4 100644
--- a/symbol.c
+++ b/symbol.c
@@ -805,6 +805,7 @@ struct symbol	float128_ctype;
 struct symbol	const_void_ctype, const_char_ctype;
 struct symbol	const_ptr_ctype, const_string_ctype;
 struct symbol	const_wchar_ctype, const_wstring_ctype;
+struct symbol	volatile_void_ctype, volatile_ptr_ctype;
 
 struct symbol	zero_int;
 
@@ -909,6 +910,8 @@ static const struct ctype_declare {
 	{ &const_void_ctype,   T_CONST(&void_ctype, NULL, NULL) },
 	{ &const_char_ctype,   T_CONST(&char_ctype, &bits_in_char, &max_int_alignment)},
 	{ &const_wchar_ctype,  T_CONST(&int_ctype, NULL, NULL) },
+	{ &volatile_void_ctype,T_NODE(MOD_VOLATILE, &void_ctype, NULL, NULL) },
+	{ &volatile_ptr_ctype, T_PTR(&volatile_void_ctype) },
 	{ NULL, }
 };
 
diff --git a/symbol.h b/symbol.h
index e75ea3abfcd3..97c608e84704 100644
--- a/symbol.h
+++ b/symbol.h
@@ -310,6 +310,7 @@ extern struct symbol	float128_ctype;
 extern struct symbol	const_void_ctype, const_char_ctype;
 extern struct symbol	const_ptr_ctype, const_string_ctype;
 extern struct symbol	const_wchar_ctype, const_wstring_ctype;
+extern struct symbol	volatile_void_ctype, volatile_ptr_ctype;
 
 /* Special internal symbols */
 extern struct symbol	zero_int;
-- 
2.28.0

