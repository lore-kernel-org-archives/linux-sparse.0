From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] gensel: remove unneeded test/uninitialized warning
Date: Tue, 23 Jun 2020 00:38:54 +0200
Message-ID: <20200622223854.87802-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVWjB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jun 2020 18:39:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459AC061573
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 15:39:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id y6so14925760edi.3
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 15:39:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>

When evaluation generic selections, it is tested if the type in
the selection is a SYM_NODE or not, but:
* all these are SYM_NODE
* the variable for the base type would be uninitialized
  if not a SYM_NODE.

So, remove the test and unconditionally set the base type.

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index aa0f208006bb..461c2547285f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3304,9 +3304,7 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 		if (!evaluate_symbol(stype))
 			continue;
 
-		if (stype->type == SYM_NODE)
-			base = stype->ctype.base_type;
