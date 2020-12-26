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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74087C433E6
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477C020809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgLZRxU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLZRxT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FFFC061796
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q75so5687657wme.2
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwLxfE7uXS2gjxFHIROlHvoXuyp2AwlqFqstUvCTsew=;
        b=oNutV2WpPqjay/6nt3epmXo6db4L3gkj7RHWDVPxN1fa7xJ/2sQUISJEUQY7RPwuaZ
         UC/stzGW1Aiddcat5EVI/vL9p74oRK60M80nyB+8TPkKLCUKqDdb2USbpifdtukoxqBr
         hWXwVXGCGm3aZI+0YKJsK8pKOI+HLug5wDTDnPxGvbjJumjK3v8xjM9xDwUbQKRoZif7
         Iet2/meJk2w4eiblSC0H0J2eaRq6SqVBfv9tujE9gkCFXASCOoM1JJ67gB/xCRcE8k5S
         +QGSaVChkfrSmm3rIXPVdDypDIFEFBq6MCPZyagAHbFfZBgIsjehozfuW0UsaGrPuupo
         em1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwLxfE7uXS2gjxFHIROlHvoXuyp2AwlqFqstUvCTsew=;
        b=OjZBZe9fb7UY0fqb07Q8DezG8pRPXpYz0CxrZ56a6OHs/De+r7v5L1WaYc6IBNPZl2
         yvis1OcZm3xcDY7wNJfBuKs8daeaqECO1pmUbJ3DQ6RuDiIFMEA1HmyRmyxXzGjogQ1U
         3uy6YRkQu4qeLRnWit7/RPV22GQLOyxYQiYg1whA5YNTxlXX5qnH/8CZDjhkWjOxlp3l
         Y8papujT4mWSKcNY+GFkOTcSd3CPHLk+MSUEBLRhK2ihuhyWWSqqY00SjZwAgbyyy95r
         W795YcPnoOY4e7SLE0YZybTahAwjRHECQR4sZxdBzEfK3TOPQy6TvIL/3fe7ljABwlvC
         6dwg==
X-Gm-Message-State: AOAM530x4pqw6o/Fit8By9tH3f8qM7g20lHAEyU2rG1L2odM8TM/krTl
        4kHBUh7XWVpYcBqSEhic8a3Q9mFK++Y=
X-Google-Smtp-Source: ABdhPJz+6k1kJhowDdfC+Fxrzt6541ZgvEyCbBQEvkZD+41k8aURhdDe1Zx0RLouMbSaw/zywwlITw==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr12861803wmh.131.1609005122843;
        Sat, 26 Dec 2020 09:52:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 07/16] apply_ctype: use self-explanatory argument name
Date:   Sat, 26 Dec 2020 18:51:20 +0100
Message-Id: <20201226175129.9621-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
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

