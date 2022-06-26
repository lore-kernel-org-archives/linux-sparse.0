Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FAC433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiFZNIG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiFZNIB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 09:08:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281810A6
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 06:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59616B80D8D
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 13:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6769EC34114;
        Sun, 26 Jun 2022 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656248878;
        bh=sMpPGbTZ1ffXSJzAHnfX/4x/ItATuufRdi3V16c6zVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wn5nWi9CCWaSUfP1XeSjbfrykeg8A6tBjx+gxeeLGsXy2FpjqFtojjA1k1nNVMreO
         A+vvQFnhdbtHQaSXIBlHnwmi0mfrvdoFtEz+NfeX9RNm8sCdmYVIVxviSx2RTvkLNs
         8SCJ0kOzXzcOtoleomBdsbI4IJRBtfIY8JEbsF/MIk10QBl9fiOzgZnmQ7klvLvE0C
         jPvRMfpfw8DJ5pPjTVYC9U+ADj0wFd1ARRFstMaAjnD1MllvsQtifGTBfLcGbQrmN6
         hyF6pKnBJxeI7ryiAd1yq9KvOZv1r1SCNXVieS6+DPaIhjgvEsaWjE3HuC7anQyJ8x
         8j0BkY7mkbqSg==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] inline: declaration of the variadic vars is useless
Date:   Sun, 26 Jun 2022 15:07:45 +0200
Message-Id: <20220626130748.74163-4-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626130748.74163-1-lucvoo@kernel.org>
References: <20220626130748.74163-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When inlining a function call, the arguments of this call must
somehow be assigned to the names used in the function definition.
This is done via a STMT_DECLARATION associated to the top
STMT_COMPOUND which now correspond to the inlined code.

This is perfectly fine for the normal case of non-variadic function
but when inlining a variadic function there is no corresponding name
to assign the non-fixed arguments to (such arguments must either be
not used at all or copied via __builtin_va_arg_pack()). What's then
happening is essentially that these variables are self-assigned.
Not Good.

This seems to be relatively harmless but is confusing.
So only put the fixed/named arguments in the declaration list.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 inline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/inline.c b/inline.c
index d031c9b19128..4696eb509f9a 100644
--- a/inline.c
+++ b/inline.c
@@ -546,14 +546,14 @@ int inline_function(struct expression *expr, struct symbol *sym)
 			*a = *name;
 			set_replace(name, a);
 			add_symbol(&fn_symbol_list, a);
+			a->initializer = arg;
+			add_symbol(&arg_decl, a);
 		} else {
 			// This may create a node of a node but it will
 			// be resolved later when the corresponding
 			// STMT_DECLARATION will be evaluated.
 			a->ctype.base_type = arg->ctype;
 		}
-		a->initializer = arg;
-		add_symbol(&arg_decl, a);
 
 		NEXT_PTR_LIST(name);
 	} END_FOR_EACH_PTR(arg);
-- 
2.36.1

