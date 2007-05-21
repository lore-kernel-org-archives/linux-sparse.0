From: Damien Lespiau <damien.lespiau@gmail.com>
Subject: [PATCH] Fix compilation warning on 64 bits platforms
Date: Mon, 21 May 2007 02:04:35 +0200
Message-ID: <11797058752907-git-send-email-damien.lespiau@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp14.orange.fr ([193.252.23.69]:19061 "EHLO smtp14.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758252AbXEUAEi (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 20:04:38 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Damien Lespiau <damien.lespiau@gmail.com>

Fix: format '%d' expects type 'int', but argument 2 has type 'long int'

Signed-off-by: Damien Lespiau <damien.lespiau@gmail.com>
---
 linearize.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/linearize.c b/linearize.c
index d428d92..6c9fae4 100644
--- a/linearize.c
+++ b/linearize.c
@@ -461,7 +461,7 @@ const char *show_instruction(struct instruction *insn)
 	}
 
 	if (buf >= buffer + sizeof(buffer))
-		die("instruction buffer overflowed %d\n", buf - buffer);
+		die("instruction buffer overflowed %d\n", (int)(buf - buffer));
 	do { --buf; } while (*buf == ' ');
 	*++buf = 0;
 	return buffer;
-- 
1.5.2.rc3.87.g404fd
