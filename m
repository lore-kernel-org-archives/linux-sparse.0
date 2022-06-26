Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C7CCA47C
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 13:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiFZNIH (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiFZNID (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 09:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECC52719
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 06:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF6261237
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 13:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C38C34114;
        Sun, 26 Jun 2022 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656248881;
        bh=BcKa+Y/z+jxw3qTTzprUgzel8f5e5lWuuMseyr+OUX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EN9bHjSY1JWARtOkbnkn3+GxoGPTxGxC7IgZPMAQhPYVvTKAqyGReOmyDgKvAtn0o
         IH6l2wc93bRAoMHR+8oT4NhQdTqn923rda2BKPBsynp2R6w6C4DK8OK4BnxHe56j2I
         1sN6UiQGoRYZXOlPzhg36BGrvFnoh/TkqmziciBIUWXJfurS/52T8NByzxS4Rpv4Ke
         sxRkicKgG2Zfko7Hh+ER0SyPX1+9hRkNG6xFzQvmMhsDq3oBPVmtrnrSawPqmWj5jF
         9baVCSZYhG9wEH3mjbHyuc+Y9p9K9V3RiSZrk1IXrQPET1PwSJ/PfD9CXn21N72XjJ
         UEk4/7uvAupBA==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] inline: free symbol list after use
Date:   Sun, 26 Jun 2022 15:07:48 +0200
Message-Id: <20220626130748.74163-7-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626130748.74163-1-lucvoo@kernel.org>
References: <20220626130748.74163-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

We usually don't free allocated memory because it's not known
when the allocated objects aren't used anymore.

But here it's pretty obvious, so free this symbol list.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/inline.c b/inline.c
index 68f235c21945..a7ab73d37492 100644
--- a/inline.c
+++ b/inline.c
@@ -567,6 +567,7 @@ int inline_function(struct expression *expr, struct symbol *sym)
 	stmt->inline_fn = sym;
 
 	unset_replace_list(fn_symbol_list);
+	free_ptr_list(&fn_symbol_list);
 
 	return 1;
 }
-- 
2.36.1

