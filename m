From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Fix incorrect symbol in comment on #endif for
	multiple-inclusion guard
Date: Wed, 13 Sep 2006 13:42:37 -0700
Message-ID: <1158180157.5097.28.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:41608 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751182AbWIMUmQ
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Sep 2006 16:42:16 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8DKgG1B026972
	for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2006 16:42:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8DKgGCC330712
	for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2006 14:42:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8DKgFnW023865
	for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2006 14:42:15 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

symbol.h uses the standard multiple-inclusion guard, with the symbol SYMBOL_H,
but the comment on the final #endif says /* SEMANTIC_H */.  Change this to the
correct symbol.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 symbol.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/symbol.h b/symbol.h
index 9d939cf..f308763 100644
--- a/symbol.h
+++ b/symbol.h
@@ -272,4 +272,4 @@ #define is_restricted_type(type) (get_sy
 #define is_bitfield_type(type)   (get_sym_type(type) == SYM_BITFIELD)
 extern int is_ptr_type(struct symbol *);
 
-#endif /* SEMANTIC_H */
+#endif /* SYMBOL_H */
-- 
1.4.1.1
