Return-Path: <SRS0=SlCC=AS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E1EC433E0
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Jul 2020 23:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295792067D
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Jul 2020 23:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU2HKzTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgGGXta (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgGGXt3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Jul 2020 19:49:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C66C061755
        for <linux-sparse@vger.kernel.org>; Tue,  7 Jul 2020 16:49:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so48527561ejb.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Jul 2020 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDDfCIxyrrcX4p7j6JYK+t3XmT6KSqOZ6cVBNdk2Jkc=;
        b=CU2HKzTHKUxZygFiJ+mzQGak/Zjjlxkb7q/RlhVNMX6zpYWevFK/eg7DP5ovoGN8gR
         XKIOnSWSU7rqYFiKO1DMtO0G///e7HaOXGFMwwDcqR0gRbVo+iUGDwa/f5QPx77mcQjy
         KAP5nGiT8tFEs2n4t79YtRskvqP/QOCFVmbEJqgLhHBpuWYb3wJEgP+0aQNSmxeuH2x0
         bGRe4IF10nwYq9t0mc/Dsk/kuXtzUu++xu0a7PhrEVonBeyNumlFnXOVBaIr/Mhy40jK
         6ohwkyWziDmdBYHhJCutPbYDCk/RtuBkI9Q3rZoh3tQG9IfnGcv6TNdTOzSwj8+GMCpY
         ht3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDDfCIxyrrcX4p7j6JYK+t3XmT6KSqOZ6cVBNdk2Jkc=;
        b=GUvBo3x86iQqZKcJk0kSq9TidoQy+OZMX0gOXKNrNQnOEPp9JwB9HVK9AwOojZvPkD
         VrThlUlV3urSZZUkdVnmB1no8ZkzxE+l68+cqgCLskDASu9kjMiR2wSldG3fGC8qYvuN
         RnqwCl5YXMpWYbBaMNaIx0DlQn/zQTXKiueHyB533M7/hRGr9BVsbSgNZCeVn7M5R6b4
         EgEd61WO5o3zj1PXAsn/yxLuzUfa25P5WJD5qOXeloylKzfqEJi7b/y6H0BjtEzDhkIN
         UCZ6GwtjjTnPc7Drfol/YuomV6zmX7GSZcNsymb1F0Fjo/EHqPMSckpBrxhNcVjr8wLk
         a/1g==
X-Gm-Message-State: AOAM530jp90zO1jh+YVlSXfy+Z/6tD0z1zDVGh8CH5v4Lyi8Fthudt0f
        0A4Z/plorzyk07X1Wq8iWtS/TC8B
X-Google-Smtp-Source: ABdhPJzNWqVt/oFulbL7xpYNQaQjI30ty9s2jVV30AJOzHtzD14rRj3aamR6fYix7wFIw5SJcCmoQw==
X-Received: by 2002:a17:906:240d:: with SMTP id z13mr46823177eja.346.1594165766685;
        Tue, 07 Jul 2020 16:49:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:9501:ad60:97b5:4cc9])
        by smtp.gmail.com with ESMTPSA id g22sm26172348eds.67.2020.07.07.16.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:49:25 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] c2x: message in _Static_assert() is now optional
Date:   Wed,  8 Jul 2020 01:49:22 +0200
Message-Id: <20200707234922.73866-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It seems that in the next version of the standard, the
second argument of _Static_assert() will be optional.

Nice. Let sparse already support this now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                    | 24 ++++++++++++++++--------
 validation/static_assert.c |  5 +++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/parse.c b/parse.c
index a9222e7cbf08..bd8989ca8dd4 100644
--- a/parse.c
+++ b/parse.c
@@ -2223,17 +2223,25 @@ static struct token *parse_static_assert(struct token *token, struct symbol_list
 	token = constant_expression(token, &cond);
 	if (!cond)
 		sparse_error(token->pos, "Expected constant expression");
-	token = expect(token, ',', "after conditional expression in _Static_assert");
-	token = string_expression(token, &message, "_Static_assert()");
-	if (!message)
-		cond = NULL;
+	if (match_op(token, ',')) {
+		token = token->next;
+		token = string_expression(token, &message, "_Static_assert()");
+		if (!message)
+			cond = NULL;
+	}
 	token = expect(token, ')', "after diagnostic message in _Static_assert");
-
 	token = expect(token, ';', "after _Static_assert()");
 
-	if (cond && !const_expression_value(cond) && cond->type == EXPR_VALUE)
-		sparse_error(cond->pos, "static assertion failed: %s",
-			     show_string(message->string));
+	if (cond && !const_expression_value(cond) && cond->type == EXPR_VALUE) {
+		const char *sep = "", *msg = "";
+
+		if (message) {
+			sep = ": ";
+			msg = show_string(message->string);
+		}
+		sparse_error(cond->pos, "static assertion failed%s%s", sep, msg);
+	}
+
 	return token;
 }
 
diff --git a/validation/static_assert.c b/validation/static_assert.c
index dd5e0c08c044..0ab5844edef1 100644
--- a/validation/static_assert.c
+++ b/validation/static_assert.c
@@ -53,6 +53,10 @@ _Static_assert(1, );
 _Static_assert(, "");
 _Static_assert(,);
 
+// C2x's version: without message
+_Static_assert(1);
+_Static_assert(0);
+
 /*
  * check-name: static assertion
  *
@@ -67,5 +71,6 @@ static_assert.c:52:19: error: string literal expected for _Static_assert()
 static_assert.c:53:16: error: Expected constant expression
 static_assert.c:54:16: error: Expected constant expression
 static_assert.c:54:17: error: string literal expected for _Static_assert()
+static_assert.c:58:16: error: static assertion failed
  * check-error-end
  */
-- 
2.27.0

