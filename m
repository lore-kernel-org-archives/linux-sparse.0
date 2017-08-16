From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/29] add helper imple_access() to test if an access is "simple"
Date: Wed, 16 Aug 2017 17:34:36 +0200
Message-ID: <20170816153455.97693-11-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38889 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPPf1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:27 -0400
Received: by mail-wr0-f195.google.com with SMTP id g32so3683197wrd.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:26 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This helper simply check if an access is to a simple variable
as defined by is_simple_var().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/linearize.c b/linearize.c
index 3a1bc74ed..190c47241 100644
--- a/linearize.c
+++ b/linearize.c
@@ -912,6 +912,19 @@ static int linearize_address_gen(struct entrypoint *ep,
 	return 0;
 }
 
+static inline struct symbol *simple_access(struct access_data *ad)
+{
+	pseudo_t addr = ad->address;
+	struct symbol *sym;
+
+	if (addr->type != PSEUDO_SYM)
+		return NULL;
+	sym = addr->sym;
+	if (!is_simple_var(sym))
+		return NULL;
+	return sym;
+}
+
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 {
 	struct instruction *insn;
-- 
2.14.0

