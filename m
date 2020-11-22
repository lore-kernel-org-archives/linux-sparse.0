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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6969BC56202
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3867220773
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iunR62yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKVP1j (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVP1j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:39 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9235EC0613D3
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:37 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so15530006wml.5
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99vJL0KZqnWj49eesnocy4L83k8E63+yml2GC2QpAM0=;
        b=iunR62yd0B2+E+/DU02N/LSIVJdw58uBbeD71DBIxWel9w3RsUFQPwYIfdGdxB949D
         fvdM/creWTjwmshuE8g7IMPHGsXm+XWnaS8KtUtsDe+6jFbg8gM3vyQ04wSp7tO9ePNR
         lr5A8nqSpmg8rEAzcks4/KdV+GKOUkLjtpNPiiVHX/cnsKTkgIS7tRJKnXoZOZ8k5I3b
         Wm9m8ocbrUmUaxLQdN+rmGiPR1vVDU+vSZvSOuPHI86VgK/0c7GXaPKPkA74T6lGRj+r
         TIxI0qVYsM43S1BfWUeXxZ+A2Vw3sPG9BhimrQUDiRzQ6UAr6ve3Bn4KgNP9h7/pl/HJ
         vLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99vJL0KZqnWj49eesnocy4L83k8E63+yml2GC2QpAM0=;
        b=iH2nXuI2G+cENL6y2KbWV7FBs42ET+k0fq+Hrt7ycMv03MpB9ArXKrNB+BhxVWRRyp
         mUixmCwt6b37pIyXvQ48G7x9TDQZUDXW0CnjtGkKSXOR4sJjK7LoqZYslJ/uxARvjzej
         bmrXIBczEfChFfbuQk5cRU3Q4urVhI5JqVIuk6FIMSKkS4+Cu7q8MhRzTYFUdBabEWsK
         rP0kx/9FatMCXMU3kCmLkjO3NbWsbdjt7OuhQU5kz0K89UjBphNJFzmeKyuYS1gu/NzI
         Or65/XvvZR8YkudL6TE4COf//z8s+Px9zsTDH0m8A0rmaMotNHUR6Nn+iQQT6LPtUoSM
         oPjg==
X-Gm-Message-State: AOAM532M+uX2mj8emU369ThtpT9sTLtBbKtgrImOX/Cw0Yl/B0aNPzh3
        qlhCFUbJwPceNJiFI9IhxdZLdakrgvk=
X-Google-Smtp-Source: ABdhPJxeGpEoNzzJXJQWiVSQFlhVtRMAMrW2f60KoJ3kTB3EtML5IrpsQOSTY0MHEgpn8d1ZDVkpvw==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr11945785wmc.156.1606058856085;
        Sun, 22 Nov 2020 07:27:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:35 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/7] canon: put PSEUDO_ARGs in canonical order too
Date:   Sun, 22 Nov 2020 16:27:26 +0100
Message-Id: <20201122152731.10994-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, only binops containing PSEUDO_VAL or PSEUDO_SYM were
put in canonical order. This means that binops containing only
PSEUDO_ARGs or PSEUDO_REGs are not ordered. This is not directly
a problem for CSE because commutativity is taken in account but:
* more combination need to be checked during simplification
* 'anti-commutative' operations like (a > b) & (b < a) are not
  recognized as such.

So, as a first step, also take PSEUDO_ARGs in account when checking
if operands are in canonical order.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          |  3 +++
 validation/linear/pointer-arith32.c | 12 ++++++------
 validation/linear/pointer-arith64.c | 10 +++++-----
 validation/optim/cse-arg01.c        |  1 -
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/simplify.c b/simplify.c
index a0e23d6de01f..c809b832afeb 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1471,6 +1471,9 @@ static int canonical_order(pseudo_t p1, pseudo_t p2)
 	if (p1->type == PSEUDO_SYM)
 		return p2->type == PSEUDO_SYM || p2->type == PSEUDO_VAL;
 
+	if (p1->type == PSEUDO_ARG)
+		return (p2->type == PSEUDO_ARG && p1->nr <= p2->nr) || p2->type == PSEUDO_VAL || p2->type == PSEUDO_SYM;
+
 	return 1;
 }
 
