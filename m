Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70EC433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 31 May 2022 19:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbiEaTci (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 31 May 2022 15:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbiEaTch (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 31 May 2022 15:32:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58CA9B180
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2022 12:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90C34B81236
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2022 19:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4248C34114;
        Tue, 31 May 2022 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654025554;
        bh=3/YUt63GsjFXTmRnZyL0zntgAZCi5H27PcScIcUvhoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVtsU03gVeUyV9iU+yAsIkKtbqNdKEr0BDWNV2a6waeDR13cxuu/2vfDynteFWLTu
         QUfgmXr7DlR6KY+oIPaiNZ2f4oydI0nMXk6UT0pEj8hW+NYgOByzuo7WR10dr8wOvc
         4n4YiHm4iwnDwegqXHyLTeAAZwAJFLxbdeXVjA4/efXLNu4sFUMZzECLigMmdq+yHp
         aBqwq1l0F760A7G8K1lIq9DCg7f8mmXKOGMwEIu8mq6DMNdbQPzR6FDVqa/q5uk+kJ
         D5LPFduvtRb8QFQiHd/7L+Jr8uUFHJ1VludcrujrkdkB791g1zw1P2ppoFOkLgFANo
         8kPnMGOonKsGw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] cast_value: remove error-prone redundant argument
Date:   Tue, 31 May 2022 21:32:26 +0200
Message-Id: <20220531193226.33399-3-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531193226.33399-1-lucvoo@kernel.org>
References: <20220531193226.33399-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The last two arguments of cast_value() are the old expression and
the oldtype which suggest that this oldtype can be distinct from the
type of the old expression.

But this is not the case because internally the type used to retrieve
the value of the expression is the type of the expression itself (old->ctype)
the type which is used and the two types must be the same (or at least
be equivalent).

So, remove the error-prone last argument and always us the type of the
expression itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c     | 6 +++---
 expression.c | 2 +-
 expression.h | 3 +--
 parse.c      | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/expand.c b/expand.c
index fb11d77aecbc..f14e718187bc 100644
--- a/expand.c
+++ b/expand.c
@@ -94,9 +94,9 @@ static long long get_longlong(struct expression *expr)
 	return (value & andmask) | ormask;
 }
 
-void cast_value(struct expression *expr, struct symbol *newtype,
-		struct expression *old, struct symbol *oldtype)
+void cast_value(struct expression *expr, struct symbol *newtype, struct expression *old)
 {
+	struct symbol *oldtype = old->ctype;
 	int old_size = oldtype->bit_size;
 	int new_size = newtype->bit_size;
 	long long value, mask, signmask;
@@ -876,7 +876,7 @@ static int expand_cast(struct expression *expr)
 
 	/* Simplify normal integer casts.. */
 	if (target->type == EXPR_VALUE || target->type == EXPR_FVALUE) {
-		cast_value(expr, expr->ctype, target, target->ctype);
+		cast_value(expr, expr->ctype, target);
 		return 0;
 	}
 	return cost + 1;
diff --git a/expression.c b/expression.c
index bead007f9bda..727e7056e460 100644
--- a/expression.c
+++ b/expression.c
@@ -432,7 +432,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		// TODO: handle 'u8', 'u' & 'U' prefixes.
 		if (token_type(token) < TOKEN_WIDE_CHAR) {
 			expr->ctype = &char_ctype;
-			cast_value(expr, &int_ctype, expr, expr->ctype);
+			cast_value(expr, &int_ctype, expr);
 		} else {
 			expr->ctype = wchar_ctype;
 		}
diff --git a/expression.h b/expression.h
index f733c07697c8..8bf40d32e10b 100644
--- a/expression.h
+++ b/expression.h
@@ -337,7 +337,6 @@ struct token *compound_statement(struct token *, struct statement *);
 #define constant_expression(token,tree) conditional_expression(token, tree)
 
 /* Cast folding of constant values.. */
-void cast_value(struct expression *expr, struct symbol *newtype,
-	struct expression *old, struct symbol *oldtype);
+void cast_value(struct expression *expr, struct symbol *newtype, struct expression *old);
 
 #endif
diff --git a/parse.c b/parse.c
index 0e51b3a33e53..53342c78c108 100644
--- a/parse.c
+++ b/parse.c
@@ -903,7 +903,7 @@ static void cast_enum_list(struct symbol_list *list, struct symbol *base_type)
 			expr->ctype = &int_ctype;
 			continue;
 		}
-		cast_value(expr, base_type, expr, ctype);
+		cast_value(expr, base_type, expr);
 	} END_FOR_EACH_PTR(sym);
 }
 
-- 
2.36.1

