From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] validation/sizeof-bool: fix broken test case
Date: Sun,  2 Mar 2014 12:31:59 +0000
Message-ID: <82beef733be057586c0c1b08c78ef1c585e17d46.1393763519.git.john@keeping.me.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hyena.aluminati.org ([64.22.123.221]:56898 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaCBMcN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 2 Mar 2014 07:32:13 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: John Keeping <john@keeping.me.uk>

Since commit 2667c2d (sparse: Allow override of sizeof(bool) warning,
2014-02-26) the default has been not to warn on sizeof(bool).  This
means that the sizeof-bool test case now needs an explicit command in
order to trigger the warning it is testing.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 validation/sizeof-bool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/validation/sizeof-bool.c b/validation/sizeof-bool.c
index 6c68748..05e76a4 100644
--- a/validation/sizeof-bool.c
+++ b/validation/sizeof-bool.c
@@ -6,6 +6,7 @@ static int a(void)
  * check-name: sizeof(_Bool) is valid
  * check-description: sizeof(_Bool) was rejected because _Bool is not an even
  * number of bytes
+ * check-command: sparse -Wsizeof-bool $file
  * check-error-start
 sizeof-bool.c:3:16: warning: expression using sizeof bool
  * check-error-end
-- 
1.9.0.6.g037df60.dirty

