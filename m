From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PATCH 1/2] sparse: Bump up sizeof(_Bool) to 8 bits
Date: Mon, 26 Sep 2011 17:47:23 +0300
Message-ID: <1317048444-1772-1-git-send-email-penberg@cs.helsinki.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36638 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab1IZOrm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Sep 2011 10:47:42 -0400
Received: by yib18 with SMTP id 18so4268272yib.19
        for <linux-sparse@vger.kernel.org>; Mon, 26 Sep 2011 07:47:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

From: Pekka Enberg <penberg@kernel.org>

We need sizeof(_Bool) to be one byte to generate code for boolean expressions
in the LLVM backend.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 target.c                 |    2 +-
 validation/sizeof-bool.c |    6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/target.c b/target.c
index 17b228a..6a535bc 100644
--- a/target.c
+++ b/target.c
@@ -14,7 +14,7 @@ int max_alignment = 16;
 /*
  * Integer data types
  */
-int bits_in_bool = 1;
+int bits_in_bool = 8;
 int bits_in_char = 8;
 int bits_in_short = 16;
 int bits_in_int = 32;
diff --git a/validation/sizeof-bool.c b/validation/sizeof-bool.c
index 6c68748..71ae1bc 100644
--- a/validation/sizeof-bool.c
+++ b/validation/sizeof-bool.c
@@ -4,9 +4,5 @@ static int a(void)
 }
 /*
  * check-name: sizeof(_Bool) is valid
- * check-description: sizeof(_Bool) was rejected because _Bool is not an even
- * number of bytes
- * check-error-start
-sizeof-bool.c:3:16: warning: expression using sizeof bool
- * check-error-end
+ * check-description: sizeof(_Bool) is valid
  */
-- 
1.7.6.2

