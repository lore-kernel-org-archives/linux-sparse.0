From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 37/48] mem2reg: add description for find_dominating_parents()
Date: Wed, 23 Aug 2017 22:15:43 +0200
Message-ID: <20170823201554.90551-38-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32842 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id b79so664015wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:14 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mem2reg.c b/mem2reg.c
index 793a1d730..0078485da 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -57,6 +57,16 @@ static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
 	return 0;
 }
 
+/*
+ * sym - the symbol/var we're looking the value for
+ * insn - a load of 'sym'
+ * bb - the current bb we're looking
+ * generation - ditto
+ * dominators - list of dominators for this load
+ * local: is the symbol local or externally visible?
+ *
+ * returns 1 if we found a value, 0 otherwise.
+ */
 static int find_dominating_parents(struct symbol *sym, struct instruction *insn,
 	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
 	int local)
-- 
2.14.0

