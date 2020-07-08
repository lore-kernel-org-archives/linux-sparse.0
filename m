Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05E1C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E8D20720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4DdHCw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGHT1C (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGHT1C (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 15:27:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC6C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 12:27:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so51665534ejd.13
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdXjN4/1FNitTbQxWjzHUKtUNZpGQ07H+bcGTDGUjkM=;
        b=G4DdHCw40wusQk5eQ7Sct+9Ww8Cd2Y0SJHryxX+4sK+cFd4bTWZYtNFTibGCw7kIZK
         8E6Y5wF5aNIv1MLBAsbmYBDfZwg8P5888nRugM0PlZ0NXCvmIV6XOiSaQjOD4F0pAIWL
         cYqgE7UFlMx2TbxpVUTj+6StTpYgyyRYWR+d10EJ6yRdKrbN1QMgWWoFHHsGv2QdET4Y
         6Hb/azqz6WqB8bmcPOet/HOdVW07T6tmq8xozoHwZvrIZGIoxmDZH9qyXw8oiHAXqY76
         Z9xmkFY1VedjqWGVj51sPpzoAmxqmqaHqW7LVZQnUM5CfkEax4jmMyAA/ITVazfM5UgT
         uosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdXjN4/1FNitTbQxWjzHUKtUNZpGQ07H+bcGTDGUjkM=;
        b=mYDDf0dWwYEviEbgn5QRbinGFd46jX1VucP/Ihql6eAyrQ/U10B9qeE57HF3kEL0Rx
         nhCJ6LC8Qmdg/7BVmXjt5FXGyhwVIghUpy721On8Kkyu4R4ygltL6kQmxWwR/zApLPMI
         epWihCSYwQsk5gMCjW+T6/rV/Mxw4OBcinF4m005fKW7GXew5Bu3a04K1YWVrDqG98DM
         6OkqcVR2irbaVoWWhlXNy4vaRg2LY5dqbt7kWE+PjJAyoELyQEP7Z5uDQKVWqpG95c5n
         M9Gw8Do4FH4YnS6XM7mBPXRJdnmqlvqR67OHlXu5JBEsq4XCD/GncwSwwiZ/vWEp0W2j
         kkKQ==
X-Gm-Message-State: AOAM5330QW6pULWU3SorrE3V10hiL2RHMO0e0GAiKvWvFz7KciAyBOiR
        sKbS89Lg3PK4NpZ1/Hb695xmebKG
X-Google-Smtp-Source: ABdhPJw+1WioQDIuoL9YVD55g53GqxjtXvsnuiRPKRyjmSCW//EP2fa6xuswhlA8wAhgU1XY4jfujw==
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr52833466ejb.174.1594236420373;
        Wed, 08 Jul 2020 12:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id cc9sm372970edb.14.2020.07.08.12.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:26:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] keyword: reorder the keywords
Date:   Wed,  8 Jul 2020 21:26:53 +0200
Message-Id: <20200708192654.28097-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708192654.28097-1-luc.vanoostenryck@gmail.com>
References: <20200708192654.28097-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reorder the keywords to make them even more logically organized.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 72 +++++++++++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/parse.c b/parse.c
index 4a2b62974612..c18a9e66e0a8 100644
--- a/parse.c
+++ b/parse.c
@@ -467,6 +467,25 @@ static struct init_keyword {
 	struct symbol *type;
 	unsigned long mods;
 } typedefs[] = {
+	/* Storage classes */
+	{ "auto",		&auto_op },
+	{ "register",		&register_op },
+	{ "static",		&static_op },
+	{ "extern",		&extern_op },
+	{ "__thread",		&thread_op },
+	{ "_Thread_local",	&thread_op },
+
+	{ "inline",		&inline_op },
+	{ "__inline__",		&inline_op },
+	{ "__inline",		&inline_op },
+
+	/* Typedef ... */
+	{ "typedef",		&typedef_op },
+	{ "typeof",		&typeof_op },
+	{ "__typeof__",		&typeof_op },
+	{ "__typeof",		&typeof_op },
+	{ "__auto_type",	&autotype_op },
+
 	/* Type qualifiers */
 	{ "const",		&const_op },
 	{ "__const__",		&const_op },
@@ -477,12 +496,19 @@ static struct init_keyword {
 	{ "restrict",		&restrict_op },
 	{ "__restrict__",	&restrict_op },
 	{ "__restrict",		&restrict_op },
+
 	{ "_Atomic",		&atomic_op },
+	{ "_Noreturn",		&noreturn_op },
+	{ "_Alignas",		&alignas_op },
 
-	/* Typedef.. */
-	{ "typedef",		&typedef_op },
+	{ "__attribute__",	&attribute_op },
+	{ "__attribute",	&attribute_op },
 
 	/* Type specifiers */
+	{ "struct",		&struct_op },
+	{ "union",		&union_op },
+	{ "enum",		&enum_op },
+
 	{ "void",		&spec_op,	.type = &void_ctype },
 	{ "char",		&char_op },
 	{ "short",		&short_op },
@@ -507,39 +533,8 @@ static struct init_keyword {
 	{ "_Float64",		&spec_op,	.type = &float64_ctype },
 	{ "_Float64x",		&spec_op,	.type = &float64x_ctype },
 	{ "_Float128",		&spec_op,	.type = &float128_ctype },
-
-	/* Extended types */
-	{ "typeof",		&typeof_op },
-	{ "__typeof__",		&typeof_op },
-	{ "__typeof",		&typeof_op },
-	{ "__auto_type",	&autotype_op },
-
-	{ "__attribute",	&attribute_op },
-	{ "__attribute__",	&attribute_op },
-
-	{ "struct",		&struct_op },
-	{ "union",		&union_op },
-	{ "enum",		&enum_op },
-
-	{ "inline",		&inline_op },
-	{ "__inline__",		&inline_op },
-	{ "__inline",		&inline_op },
-
-	{ "_Noreturn",		&noreturn_op },
-
-	{ "_Alignas",		&alignas_op },
-
-
-	/* Storage class */
-	{ "auto",		&auto_op },
-	{ "register",		&register_op },
-	{ "static",		&static_op },
-	{ "extern",		&extern_op },
-	{ "__thread",		&thread_op },
-	{ "_Thread_local",	&thread_op },
-
 }, keywords[] = {
-	/* Statement */
+	/* Statements */
 	{ "if",			&if_op },
 	{ "return",		&return_op },
 	{ "break",		&loop_iter_op },
@@ -551,15 +546,15 @@ static struct init_keyword {
 	{ "while",		&while_op },
 	{ "do",			&do_op },
 	{ "goto",		&goto_op },
-	{ "context",		&context_op },
-	{ "__context__",	&__context___op },
-	{ "__range__",		&range_op },
 	{ "asm",		&asm_op },
 	{ "__asm__",		&asm_op },
 	{ "__asm",		&asm_op },
+	{ "context",		&context_op },
+	{ "__context__",	&__context___op },
+	{ "__range__",		&range_op },
 	{ "_Static_assert",	&static_assert_op },
 
-	/* Attribute */
+	/* Attributes */
 	{ "packed",		&packed_op },
 	{ "__packed__",		&packed_op },
 	{ "aligned",		&aligned_op },
@@ -594,6 +589,7 @@ static struct init_keyword {
 	{ "gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE },
 	{ "__gnu_inline__",	&attr_fun_op,		.mods = MOD_GNU_INLINE },
 
+	/* Modes */
 	{ "mode",		&mode_op },
 	{ "__mode__",		&mode_op },
 	{ "QI",			&mode_QI_op },
-- 
2.27.0

