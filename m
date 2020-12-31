Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAEBC433E6
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768D5207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgLaKME (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgLaKMD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484DC0617A0
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d13so19673813wrc.13
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwLxfE7uXS2gjxFHIROlHvoXuyp2AwlqFqstUvCTsew=;
        b=VzvyWS5mRl2mpPXxTRSQ2v6mCJx2qPtihXHdFYwzlR+EJANi8SvyRfGiaicxfJao2U
         dBR9/N+RAQ0VmvGRYpVpfVzC5t3mewRau/OYkKT9x3cauyd40uH6isbPXy7MI2RF+9I2
         FBwfwUvNUZFDin8wmbXI+3BWwhAmjXI+1O9VRDJABEH42979ph5weQR2pFkBTkKHu4Vr
         pVx+PDRC0c/YIhGs/Etvs3BlU8BHZ0MC4nb35vHjth1udnZSOW2b60wCopm9XC99w2uW
         oFBppo+GGpcfAEatlu0ftcJsasVb+cZdF1v6bQTNtJu0W5RHgv1vI3dVo4oRJzqjDgva
         fofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwLxfE7uXS2gjxFHIROlHvoXuyp2AwlqFqstUvCTsew=;
        b=JaM+xa2QOu4HLc/VMJNsNBBQYrE93xILDGE4y17GHBMWQ3TdepX120zkbsY8sFZ6Hc
         YhgYqIQDQmPtkVAwRC6bH3V9Dpbzy/yQNAQSEyd9NL+UzHfZos6mdL4VNPPCnoY34P9x
         v8TF1p8iiE9jiM8Yf6vpWn9wlX6/jUBKB2KQAGW2Lb2kSwLGTgQqMWb02K2tGktcoqQa
         7dlWhNn6iUVpT5aYNWL9VuFI8VzH4Z/WGXGNRApzCE1ToOrQR1D5gDC7L7Oi2wMrRVg1
         PDx/pIqX2a5qRw7ig5nnwAejb06SxnI7qXulH2h/OQ6ucOHwcWvku33bkOwwSA22dF3+
         WbfQ==
X-Gm-Message-State: AOAM5312j7tbnO5wuGmrC7eFUnu2FJkzzC9ykEYRSGVvWL6HMNF1bPnX
        lV6rAQR2Wl1j8aJ/89ExL8YRSg1PB6U=
X-Google-Smtp-Source: ABdhPJz/jUpJ/a21Q1uf5P7VexCmS1TMkR/D3YfyXywtDNmOhr5sC+7bapKnLZiLu3q8sE3dlka45g==
X-Received: by 2002:adf:f989:: with SMTP id f9mr63035041wrr.299.1609409446071;
        Thu, 31 Dec 2020 02:10:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:45 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 07/16] apply_ctype: use self-explanatory argument name
Date:   Thu, 31 Dec 2020 11:10:25 +0100
Message-Id: <20201231101034.59978-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

apply_ctype() is used to copy/apply things like modifiers
and address space from one type to another one.
But the names used for the two types are: 'ctype' & 'thistype'
which doesn't help at all to know which one is the 'source' type
and which one is the 'destination' type.

Change this by renaming these arguments to 'src' & 'dst'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/parse.c b/parse.c
index 0b2685707b82..402214212d77 100644
--- a/parse.c
+++ b/parse.c
@@ -1043,7 +1043,7 @@ static struct token *enum_specifier(struct token *token, struct symbol *sym, str
 	return ret;
 }
 
-static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);
+static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst);
 
 static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
@@ -1427,24 +1427,24 @@ static struct token *generic_qualifier(struct token *next, struct symbol *sym, s
 	return next;
 }
 
-static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype)
+static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst)
 {
-	unsigned long mod = thistype->modifiers;
+	unsigned long mod = src->modifiers;
 
 	if (mod)
-		apply_qualifier(&pos, ctype, mod);
+		apply_qualifier(&pos, dst, mod);
 
 	/* Context */
-	concat_ptr_list((struct ptr_list *)thistype->contexts,
-	                (struct ptr_list **)&ctype->contexts);
+	concat_ptr_list((struct ptr_list *)src->contexts,
+	                (struct ptr_list **)&dst->contexts);
 
 	/* Alignment */
-	if (thistype->alignment > ctype->alignment)
-		ctype->alignment = thistype->alignment;
+	if (src->alignment > dst->alignment)
+		dst->alignment = src->alignment;
 
 	/* Address space */
-	if (thistype->as)
-		ctype->as = thistype->as;
+	if (src->as)
+		dst->as = src->as;
 }
 
 static void specifier_conflict(struct position pos, int what, struct ident *new)
-- 
2.29.2

