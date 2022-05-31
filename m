Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0444EC433F5
	for <linux-sparse@archiver.kernel.org>; Tue, 31 May 2022 19:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiEaTch (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 31 May 2022 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbiEaTcg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 31 May 2022 15:32:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B3C9AE7B
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2022 12:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF001B815F3
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2022 19:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D85C3411D;
        Tue, 31 May 2022 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654025553;
        bh=ftrs1f5JYK5N2mSQKNXpQUlnRAzNNmABjM0eXW7Ef4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1y6uadk5wuwEMcpVXz0kSGZRstPmASAB+SXAg0SgXPMIKP2bf78LoRlZC6DuCgR8
         yve0AkiBCXoDwzobCeQxzcG4+do9PeW4cRCpBEnuxv9bNCvVBQrBwO5oflABnGyH5g
         HqaSLIRwg4x5d7mb5UyInC7nniD4rDISpFdPn8KDCjkWSkPdzmw0cnPVYOtZIJNKLx
         sfK78RcVebZ6TNyJBhll1F9x9I1JLrne/25BNB2yslIBZCyF3dICj7N0BRGKybW/KD
         g6yVJdQ0I6UqgDMTqaJVltYcyukHiB1V0EQWCSFEHrU9nroBpU1Xzd/aK7dvD3/IEM
         pfsRwlQtDVfiw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] cast_value: assign the new type
Date:   Tue, 31 May 2022 21:32:25 +0200
Message-Id: <20220531193226.33399-2-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531193226.33399-1-lucvoo@kernel.org>
References: <20220531193226.33399-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The first two arguments of cast_value() are the new expression and the
type wanted for it. This type is then used to calculate the new value.

But the type of the expression must be assigned separately (usually
after the cast because the old and the new expression can refer to
the same object).

To avoid any possible inconsistencies, assign the new type during the
casting itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c     | 4 ++++
 expression.c | 1 -
 parse.c      | 1 -
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/expand.c b/expand.c
index c4f806dee1ba..fb11d77aecbc 100644
--- a/expand.c
+++ b/expand.c
@@ -110,11 +110,13 @@ void cast_value(struct expression *expr, struct symbol *newtype,
 	expr->taint = old->taint;
 	if (old_size == new_size) {
 		expr->value = old->value;
+		expr->ctype = newtype;
 		return;
 	}
 
 	// expand it to the full "long long" value
 	value = get_longlong(old);
+	expr->ctype = newtype;
 
 Int:
 	// _Bool requires a zero test rather than truncation.
@@ -153,6 +155,7 @@ Float:
 		value = (long long)old->fvalue;
 		expr->type = EXPR_VALUE;
 		expr->taint = 0;
+		expr->ctype = newtype;
 		goto Int;
 	}
 
@@ -168,6 +171,7 @@ Float:
 			expr->fvalue = (float)expr->fvalue;
 	}
 	expr->type = EXPR_FVALUE;
+	expr->ctype = newtype;
 }
 
 /* Return true if constant shift size is valid */
diff --git a/expression.c b/expression.c
index efdaa36782c7..bead007f9bda 100644
--- a/expression.c
+++ b/expression.c
@@ -433,7 +433,6 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		if (token_type(token) < TOKEN_WIDE_CHAR) {
 			expr->ctype = &char_ctype;
 			cast_value(expr, &int_ctype, expr, expr->ctype);
-			expr->ctype = &int_ctype;
 		} else {
 			expr->ctype = wchar_ctype;
 		}
diff --git a/parse.c b/parse.c
index bc1c0602fcb4..0e51b3a33e53 100644
--- a/parse.c
+++ b/parse.c
@@ -904,7 +904,6 @@ static void cast_enum_list(struct symbol_list *list, struct symbol *base_type)
 			continue;
 		}
 		cast_value(expr, base_type, expr, ctype);
-		expr->ctype = base_type;
 	} END_FOR_EACH_PTR(sym);
 }
 
-- 
2.36.1

