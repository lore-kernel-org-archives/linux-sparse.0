From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/3] memcpy()'s byte count is unsigned
Date: Sat,  3 Jun 2017 09:47:25 +0200
Message-ID: <20170603074727.66945-2-luc.vanoostenryck@gmail.com>
References: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35472 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdFCHrf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 03:47:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id g15so22043882wmc.2
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 00:47:34 -0700 (PDT)
In-Reply-To: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The checker part of sparse does some checking on memcpy(),
memset(), copy_{from,to}_user() byte count and warn if the
value is known to be too large. The comparison is done with
signed numbers and it also warns if the value is negative.

However these functions take an unsigned byte count (size_t)
and so the value can't really be negative.

Additionaly, the number of bits used by sparse internally may not
be the same as the one used for the target's size_t. So sparse's
check against negative value may not be the same as checking if
the target's value would be so-large-than-the-upper-bit-is-set.

Change this by removing the test for negative values and simply
do an unsigned compare.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse.c b/sparse.c
index 02ab97743..1cb90e20d 100644
--- a/sparse.c
+++ b/sparse.c
@@ -152,9 +152,9 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
 	if (!count)
 		return;
 	if (count->type == PSEUDO_VAL) {
-		long long val = count->value;
-		if (val <= 0 || val > 100000)
-			warning(insn->pos, "%s with byte count of %lld",
+		unsigned long long val = count->value;
+		if (val > 100000ULL)
+			warning(insn->pos, "%s with byte count of %llu",
 				show_ident(insn->func->sym->ident), val);
 		return;
 	}
-- 
2.13.0

