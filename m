Return-Path: <SRS0=/orK=BC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E32C433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68EA20792
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1tGjZvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgGWXqx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgGWXqw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B36C0619D3
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:52 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so5735861edb.11
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPsyU1n8ZQ5VfNOjzlC2B5oiSHtFFi4AIZfwcOsCEDU=;
        b=M1tGjZvj8lGGcHOppJ1FE1ehVZYeN5h2nD/GzvGZ4IxbYfWjc3zLN0osqZTXsNsd8U
         25WTYv2All2jr0pf2j3M5TkeVFLdG1CK+gWkRDdX3U3mcOUGLI12WRF1T/5e+YvGfGGJ
         GoyzYkJYTAP2r9JJzPlxVq9dDBn9W07AQaQAT9HyKTWydo/Qe8T+QlgSMgIv4STusQJg
         Vv7YOmhLjwtM2dkOwlaXjAxEi1P6KLOHrssuad7AKjDwbOILDLe+AUVDQ+xHx/InCS0+
         pSaeN13nsFnddj0wwbwC0bddikf4+lRF3iua5rco1a/rdcP7vGvrOSwXoM9u0CGuCbFv
         WNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPsyU1n8ZQ5VfNOjzlC2B5oiSHtFFi4AIZfwcOsCEDU=;
        b=aESYZncbRkwhR/5PwiapJYUR0gR+szoRh7KG1FXVZTQ/VmthxtInbfKiV2lpFspSau
         sOHNQRkokPaBqCmmo3+w3nwJaTTCmSRK03g1a7Lo302m1/sMRKYs4eF+ny3/AU1HJhfy
         swEcAt2ead9TksPHXRkkOEC6YU8Hg8R7HJ4eYKwitY8HhULhgpQ+vUgAuHI92gugmqm8
         YxcoXIEPeB+2ImMpr27emjc7UWkNXpXk4psRMBvWqac3MDZq7R5bIxJvsSUC1RF4Bp4X
         xX36w4wqooRiBbsj8paxVnp7dueOU94HcktZAGC4YoGW+fLWyrUQh2/8TbNPeEQQOI12
         u/6w==
X-Gm-Message-State: AOAM533e7+8Y2tiMVBv2K+hdIOfWdOTl1BmjUqjVHfppFvdA06RTbNou
        S9PGq7h3PsxIxChkBt0a87iYWrgT
X-Google-Smtp-Source: ABdhPJwjzwKfhxjB2xztaVVOTtCKv6lIWOBUN5/K+KHPCTKNNHThrtfywEHURG5f8cUqvTQkKaJl5A==
X-Received: by 2002:a05:6402:b2b:: with SMTP id bo11mr1483504edb.154.1595548010857;
        Thu, 23 Jul 2020 16:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:a981:5f61:c34f:8c32])
        by smtp.gmail.com with ESMTPSA id bq8sm3086975ejb.103.2020.07.23.16.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:46:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] allow [*] in array declarators
Date:   Fri, 24 Jul 2020 01:46:41 +0200
Message-Id: <20200723234641.78462-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
References: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Since C99, a '*' is allowed in an abstract array declarator to
specify that the array is a VLA with a yet-to-be-determined size.

So, accept this construction (but still ignore it for now).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                                     | 7 ++++++-
 validation/abstract-array-declarator-star.c | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index c7ca3dce7f6b..6db70f1a95e9 100644
--- a/parse.c
+++ b/parse.c
@@ -1717,7 +1717,12 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 		has_static |= (sym->op->type & KW_STATIC);
 		token = token->next;
 	}
-	token = assignment_expression(token, &expr);
+	if (match_op(token, '*') && match_op(token->next, ']')) {
+		// FIXME: '[*]' is treated like '[]'
+		token = token->next;
+	} else {
+		token = assignment_expression(token, &expr);
+	}
 	sym->array_size = expr;
 	return token;
 }
diff --git a/validation/abstract-array-declarator-star.c b/validation/abstract-array-declarator-star.c
index fdbdff19840d..fc42da3ae6c9 100644
--- a/validation/abstract-array-declarator-star.c
+++ b/validation/abstract-array-declarator-star.c
@@ -5,5 +5,4 @@ void ok9(int a[const volatile restrict *]);
 
 /*
  * check-name: abstract-array-declarator-star
- * check-known-to-fail
  */
-- 
2.27.0

