Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FDBC43457
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972852225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiD6NvLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgJSQMi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgJSQMi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0244C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p5so14728603ejj.2
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJjGEijVEjKo6kAdm2Le4F1XCtWuym+9/UfsGOO/5ds=;
        b=GiD6NvLGtC2kkCFRM251FUkqAenyZAel+T1OKOMWm4U3jsGc/KjHPVUchWiEkiNjsF
         npFqaO9uhJ6ZTJkGp+QEzSVQ+XAhV5CvKnJMJHHto/nRlIJ+cAI7pZoJlGea8QOtksvX
         YRZ4Uwpl4B8XRLuZfLX+Go8iK/83V6DsBDp5C4V68+YLkZpwpQ4kBZ44eIPDcDCVaY/X
         6knk1Utb7yQQD/ad0gUnPQKkAmyv8g5xICpTnPkqCG26/4W8nFjqnkF+HJ7+iJIb7Lq6
         S6lLYn+jfEqvQxG1AmGf8oFH4XWSJJM0WmUGM8r1yJF3tfe4JhU/JSZSELJvKUrHJwg0
         nKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJjGEijVEjKo6kAdm2Le4F1XCtWuym+9/UfsGOO/5ds=;
        b=NKyRUNl3N18P1bgWSpnd9VUXIkgaxyW52irBfriRr0dhVSCxtWuREP702D9p1tLDc4
         aw0YP8w/OJkOJlTEIVP5YEA6tjevk9YxigsEmTOViNldDRL91x2DKH9zze3sScLvHXUB
         ypqf8z/Pc4IqyDLXStsMrb4bLlw+7LizfnnChKzvHdeteS14Q2539YOrgseErGwu1OmR
         wfGLFYCPcPVqtQzK/PDJ/xJ8WtuLKVi4HSlyjvgIWckhn+SkRtpLoVXxD8aABDHKnM0V
         IigbLCKwB4DSnRg9hEjsZP3tZayJnhIeu0ORxSsG19gJKsaiRNKWdLvLXlC+ZKcUvrPv
         uGyg==
X-Gm-Message-State: AOAM531+qtVYVZZOCVMJEMBZIV1Re/VnSDqBJiRGrannUjZBnwqKOMRf
        jI5DT4Sp8UNXxd3IspnNfwEuqahDuHU=
X-Google-Smtp-Source: ABdhPJyqXejYZEclSG34YCLozR49y4p6YmGK7uTscd4agYvmZF4MH9QoDW6jlEjHS/nIFiOWuR8eRQ==
X-Received: by 2002:a17:906:a0cb:: with SMTP id bh11mr656280ejb.314.1603123956464;
        Mon, 19 Oct 2020 09:12:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 02/12] builtin: add builtin type for volatile void *
Date:   Mon, 19 Oct 2020 18:12:16 +0200
Message-Id: <20201019161226.97429-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
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

