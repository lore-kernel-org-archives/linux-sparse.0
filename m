From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 3/3] Revert "sparse: Bump up sizeof(_Bool) to 8 bits"
Date: Wed, 21 Dec 2011 11:25:28 +0200
Message-ID: <1324459528-9344-3-git-send-email-penberg@kernel.org>
References: <1324459528-9344-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57432 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495Ab1LUJZr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Dec 2011 04:25:47 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id d3so467217lah.19
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2011 01:25:46 -0800 (PST)
In-Reply-To: <1324459528-9344-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This reverts commit 2ded1e7406914eda77abde035416140849d76f68. It's no longer
needed as LLVM backend supports 1-bit integers.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 target.c                 |    2 +-
 validation/sizeof-bool.c |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target.c b/target.c
index 6a535bc..17b228a 100644
--- a/target.c
+++ b/target.c
@@ -14,7 +14,7 @@ int max_alignment = 16;
 /*
  * Integer data types
  */
-int bits_in_bool = 8;
+int bits_in_bool = 1;
 int bits_in_char = 8;
 int bits_in_short = 16;
 int bits_in_int = 32;
diff --git a/validation/sizeof-bool.c b/validation/sizeof-bool.c
index 71ae1bc..6c68748 100644
--- a/validation/sizeof-bool.c
+++ b/validation/sizeof-bool.c
@@ -4,5 +4,9 @@ static int a(void)
 }
 /*
  * check-name: sizeof(_Bool) is valid
- * check-description: sizeof(_Bool) is valid
+ * check-description: sizeof(_Bool) was rejected because _Bool is not an even
+ * number of bytes
+ * check-error-start
+sizeof-bool.c:3:16: warning: expression using sizeof bool
+ * check-error-end
  */
-- 
1.7.6.4

