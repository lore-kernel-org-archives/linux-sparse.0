Return-Path: <SRS0=D4es=BS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88BDC433DF
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9834720716
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUMfylmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgHHQMA (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQMA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:12:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AADBC061756
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:11:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so5146156ejb.11
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Icp4hhn0az23eIZYVDnmbGyHTZnxC2AyA0XHZdihlQc=;
        b=pUMfylmDLtIzZd6/L5DwgCmbsX2jE7bg8gsNnmOEn2xQHCMeFuFjHcyLmr7m02qQmk
         UrU9LkWns3D7dMkpKGnlaEsbarxUbxSYrD2tzIt72Kpa+v7fPgbBea/Oe5HtqZFd5tfS
         Lx+TOpYw1m2s6iXOuP54oRz82HFFDcdpSxa1OxPYZkJzq7C+HQxNxCFv0a3H57NuWafr
         NaIurrrR9hFJWnTfoE4UsLxpZBbw6efHzhO7MInEcBFiSWUd77O1dl6T2XPwbOLbEo/m
         sVttbxMEl3aBN+WJpe9ONu4cWFdkvUFURZR/h3t079bmkZ+EVSdkqxp1MRxoaCvjadfr
         Murg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Icp4hhn0az23eIZYVDnmbGyHTZnxC2AyA0XHZdihlQc=;
        b=dsnkkN1Rvdx6FKcGPVwSHqcnbN3cQyFyMV7lOZYRzdWui5gi3Vt/ETw1axEVD7jMqq
         kTd4h1G/LiEilJumGYfw7g41sC9G5xSeP8QwvFf2ONnUDDk/TVtq84nGTe1bDj2bLs8M
         fQF/5IRBMDt9VB3Ko1twP0wKZE68o9TYUbLdZxfovZhQlS8t9oCDv+vg8Tm3INYrnC2D
         kR5EOL8kCXIHT/rvVbvoqhLMXVGlI9diwARHmPvip2TpuEt7dngV5wsmXb867N8CrcRX
         8v6FtyJdFI4y1bmbZc6rf8Yq7Be9lsD9lc9b42P+1dSo0SPJDJa4Y9LGaESJ8F+FIUUT
         Y9SA==
X-Gm-Message-State: AOAM530uA7dVSSd2oPuPG6VuC5ZEmyQsRREV53XsFcE+F1IHgibHP8Sv
        xiDhcaRKHfVFsbo/MeFgj5u9XGz2
X-Google-Smtp-Source: ABdhPJy1zMA4Qp2l36qxf2gQ3PfI9gLlNW5Vah/WpV3vZ3DQay+OWB9/0YsgQ7n2xfYYTzs1atdl5w==
X-Received: by 2002:a17:906:260f:: with SMTP id h15mr14304554ejc.48.1596903117896;
        Sat, 08 Aug 2020 09:11:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id g25sm8145725edp.22.2020.08.08.09.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:11:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] wstring: add support for examination of string initialization
Date:   Sat,  8 Aug 2020 18:11:40 +0200
Message-Id: <20200808161143.28272-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
References: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The examination of a string initializer doesn't know about wide
strings. The only thing needed is if the base type is some kind
of char but for wide chars, this type is the same as 'int' and
an array of ints can't be treated the same as an array of chars.

So, do the detection for wide string initializers as:
1) check that the LHS base type is wchar_ctype
2) check that the RHS is a kind of string expression
   (possibly between braces or parenthesis, recursively).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/symbol.c b/symbol.c
index 6fcb1b150d27..7f0c85580f06 100644
--- a/symbol.c
+++ b/symbol.c
@@ -307,6 +307,29 @@ void merge_type(struct symbol *sym, struct symbol *base_type)
 		merge_type(sym, sym->ctype.base_type);
 }
 
+static bool is_wstring_expr(struct expression *expr)
+{
+	while (expr) {
+		switch (expr->type) {
+		case EXPR_STRING:
+			return 1;
+		case EXPR_INITIALIZER:
+			if (expression_list_size(expr->expr_list) != 1)
+				return 0;
+			expr = first_expression(expr->expr_list);
+			break;
+		case EXPR_PREOP:
+			if (expr->op == '(') {
+				expr = expr->unop;
+				break;
+			}
+		default:
+			return 0;
+		}
+	}
+	return 0;
+}
+
 static int count_array_initializer(struct symbol *t, struct expression *expr)
 {
 	int nr = 0;
@@ -321,6 +344,8 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 	 */
 	if (t->ctype.base_type == &int_type && t->rank == -2)
 		is_char = 1;
+	else if (t == wchar_ctype && is_wstring_expr(expr))
+		is_char = 1;
 
 	switch (expr->type) {
 	case EXPR_INITIALIZER: {
-- 
2.28.0

