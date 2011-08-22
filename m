From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 4/5] sparse, i386: Fix boolean bit size
Date: Mon, 22 Aug 2011 16:57:30 +0300
Message-ID: <1314021451-24808-4-git-send-email-penberg@kernel.org>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:59198 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab1HVN5f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 09:57:35 -0400
In-Reply-To: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

The value of 'ctype->bit_size' is set to 1 for booleans which confuses the i386
backend:

  ./compile allocate.c
  compile: compile-i386.c:1406: emit_binop: Assertion `0' failed.
  Aborted

Looking at the code, we assume that "bit_size / 8" gives a sane result on
various places. This patch fixes the problem by bumping bit_size to 8 for
booleans. This also makes sizeof(_Bool) return 1 which is consistent with what
GCC 4.4.3, for example, does.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 target.c                 |    2 +-
 validation/sizeof-bool.c |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

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
index 6c68748..31b0585 100644
--- a/validation/sizeof-bool.c
+++ b/validation/sizeof-bool.c
@@ -4,9 +4,6 @@ static int a(void)
 }
 /*
  * check-name: sizeof(_Bool) is valid
- * check-description: sizeof(_Bool) was rejected because _Bool is not an even
- * number of bytes
  * check-error-start
-sizeof-bool.c:3:16: warning: expression using sizeof bool
  * check-error-end
  */
-- 
1.7.4.1

