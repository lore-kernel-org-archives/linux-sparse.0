Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6442EC433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B20206B6
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 11:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7vY5tm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHILtS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHILtS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 07:49:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA9C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 04:49:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t10so2269942ejs.8
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aC5H6Wi9znUtKPZjCQpXS5aa4VlJSjUvsf8r0aRAYw=;
        b=Q7vY5tm3LUXJWN7UL7hr+NAMjIZH0+9NLDCyQCvRO4loOmslkJoJnoOdclw/Xnyyp3
         RzKT9F5Oq+oSKJI6/OeYORdEiQeBPc+vnkY9ttKn3y2e7vK7bGZDM7F1Z3p4D79MYvEP
         935zRTkRjqGipwuaSYJBbj9cGIJuL9SZjTQ4E+p5OUJkZm5cWhrneMSdouRtxcjJ5ODZ
         oA7KNtcokLkQXu5mcWyc1nW6UxbIFgp8s+fzKyB+sbMz4FSV9lohq24H/t8CqM1uUHa9
         Cnhnzgw/XZXKzHuAN6o3grZpKxS0KHLRcjIDuJvQTu6mMS0ck3DFxb8S+cx5f8KOM4pm
         6Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aC5H6Wi9znUtKPZjCQpXS5aa4VlJSjUvsf8r0aRAYw=;
        b=fb5qYcNw2x7MH4nK7Vxqo11Oq0y91oTL7Omp9bj7zBui7tdPBU6kqrWs+3SpboxjCX
         f1y+oazZvahIXmqENYu9KzPOUI4dmVUsiZomsEn5hybDHhdlvfrePAhrPK3iqsHLmAJc
         a2AFYv47XyyN9Jic7QxA6P+KBvreYHMdx09Nx0ZiIuc3Bmz35xaCZ0xfOPWJXRl2rBZL
         wmmZo1iKpZsWzlxBYzNOcZxTulUm6pM1nDjcgAhN2WOnACgCx8WGuFnj2HJoe95KfFUo
         m7Fya0ZaliWZLGmhiwABNTYh2uKJPOIR4OJYNaidJAa2bipQm++RHk1dlVOUkEiAoHjP
         TSbw==
X-Gm-Message-State: AOAM531LvypdxJPrHhapAnXEX6aiNeQutwSMF/L4yrTXkOKvuOIjTsQF
        xlJ0sB5nOOcEMCaiVaZT1Efnkos3
X-Google-Smtp-Source: ABdhPJyhNyVFFXf8cjLSZSSJwvU6eMNH84V6F+MMp0cwDleUOq7hxJPqnBRrFHcyq8gl6mGbv12I+g==
X-Received: by 2002:a17:906:260c:: with SMTP id h12mr18118240ejc.457.1596973756530;
        Sun, 09 Aug 2020 04:49:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:788a:816d:ff27:8087])
        by smtp.gmail.com with ESMTPSA id y26sm9688951edu.96.2020.08.09.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 04:49:15 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix checking if type is void
Date:   Sun,  9 Aug 2020 13:49:10 +0200
Message-Id: <20200809114910.16092-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse warns if a void function returns a non-void expression.

But the check directly compares the returned type with void_ctype,
without taking in account the presence of a SYM_NODE. In
consequence, sparse issues a few false warnings.

Fix this by using is_void_type() to test the returned type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index dddea76182ad..6d5bbca50bb3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3544,7 +3544,7 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
 	fntype = current_fn->ctype.base_type;
 	rettype = fntype->ctype.base_type;
 	if (!rettype || rettype == &void_ctype) {
-		if (expr && expr->ctype != &void_ctype)
+		if (expr && !is_void_type(expr->ctype))
 			expression_error(expr, "return expression in %s function", rettype?"void":"typeless");
 		if (expr && Wreturn_void)
 			warning(stmt->pos, "returning void-valued expression");

base-commit: e1578773182e8f69c3a0cd8add8dfbe7561a8240
-- 
2.28.0

