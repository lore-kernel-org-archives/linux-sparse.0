From: Damien Lespiau <damien.lespiau@gmail.com>
Subject: [PATCH] Fix compilation warning on 64 bits platforms v2
Date: Tue, 22 May 2007 20:07:37 +0200
Message-ID: <11798572573555-git-send-email-damien.lespiau@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.48]:48907 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755640AbXEVSHj (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 14:07:39 -0400
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
index d428d92..c38dd7d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -461,7 +461,7 @@ const char *show_instruction(struct instruction *insn)
 	}
 
 	if (buf >= buffer + sizeof(buffer))
-		die("instruction buffer overflowed %d\n", buf - buffer);
+		die("instruction buffer overflowed %td\n", buf - buffer);
 	do { --buf; } while (*buf == ' ');
 	*++buf = 0;
 	return buffer;
-- 
1.5.2.rc3.87.g404fd
