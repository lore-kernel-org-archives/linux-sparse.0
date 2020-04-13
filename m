From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/17] bad-goto: do not linearize if the IR will be invalid
Date: Mon, 13 Apr 2020 18:15:52 +0200
Message-ID: <20200413161605.95900-5-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgDMQQQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6050C0A3BE2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so10690714wrm.13
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:15 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In some error cases, it's not possible to produce a valid &
correct IR for the concerned function. For exemple, if the
AST contains invalid gotos, the CFG will either be invalid
or won't correspond to the erroneous source code.

So, refuse to linearize such functions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 symbol.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index b040d345d469..222714564a3f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2480,7 +2480,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	pseudo_t result;
 	int i;
 
-	if (!stmt)
+	if (!stmt || base_type->bogus_linear)
 		return NULL;
 
 	ep = alloc_entrypoint();
diff --git a/symbol.h b/symbol.h
index c86dfb335e29..de13d60b8b75 100644
--- a/symbol.h
+++ b/symbol.h
@@ -171,6 +171,7 @@ struct symbol {
 			unsigned long	offset;
 			int		bit_size;
 			unsigned int	bit_offset:8,
+					bogus_linear:1,
 					variadic:1,
 					initialized:1,
 					examined:1,
-- 
2.26.0
