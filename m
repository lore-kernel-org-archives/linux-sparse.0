Return-Path: <SRS0=DkR5=BU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D72C433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 05:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D359920756
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 05:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcdQbpqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgHJFwl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHJFwl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 01:52:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDBC061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 22:52:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cq28so5312113edb.10
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0viSgBlHPk6+6LsbISAusY3ftBd48wbGubihAm6YeI=;
        b=EcdQbpqA+kF10CTy76z6hF9a2octcvKVccq399lPjSQ/6BUnNHHYr+AKm/e/Qlo0+9
         iaxpNHbFNDP14W2PL3aCb0CWELCWMYMVJqaJxGJXQF2AFOylW4h64iIyS4n4yUxpSrOU
         FbHmhqx4Dok1DKhnZu9HtPpmGCYTDFZz3XoNvUOZmgYjqWvM2rI5L8zP1ze55LKLufuZ
         yL6BvzOK6vPnC9BypKLzW4NaXCpsgSZUS0GvQXbZaN43wh+KZ2wVpUBpBSZ9v/y7ktB2
         5cSxY5SxcQYiEZO/+wP9twH6rG+0faoF69Y1I1/s7KGj3e8whthwnPmRZS533qwST6lT
         UMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0viSgBlHPk6+6LsbISAusY3ftBd48wbGubihAm6YeI=;
        b=sKgMbdsqWobkVJOcyspcjdqoCmU4BC5Pd7cEE52efL3FsRi4APfNjheDzZuRUe/BRH
         vFbNTkTPdpE0l3gj9tnaL9y0L4dOWOxLdC8rkZG2ASolKVuJKv7O9zR/eHUUxY4Kx8ok
         qGzhsvBAII3qM3z+sBsNvc7mWPJmiuw+qnnArIj0562+2v3IBIey6/vQRAyn7RlSG5Qs
         ojGwiMOaDsHIhOXQSqFKtEeA7J8wytYjDUhgO9ESbHTStrHDxtGbSi2macE+osLN9jlM
         fgZVZANqXLmVXRSnnKS76S2CDVg0jUaGewgKbCxmxTr1Wt42pzHy/aSCx/Gioat/hbWk
         5c9g==
X-Gm-Message-State: AOAM532no56dZxdWoFERvw76BGFglEL8f6zc27ZgI0l6ItjvgnA8n9c2
        w7pvshJkJkH/vj+uUDUr+OXp0SBG
X-Google-Smtp-Source: ABdhPJxZtKUJ+f4kXJSB3RdkA+hggZv8VQ0/dhSDh5e65Be0SowxpgjM9toACb+UE2eET3Vnclyoag==
X-Received: by 2002:a05:6402:1282:: with SMTP id w2mr18754599edv.183.1597038759352;
        Sun, 09 Aug 2020 22:52:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:51c4:32a8:154e:2fc3])
        by smtp.gmail.com with ESMTPSA id d19sm12319537ejk.47.2020.08.09.22.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 22:52:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] warning: conditionalize "advancing past deep designator"
Date:   Mon, 10 Aug 2020 07:52:33 +0200
Message-Id: <20200810055233.68045-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The warning "advancing past deep designator" is issued when a
multi-level (deep) designator is followed by a non-designated one.

But it's far from clear what is the value of this warning, what
could be the confusion about this situation and what is special
about these 'deep' designators?

There are hundreds such occurrences in the kernel (394 in the configs
I use for testing) and GCC, clang and sparse have no problems to handle
them correctly. This means that there is also 0 chances that they
will be 'corrected'.

So, add conditionalize this warning with a '-Wpast-deep-designator'
and make it false by default.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 ++--
 options.c  | 2 ++
 options.h  | 1 +
 sparse.1   | 7 +++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 9990b57bba78..794f8425f064 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2614,7 +2614,7 @@ static void handle_list_initializer(struct expression *expr,
 		int class, struct symbol *ctype, unsigned long mods)
 {
 	struct expression *e, *last = NULL, *top = NULL, *next;
-	int jumped = 0;
+	int jumped = 0;	// has the last designator multiple levels?
 
 	if (expr->zero_init)
 		free_ptr_list(&expr->expr_list);
@@ -2647,7 +2647,7 @@ static void handle_list_initializer(struct expression *expr,
 					ctype->ident ? ": " : "",
 					get_type_name(struct_sym->type),
 					show_ident(struct_sym->ident));
-			if (jumped) {
+			if (jumped && Wpast_deep_designator) {
 				warning(e->pos, "advancing past deep designator");
 				jumped = 0;
 			}
diff --git a/options.c b/options.c
index f7e81b84d749..9538a2171d33 100644
--- a/options.c
+++ b/options.c
@@ -113,6 +113,7 @@ int Woverride_init = 1;
 int Woverride_init_all = 0;
 int Woverride_init_whole_range = 0;
 int Wparen_string = 0;
+int Wpast_deep_designator = 0;
 int Wpedantic = 0;
 int Wpointer_arith = 0;
 int Wpointer_to_int_cast = 1;
@@ -850,6 +851,7 @@ static const struct flag warnings[] = {
 	{ "override-init", &Woverride_init },
 	{ "override-init-all", &Woverride_init_all },
 	{ "paren-string", &Wparen_string },
+	{ "past-deep-designator", &Wpast_deep_designator },
 	{ "pedantic", &Wpedantic },
 	{ "pointer-to-int-cast", &Wpointer_to_int_cast },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
diff --git a/options.h b/options.h
index 070c0dd87183..90358752f213 100644
--- a/options.h
+++ b/options.h
@@ -112,6 +112,7 @@ extern int Woverride_init;
 extern int Woverride_init_all;
 extern int Woverride_init_whole_range;
 extern int Wparen_string;
+extern int Wpast_deep_designator;
 extern int Wpedantic;
 extern int Wpointer_arith;
 extern int Wpointer_to_int_cast;
diff --git a/sparse.1 b/sparse.1
index 60203d5a6463..34e66088f307 100644
--- a/sparse.1
+++ b/sparse.1
@@ -345,6 +345,13 @@ Standard C syntax does not permit a parenthesized string as an array
 initializer.  GCC allows this syntax as an extension.  With
 \fB\-Wparen\-string\fR, Sparse will warn about this syntax.
 
+Sparse does not issue these warnings by default.
+.
+.TP
+.B -Wpast-deep-designator
+Warn when, in a initializer-list, a initializer with a deep (nested)
+designator is followed by a non-designated one.
+
 Sparse does not issue these warnings by default.
 .
 .TP
-- 
2.28.0

