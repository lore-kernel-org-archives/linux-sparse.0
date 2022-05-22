Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A22C433F5
	for <linux-sparse@archiver.kernel.org>; Sun, 22 May 2022 19:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbiEVTJR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 May 2022 15:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEVTJQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 May 2022 15:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE783669F
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 12:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94A661118
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 19:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333E8C385AA;
        Sun, 22 May 2022 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653246553;
        bh=aWh0SvoAAHbTvKrDyi/a+cfiJzNS/+Zl8JeGPHtxhfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPrSU2tFuq74I3tvuM2hSaseeJMwMRDhFxdVTDwElgsJLmR1gT6YUWiK4ftl68OHf
         X5vvKNlcp5vMi+uAWhy6QZYIZBIslsTmV57ii6mtCW7pUk57FFUVLfrEqRsWd+nh+e
         s7Fvf7vecOa5kEu4rfJS3c/eVHE1U4DY6c/PYmGTM5+HvBI9bUZ/BRh+URvQXe0rin
         NeVCMCW4mtesUOERp96KBE/zdqiYTOr+CtlaaYXfIzjotiAAQeD5Dk1J9W60Efy2Zx
         VDbjdhdUfFD94KJaxOsww0dfaKZzGie14Ees9XjnOFD87WLCCH58UtqDBgvT0B7yhO
         AO3dTxgpB+47Q==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] fix zero/sign extension of integer character constants
Date:   Sun, 22 May 2022 21:08:58 +0200
Message-Id: <20220522190858.42163-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <78f6d6cc-2be5-c69b-bd17-7da135448438@rasmusvillemoes.dk>
References: <78f6d6cc-2be5-c69b-bd17-7da135448438@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

An integer character constant has type 'int' but, subtly enough,
its value is the one of a 'char' converted to an 'int'.

So, do this conversion.
Also set the type of wide character constants from 'long' to 'wchar_t'.

Link: https://lore.kernel.org/r/20210927130253.GH2083@kadam
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/expression.c b/expression.c
index 221d7780a76e..e3b58cb5b653 100644
--- a/expression.c
+++ b/expression.c
@@ -427,8 +427,15 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 	case TOKEN_CHAR ... TOKEN_WIDE_CHAR_EMBEDDED_3:
 		expr = alloc_expression(token->pos, EXPR_VALUE);
 		expr->flags = CEF_SET_CHAR;
-		expr->ctype = token_type(token) < TOKEN_WIDE_CHAR ? &int_ctype : &long_ctype;
 		get_char_constant(token, &expr->value);
+
+		// TODO: handle 'u8', 'u' & 'U' prefixes.
+		if (token_type(token) < TOKEN_WIDE_CHAR) {
+			expr->ctype = &int_ctype;
+			expr->value = extend_value(expr->value, &char_ctype);
+		} else {
+			expr->ctype = wchar_ctype;
+		}
 		token = token->next;
 		break;
 
-- 
2.36.1

