Return-Path: <SRS0=8Fyo=DL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50DFC4727D
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 11:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8404420797
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 11:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsNIGLbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgJDLn5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgJDLn4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 07:43:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1C4C0613D0
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 04:43:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w5so6494624wrp.8
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g645jW1HvrkOaWRdC8mTnpFArnEqbDXRFYTVr7Juge4=;
        b=dsNIGLbO9hmLWEefRCAb+5zzpGgIe8aSl4h38AolAOL3oISdUn0K+UiiOfeV8/iQZk
         IOVpcTPile8tgD9JClH0ijYViRavucfPRg+ZCO/nznFabFUElp/nAz0BmPIfHYOMj8Ft
         lKM0YwGVImAlZCvAo+RGOqtiZBn+J4MT/eabZ+7jpXioBJPYpKV6ER+dIZHm8QY06jAa
         hMTYQfGpagePBbGvTiNA6w8yRNqxIYLVYi91PnbThS8a2aCVHpN2xHYk7KvAffC9DN7q
         ODVdCa82ODYkSgt6WiquGg5AGn/TVSkiI/huIP41xkxEO58ZnirmqzSA0r6hDMPn/pD/
         Mo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g645jW1HvrkOaWRdC8mTnpFArnEqbDXRFYTVr7Juge4=;
        b=H6hPIea/nySlcPJ9qkxkM6HkN5hngohibktiu6eipSs6XsIGjXQ0xUdokiYmD/Au9V
         RayGYeYwBXGHb8A1taF7N6iJ/h+ALKAJMsc/zR7MOKy+wjSniQ6OHomFgmBifQ0s9QtB
         2s7nKmYCRe3ynhSLPIUlNHZmC/cNyuiHH/OK8li0VFssb5X1pXFBIyu9kqoMKggL6hpR
         cpxyuSAEwqvX+lkHHWjrWOdEqzuJ9Y3oeisBC42SNkSBnMEUeaAW+WnoFQS05UBCmvUY
         1L+wpKCLfkHHC6567QSqmUXaLVMuJizGZqoeY2XSHmyETZLqicjrVoAHFz+eHH7HwveE
         PPjA==
X-Gm-Message-State: AOAM533YlbkB5o0QhAdEFmAI180CZ4wKKfAmWv3a+Q/LyOZjAK5InWti
        zd5LBchCyZWTT8y1eYlpIbhvFo9z4k8=
X-Google-Smtp-Source: ABdhPJxzsYQekmaBKy9TT9rVK1/WyhjXi9HRdRq2zPmw+lLR3p+h8sMckJjcI+C3TDA0qSmifHe49Q==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr12181196wrl.401.1601811834637;
        Sun, 04 Oct 2020 04:43:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id l19sm8244801wmi.8.2020.10.04.04.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 04:43:54 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] add builtin types for size_t*, intmax_t* & ptrdiff_t*
Date:   Sun,  4 Oct 2020 13:43:49 +0200
Message-Id: <20201004114349.81440-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004114349.81440-1-luc.vanoostenryck@gmail.com>
References: <20201004114349.81440-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is needed for printf format checking of "%zn", "%jn" & "%tn".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 8 ++++++++
 symbol.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/symbol.c b/symbol.c
index a29e0b140d16..130071ab0381 100644
--- a/symbol.c
+++ b/symbol.c
@@ -786,6 +786,7 @@ struct symbol	schar_ptr_ctype, short_ptr_ctype;
 struct symbol	int_ptr_ctype, uint_ptr_ctype;
 struct symbol	long_ptr_ctype, ulong_ptr_ctype;
 struct symbol	llong_ptr_ctype, ullong_ptr_ctype;
+struct symbol	size_t_ptr_ctype, intmax_ptr_ctype, ptrdiff_ptr_ctype;
 struct symbol	float32_ctype, float32x_ctype;
 struct symbol	float64_ctype, float64x_ctype;
 struct symbol	float128_ctype;
@@ -886,6 +887,9 @@ static const struct ctype_declare {
 	{ &ulong_ptr_ctype,    T_PTR(&ulong_ctype) },
 	{ &llong_ptr_ctype,    T_PTR(&llong_ctype) },
 	{ &ullong_ptr_ctype,   T_PTR(&ullong_ctype) },
+	{ &size_t_ptr_ctype,   T_PTR(&void_ctype) },	// will be adjusted
+	{ &intmax_ptr_ctype,   T_PTR(&void_ctype) },	// will be adjusted
+	{ &ptrdiff_ptr_ctype,  T_PTR(&void_ctype) },	// will be adjusted
 	{ &const_ptr_ctype,    T_PTR(&const_void_ctype) },
 	{ &const_string_ctype, T_PTR(&const_char_ctype) },
 	{ &const_wstring_ctype,T_PTR(&const_wchar_ctype) },
@@ -938,6 +942,10 @@ void init_ctype(void)
 	if (!uintptr_ctype)
 		uintptr_ctype = size_t_ctype;
 
+	size_t_ptr_ctype.ctype.base_type = size_t_ctype;
+	intmax_ptr_ctype.ctype.base_type = intmax_ctype;
+	ptrdiff_ptr_ctype.ctype.base_type = ptrdiff_ctype;
+
 	const_wchar_ctype.ctype.base_type = wchar_ctype;
 	const_wchar_ctype.rank = wchar_ctype->rank;
 	const_wchar_ctype.ctype.alignment = wchar_ctype->ctype.alignment;
diff --git a/symbol.h b/symbol.h
index d39048cb478d..6d25e7fc8bad 100644
--- a/symbol.h
+++ b/symbol.h
@@ -302,6 +302,7 @@ extern struct symbol	schar_ptr_ctype, short_ptr_ctype;
 extern struct symbol	int_ptr_ctype, uint_ptr_ctype;
 extern struct symbol	long_ptr_ctype, ulong_ptr_ctype;
 extern struct symbol	llong_ptr_ctype, ullong_ptr_ctype;
+extern struct symbol	size_t_ptr_ctype, intmax_ptr_ctype, ptrdiff_ptr_ctype;
 extern struct symbol	float32_ctype, float32x_ctype;
 extern struct symbol	float64_ctype, float64x_ctype;
 extern struct symbol	float128_ctype;
-- 
2.28.0

