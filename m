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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0581BC46466
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5123207BC
	for <linux-sparse@archiver.kernel.org>; Sun,  4 Oct 2020 11:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhyYdxAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgJDLn5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgJDLnz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 07:43:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6513C0613CE
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 04:43:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e18so589483wrw.9
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWA0bvO/yk9EHABxczcL79Ncy6l/PQ7BULIW/LDq4h8=;
        b=WhyYdxAOK0xv8/7rfOeIabJKXhPLeWM5EsxKlzkYwpAEnfHmcu3Ari/EHa0oJJDivH
         3iCn65jl2AenYwVzRE4WdHknmr00xKsTxGFrowzZi0sVwTYL4d3vZC8uZQ9mtcTvOlKP
         2NqYCONVfshzssJVlR0mtBPUFYw2jVT6ukkEvBWmncrhhyxH9jVRD3KM/KTHWjglPHm9
         WGka4EB6GTqY9/qxUP2QTiMCs3xNo91DA1wzRzPN3o8snZN0Zh5XkSsjKCuEdYsb14CB
         3temqHgzeBQ8zIpe9p7Xka9+mY1MBKVObP9rZPwNCiX5OnGSgizi5vmYde6v6NNmtXfj
         Um+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWA0bvO/yk9EHABxczcL79Ncy6l/PQ7BULIW/LDq4h8=;
        b=Et+xx2xTVp+wLeUyv9NLQ4EAYd0SHRmyaUwoZl2phz38UNKx2RHqkFPAjYN/kMH47m
         llWyFOu94hEv9O8jDQgizM2hAQqzajGrzji951YXqndW5PmGJaX3y/OppuU+AaNR+0hh
         ++MbXXfxybuflmvFBqoR51yZWpjLhPcC0mjWlI6s75woWb/Nf9wTHtZpIwJgmgxj1sbu
         At3F9qfUFqeovAzOtiUt3QoOboe/TXs/STXTdaq7V87XPhiw6LHpX7jEKnSg90WB3Aom
         FPmyNHsCposI9Gy1W2b3NoE3PDYcpJU96lrRGr4PhzTfAisSqT4UwUJ06soZ1FSXGZ6+
         m/0A==
X-Gm-Message-State: AOAM532UUYxZk2Yu8bHOa+s4NhRzb5d9MYrDNMTuTJNdpB1NeRukx4Xa
        m3fP/5HNPn7/n+IEgACHrbPdLQvbaU4=
X-Google-Smtp-Source: ABdhPJzJbSg5LJDbz6GLxSVwB73saX0AqB48FEuQcl7sRI4PcZYPMPpLk/QULVhp1u38rItA+1/h6A==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr12299767wrv.222.1601811833086;
        Sun, 04 Oct 2020 04:43:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id l19sm8244801wmi.8.2020.10.04.04.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 04:43:52 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add builtin type for wide strings
Date:   Sun,  4 Oct 2020 13:43:47 +0200
Message-Id: <20201004114349.81440-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004114349.81440-1-luc.vanoostenryck@gmail.com>
References: <20201004114349.81440-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is needed for printf format checking of "%Ls".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 8 ++++++++
 symbol.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/symbol.c b/symbol.c
index 7f0c85580f06..9065bd527d60 100644
--- a/symbol.c
+++ b/symbol.c
@@ -790,6 +790,7 @@ struct symbol	float64_ctype, float64x_ctype;
 struct symbol	float128_ctype;
 struct symbol	const_void_ctype, const_char_ctype;
 struct symbol	const_ptr_ctype, const_string_ctype;
+struct symbol	const_wchar_ctype, const_wstring_ctype;
 
 struct symbol	zero_int;
 
@@ -884,9 +885,11 @@ static const struct ctype_declare {
 	{ &ullong_ptr_ctype,   T_PTR(&ullong_ctype) },
 	{ &const_ptr_ctype,    T_PTR(&const_void_ctype) },
 	{ &const_string_ctype, T_PTR(&const_char_ctype) },
+	{ &const_wstring_ctype,T_PTR(&const_wchar_ctype) },
 
 	{ &const_void_ctype,   T_CONST(&void_ctype, NULL, NULL) },
 	{ &const_char_ctype,   T_CONST(&char_ctype, &bits_in_char, &max_int_alignment)},
+	{ &const_wchar_ctype,  T_CONST(&int_ctype, NULL, NULL) },
 	{ NULL, }
 };
 
@@ -931,4 +934,9 @@ void init_ctype(void)
 		intptr_ctype = ssize_t_ctype;
 	if (!uintptr_ctype)
 		uintptr_ctype = size_t_ctype;
+
+	const_wchar_ctype.ctype.base_type = wchar_ctype;
+	const_wchar_ctype.rank = wchar_ctype->rank;
+	const_wchar_ctype.ctype.alignment = wchar_ctype->ctype.alignment;
+	const_wchar_ctype.bit_size = wchar_ctype->bit_size;
 }
diff --git a/symbol.h b/symbol.h
index a3ed95678ee5..f82484f5c978 100644
--- a/symbol.h
+++ b/symbol.h
@@ -306,6 +306,7 @@ extern struct symbol	float64_ctype, float64x_ctype;
 extern struct symbol	float128_ctype;
 extern struct symbol	const_void_ctype, const_char_ctype;
 extern struct symbol	const_ptr_ctype, const_string_ctype;
+extern struct symbol	const_wchar_ctype, const_wstring_ctype;
 
 /* Special internal symbols */
 extern struct symbol	zero_int;
-- 
2.28.0