diff --git a/validation/linear/pointer-arith32.c b/validation/linear/pointer-arith32.c
index 531fd2324911..c0163a6f528b 100644
--- a/validation/linear/pointer-arith32.c
+++ b/validation/linear/pointer-arith32.c
@@ -42,7 +42,7 @@ cps:
 .L0:
 	<entry-point>
 	sext.32     %r2 <- (16) %arg2
-	add.32      %r5 <- %arg1, %r2
+	add.32      %r5 <- %r2, %arg1
 	ret.32      %r5
 
 
@@ -51,7 +51,7 @@ ipss:
 	<entry-point>
 	sext.32     %r10 <- (16) %arg2
 	mul.32      %r11 <- %r10, $4
-	add.32      %r14 <- %arg1, %r11
+	add.32      %r14 <- %r11, %arg1
 	ret.32      %r14
 
 
@@ -60,7 +60,7 @@ ipus:
 	<entry-point>
 	zext.32     %r19 <- (16) %arg2
 	mul.32      %r20 <- %r19, $4
-	add.32      %r23 <- %arg1, %r20
+	add.32      %r23 <- %r20, %arg1
 	ret.32      %r23
 
 
@@ -68,7 +68,7 @@ cpq:
 .L6:
 	<entry-point>
 	trunc.32    %r28 <- (64) %arg2
-	add.32      %r31 <- %arg1, %r28
+	add.32      %r31 <- %r28, %arg1
 	ret.32      %r31
 
 
@@ -77,7 +77,7 @@ ipq_ref:
 	<entry-point>
 	trunc.32    %r37 <- (64) %arg2
 	mul.32      %r38 <- %r37, $4
-	add.32      %r39 <- %arg1, %r38
+	add.32      %r39 <- %r38, %arg1
 	ret.32      %r39
 
 
@@ -86,7 +86,7 @@ ipq:
 	<entry-point>
 	trunc.32    %r43 <- (64) %arg2
 	mul.32      %r44 <- %r43, $4
-	add.32      %r47 <- %arg1, %r44
+	add.32      %r47 <- %r44, %arg1
 	ret.32      %r47
 
 
diff --git a/validation/linear/pointer-arith64.c b/validation/linear/pointer-arith64.c
index dad10331b297..7f1aac56bfc2 100644
--- a/validation/linear/pointer-arith64.c
+++ b/validation/linear/pointer-arith64.c
@@ -35,7 +35,7 @@ cps:
 .L0:
 	<entry-point>
 	sext.64     %r2 <- (16) %arg2
-	add.64      %r5 <- %arg1, %r2
+	add.64      %r5 <- %r2, %arg1
 	ret.64      %r5
 
 
@@ -44,7 +44,7 @@ ipss:
 	<entry-point>
 	sext.64     %r10 <- (16) %arg2
 	mul.64      %r11 <- %r10, $4
-	add.64      %r14 <- %arg1, %r11
+	add.64      %r14 <- %r11, %arg1
 	ret.64      %r14
 
 
@@ -53,7 +53,7 @@ ipus:
 	<entry-point>
 	zext.64     %r19 <- (16) %arg2
 	mul.64      %r20 <- %r19, $4
-	add.64      %r23 <- %arg1, %r20
+	add.64      %r23 <- %r20, %arg1
 	ret.64      %r23
 
 
@@ -62,7 +62,7 @@ ipsi:
 	<entry-point>
 	sext.64     %r28 <- (32) %arg2
 	mul.64      %r29 <- %r28, $4
-	add.64      %r32 <- %arg1, %r29
+	add.64      %r32 <- %r29, %arg1
 	ret.64      %r32
 
 
@@ -71,7 +71,7 @@ ipui:
 	<entry-point>
 	zext.64     %r37 <- (32) %arg2
 	mul.64      %r38 <- %r37, $4
-	add.64      %r41 <- %arg1, %r38
+	add.64      %r41 <- %r38, %arg1
 	ret.64      %r41
 
 
diff --git a/validation/optim/cse-arg01.c b/validation/optim/cse-arg01.c
index c3f2963ffdeb..3e3e141aa1fb 100644
--- a/validation/optim/cse-arg01.c
+++ b/validation/optim/cse-arg01.c
@@ -3,7 +3,6 @@ int foo(int a, int b) { return (a < b) == (b > a); }
 /*
  * check-name: cse-arg01
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

