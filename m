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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1B0C433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0E164F2B
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhBYXj6 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhBYXjz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Feb 2021 18:39:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C70C061756
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d2so8899209edq.10
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3VI9K+apz4HTDSXV4nR9apZJcAcM8Xq3FfdTQgMTIw=;
        b=h1dhkpRwNFeJ2i/oMKsOHPzPn9YFHsHiMr3C0eRtNhzjbUwpsRATbpg0Xl+TuF28dK
         tlzGwlJFgyw2ei4oBfmmxtt8y24PNapE/PHBEPfRmN+MmakuwncX4SZL6gMaBOUCpau+
         jiJvLbnUjzicuPGLQ6lcrox8rw6JuZjNYUleiFzzNfe86Jnzt9K4GZn8RQrgMygX9u2u
         gPr86j1Y6nEVx8F4MOAxSeHXuXAAHGO0P+Jy74t6l7eGJPoBEcIU537Axj7RilgxxEmU
         9ArKpVO9TijannOqm+FtaDXvjFw0HEczLELV/uH9UwrVi1/K+5dA9s17Rt64i7LFpuWe
         oUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3VI9K+apz4HTDSXV4nR9apZJcAcM8Xq3FfdTQgMTIw=;
        b=R6cdNaJkO2VqysiU2nL7M2vnQ3j3IpYTK7W36j2qvRiej4fWz09XafzkNHvD+tUD/d
         aLs+7D0b4XScICt4zHBQx+PW8qE2AW7xs1sGs933s+pKAtE8JutNvpvFqmBl1fPi02j8
         8TxyTzLm24z7hClEGjExFX3DFJCloFDs2QqJGjLIDbY3Wvhm/aHtJrX0/zet7BqJ38H6
         Ie97YePny8YryIMXBBX1wIu7NzX5u6K89RMCF3jTqroTb4fDbWvC3Xsdy5/31epRPU6V
         llSKnd2EPt0GPja0sA/JJOmVmGZhmwhaae2SRZTApJcwsTZuIlOrHFg+X/WRdy/05WhN
         L8FQ==
X-Gm-Message-State: AOAM532KH3mgJSLvDveVMLJDT36ux/eaOpcUH8ULadxM5BR3v5Nz2keB
        Vx7OPrBTxIds+haQQ7sSLS7MLiEs6a0=
X-Google-Smtp-Source: ABdhPJyNWIDNOdt2i6zcKwu/Bk3klhFf7/MCs8pEUD+Rg3n1YYpc8i6ym17sERM8h3WGVSCpYi+jBw==
X-Received: by 2002:aa7:cc96:: with SMTP id p22mr410372edt.240.1614296353885;
        Thu, 25 Feb 2021 15:39:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:2cfa:d768:30f4:f221])
        by smtp.gmail.com with ESMTPSA id q27sm3906167ejc.74.2021.02.25.15.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 15:39:13 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] slice: remove unneeded nr_nrbits from EXPR_SLICE
Date:   Fri, 26 Feb 2021 00:39:06 +0100
Message-Id: <20210225233908.97275-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

EXPR_SLICE::r_nrbits is necessarily equal to its type's bit size.
So remove this redundancy.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c   | 1 -
 expression.h | 2 +-
 show-parse.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 41871e18503a..e13edf5488b4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2170,7 +2170,6 @@ static struct symbol *evaluate_member_dereference(struct expression *expr)
 		}
 		expr->r_bitpos += bytes_to_bits(offset);
 		expr->type = EXPR_SLICE;
-		expr->r_nrbits = member->bit_size;
 		expr->r_bitpos += member->bit_offset;
 		expr->ctype = member;
 		return member;
diff --git a/expression.h b/expression.h
index 3e9e9d852c27..f733c07697c8 100644
--- a/expression.h
+++ b/expression.h
@@ -206,7 +206,7 @@ struct expression {
 		// EXPR_SLICE
 		struct /* slice */ {
 			struct expression *base;
-			unsigned r_bitpos, r_nrbits;
+			unsigned r_bitpos;
 		};
 		// EXPR_CAST, EXPR_FORCE_CAST, EXPR_IMPLIED_CAST,
 		// EXPR_SIZEOF, EXPR_ALIGNOF and EXPR_PTRSIZEOF
diff --git a/show-parse.c b/show-parse.c
index 3ab8ec8f1894..e2fc18bb4b3d 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -819,7 +819,7 @@ static int show_slice(struct expression *expr)
 {
 	int target = show_expression(expr->base);
 	int new = new_pseudo();
-	printf("\tslice.%d\t\tv%d,v%d,%d\n", expr->r_nrbits, target, new, expr->r_bitpos);
+	printf("\tslice.%d\t\tv%d,v%d,%d\n", expr->ctype->bit_size, target, new, expr->r_bitpos);
 	return new;
 }
 
-- 
2.30.0

