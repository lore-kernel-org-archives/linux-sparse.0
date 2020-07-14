Return-Path: <SRS0=VjVX=AZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C663AC433E5
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DA4208C3
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6NaqRFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGNAAj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGNAAh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 20:00:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FAFC061755
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so15339257edv.6
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/VQwngYpGiIKM3z6vQHQXJFb74Za3jXScvIYNdH/sY=;
        b=u6NaqRFnJSKNkA7nVfco8IX0HCPTFCTXzIzNfP4hx4pPG0b62Ebbkma6hluqgQHRi2
         xXu7qCVN+o5ckh0/Bntc2ACNVubntCpU9FSXn4nupq7I55kBAERgBjsqR/FpSLTfo9xm
         cy3LngK37VJOdsFN9ggkGoKgnCiUe8o88ECV0hshMH1S9qt0/8F3tFJddAav9ziRhOpO
         ipcHt2pS59Bi8VjB2IzLnRjEz1I/7u1md2Gkw1L5zeRhuxRAARx0nYTf+ox0AD2qXsp4
         SQWvRkCiUIYZ5XHvgNUql/wGVQu/vifOVG832k5GMmOLGjbX9RAY+GQdXmKpLcnbE3Q6
         +Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/VQwngYpGiIKM3z6vQHQXJFb74Za3jXScvIYNdH/sY=;
        b=Yp5eRVbW9JWR4B6/wg/o3mxjekMlIqR5kpcPp4a0zm9Uj65trD12Nuc3MqK9iVoU4W
         iuM1tRD/oDcIo+zqV4AlCff4AiUD6RgxZKXXcYmVhhPf731WzagaETSHYKngLULlYVmq
         oUhO1Aw9T+KYedT/EVm5rJY1IcAREj6gTyqR3FSBnBBHe30zv6SmTksgCpxWsfdHsTBe
         TaFCmiAUZJyptc1Y9kPEl/rhJ4/R24m4GsdLDCb8z2+/HPkbSyKZOuwj9QnawyglVbvD
         5Nh2kj/TRYI0Ec7YR4oWicEemxC0HtQ8vNQzJvmhm2WbhOCwSQT3VLA+JqmI9yxLafGA
         ocxw==
X-Gm-Message-State: AOAM531B2/rK3F0HqNPUJ3RVa7YqI445VOkTbIiB9ETiA7FvVcA3AGof
        l5wKF3oR04GcERjiWjxY5bkKkv6U
X-Google-Smtp-Source: ABdhPJyDbaCqs6lkK3DtL9Z9y/ETxybqLTmBAvgy1X+41KFUopdOj6FCfNC9CN2vjor8ruyn0XY4Mg==
X-Received: by 2002:a50:f9c9:: with SMTP id a9mr1889522edq.89.1594684836008;
        Mon, 13 Jul 2020 17:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:5931:bb22:b701:e8f6])
        by smtp.gmail.com with ESMTPSA id z5sm7959443ejw.114.2020.07.13.17.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:00:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] warn on empty assignments
Date:   Tue, 14 Jul 2020 02:00:29 +0200
Message-Id: <20200714000030.85886-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714000030.85886-1-luc.vanoostenryck@gmail.com>
References: <20200714000030.85886-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently sparse accepts an empty assignment like:
	a = ;

Make this an error.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c                | 6 +++++-
 validation/bad-assignment.c | 1 +
 validation/empty-assign.c   | 1 -
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/expression.c b/expression.c
index 1160cd9cc593..ecbdd18eb402 100644
--- a/expression.c
+++ b/expression.c
@@ -937,10 +937,14 @@ struct token *assignment_expression(struct token *token, struct expression **tre
 		for (i = 0; i < ARRAY_SIZE(assignments); i++)
 			if (assignments[i] == op) {
 				struct expression * expr = alloc_expression(token->pos, EXPR_ASSIGNMENT);
+				struct token *next = token->next;
 				expr->left = *tree;
 				expr->op = op;
 				*tree = expr;
-				return assignment_expression(token->next, &expr->right);
+				token = assignment_expression(next, &expr->right);
+				if (token == next)
+					expression_error(expr, "expression expected before '%s'", show_token(token));
+				return token;
 			}
 	}
 	return token;
diff --git a/validation/bad-assignment.c b/validation/bad-assignment.c
index 71938db7c4f5..959712beda94 100644
--- a/validation/bad-assignment.c
+++ b/validation/bad-assignment.c
@@ -8,6 +8,7 @@ static int foo(int a)
  * check-name: bad assignment
  *
  * check-error-start
+bad-assignment.c:3:11: error: expression expected before '\'
 bad-assignment.c:3:13: error: Expected ; at end of statement
 bad-assignment.c:3:13: error: got \
  * check-error-end
diff --git a/validation/empty-assign.c b/validation/empty-assign.c
index 48ac626ddaed..d1c3884f71e8 100644
--- a/validation/empty-assign.c
+++ b/validation/empty-assign.c
@@ -6,7 +6,6 @@ static int foo(int a)
 
 /*
  * check-name: empty-assign
- * check-known-to-fail
  *
  * check-error-start
 empty-assign.c:3:11: error: expression expected before ';'
-- 
2.27.0

