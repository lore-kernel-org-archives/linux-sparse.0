Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E16CCA47F
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiFZNIF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiFZNIA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 09:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBBCC8
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 06:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57C35B80D89
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 13:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB6AC341CB;
        Sun, 26 Jun 2022 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656248877;
        bh=SlAij8Oqc1K9LT6P0ed20OndAiyw4rHQsfDrSc9ZYDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+EFre2N82CVrP260YbfvgJ2R4eBxeDhuai8ZuI7ZRTLmowVC6XDTXteOOHDv5TNG
         n8XHNrx4nNunsLNR9I8c76bfBuw/UELxqgcrzuc592NxOVmWZ88luT0udt+qV5mBz6
         61k33DnQJVDOtYpvYYmVu81AL724FhDM5W/oe7tIPSjHmIAlqVc4UoEYdB/IrzI9gX
         niJsBJI/SlrO3bO5d9+OsPTQpPFYDGa5rROgZEHTM72rrajvucL6SXeYEkInyIsUmY
         4tQJSNda/nakM1ay4PEf6Nt95eDPg6xvukp0X66FuheG3k773UDkJwlhwKCeMccHjY
         0ofcMGbF37Y4Q==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] inline: comment about creating node of node on variadics
Date:   Sun, 26 Jun 2022 15:07:44 +0200
Message-Id: <20220626130748.74163-3-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626130748.74163-1-lucvoo@kernel.org>
References: <20220626130748.74163-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When inlining a variadic function (unsupported in general by
sparse but OK when the arguments are unused and occurs as such
in the kernel), the extra arguments are added in the declaration
list as SYM_NODE.

But these arguments can already be SYM_NODEs. Sparse doesn't
support everywhere such nested nodes (they must be merged) but
in this case it's fine as the node will be merged when evaluated.

Add a comment telling the situation is fine.
Also, move the code to where the variadic arguments are handled
since the fixed one will be anyway directly overwritten.

Note: Sparse doesn't really support inlining of variadic functions
      but is fine when the arguments are not used (and such cases
      occur in the kernel).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 inline.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/inline.c b/inline.c
index 0097e4bf620a..d031c9b19128 100644
--- a/inline.c
+++ b/inline.c
@@ -542,11 +542,15 @@ int inline_function(struct expression *expr, struct symbol *sym)
 	FOR_EACH_PTR(arg_list, arg) {
 		struct symbol *a = alloc_symbol(arg->pos, SYM_NODE);
 
-		a->ctype.base_type = arg->ctype;
 		if (name) {
 			*a = *name;
 			set_replace(name, a);
 			add_symbol(&fn_symbol_list, a);
+		} else {
+			// This may create a node of a node but it will
+			// be resolved later when the corresponding
+			// STMT_DECLARATION will be evaluated.
+			a->ctype.base_type = arg->ctype;
 		}
 		a->initializer = arg;
 		add_symbol(&arg_decl, a);
-- 
2.36.1

