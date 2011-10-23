From: penberg@cs.helsinki.fi
Subject: [RFC/PATCH 2/2] sparse: Use native sizes for data types
Date: Sun, 23 Oct 2011 15:37:00 +0300
Message-ID: <1319373420-8967-2-git-send-email-penberg@cs.helsinki.fi>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53463 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1JWMhK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 23 Oct 2011 08:37:10 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so6947490bkb.19
        for <linux-sparse@vger.kernel.org>; Sun, 23 Oct 2011 05:37:10 -0700 (PDT)
In-Reply-To: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

From: Pekka Enberg <penberg@kernel.org>

This patch is needed to fix the sparsec LLVM backend data type sizes.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 target.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target.c b/target.c
index 6a535bc..009002f 100644
--- a/target.c
+++ b/target.c
@@ -17,9 +17,9 @@ int max_alignment = 16;
 int bits_in_bool = 8;
 int bits_in_char = 8;
 int bits_in_short = 16;
-int bits_in_int = 32;
-int bits_in_long = 32;
-int bits_in_longlong = 64;
+int bits_in_int = sizeof(int) * 8;
+int bits_in_long = sizeof(long) * 8;
+int bits_in_longlong = sizeof(long long) * 8;
 int bits_in_longlonglong = 128;
 
 int max_int_alignment = 4;
@@ -36,8 +36,8 @@ int max_fp_alignment = 8;
 /*
  * Pointer data type
  */
-int bits_in_pointer = 32;
-int pointer_alignment = 4;
+int bits_in_pointer = sizeof(void *) * 8;
+int pointer_alignment = sizeof(void *); 
 
 /*
  * Enum data types
-- 
1.7.6.4

