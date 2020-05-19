From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 07/28] bad-goto: do not linearize if the IR will be invalid
Date: Tue, 19 May 2020 02:57:07 +0200
Message-ID: <20200519005728.84594-8-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:41 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16FC05BD09
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:40 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id be9so6045023edb.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:40 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index b040d345d469..4927468183b0 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2480,7 +2480,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	pseudo_t result;
 	int i;
 
-	if (!stmt)
+	if (!stmt || sym->bogus_linear)
 		return NULL;
 
 	ep = alloc_entrypoint();
diff --git a/symbol.h b/symbol.h
index 7241f13df4e4..50dba78a654a 100644
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
2.26.2
