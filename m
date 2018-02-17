From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] quiet memset() warning with sizeof(VLA)
Date: Sat, 17 Feb 2018 17:58:39 +0100
Message-ID: <20180217165839.61981-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37358 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeBQQ6q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 11:58:46 -0500
Received: by mail-wr0-f195.google.com with SMTP id k32so5715657wrk.4
        for <linux-sparse@vger.kernel.org>; Sat, 17 Feb 2018 08:58:46 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse doesn't handle yet VLA's sizeof(). The size
of a VLA is considered as zero and the result of sizeof() on
a VLA is treated as an error with a value of -1.

That's a problem with the check done by the sparse tool, which
warn when operations like memset() are done with a static count
which is above some limit. Of course, all this is done with
unsigned numbers and the -1 from sizeof(VLA) is then considered
as off-limit.

Sure, size of VLAs should be supported but it's longer term.
One short term solution would be to do the check with signed
numbers but that would eat the upper bit of the limit which
may well be the bound that we would like to check.

So, check instead for sizes of -1, which must come from some
previous errors that must have already been reported, and do
not issue the memset() warning in this case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sparse.c b/sparse.c
index bceacd94e..5f53a9b9b 100644
--- a/sparse.c
+++ b/sparse.c
@@ -153,6 +153,8 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
 		return;
 	if (count->type == PSEUDO_VAL) {
 		unsigned long long val = count->value;
+		if (val == -1ULL)
+			return;
 		if (Wmemcpy_max_count && val > fmemcpy_max_count)
 			warning(insn->pos, "%s with byte count of %llu",
 				show_ident(insn->func->sym->ident), val);
-- 
2.16.0

