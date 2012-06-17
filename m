From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH v2] fix casting constant to _Bool
Date: Sun, 17 Jun 2012 14:45:05 -0400
Message-ID: <1339958705-9881-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:41143 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473Ab2FQSpV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Jun 2012 14:45:21 -0400
Received: by qcro28 with SMTP id o28so2513056qcr.19
        for <linux-sparse@vger.kernel.org>; Sun, 17 Jun 2012 11:45:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Carpenter <dan.carpenter@oracle.com>

Casting to _Bool requires a zero test rather than truncation.  Also add
a new cast warning for _Bool since this is not about truncation.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 expand.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/expand.c b/expand.c
index 63a9075..fcdefcb 100644
--- a/expand.c
+++ b/expand.c
@@ -92,6 +92,14 @@ void cast_value(struct expression *expr, struct symbol *newtype,
 	value = get_longlong(old);
 
 Int:
+	// _Bool requires a zero test rather than truncation.
+	if (is_bool_type(newtype)) {
+		expr->value = value ? 1 : 0;
+		if (!conservative && value != 0 && value != 1)
+			warning(old->pos, "odd constant _Bool cast (%llx becomes 1)", value);
+		return;
+	}
+
 	// Truncate it to the new size
 	signmask = 1ULL << (new_size-1);
 	mask = signmask | (signmask-1);
-- 
1.7.9.5

