From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 2/2] Update the validation check for escape sequences
Date: Thu, 16 Dec 2010 18:14:46 +0900
Message-ID: <1292490886-6238-2-git-send-email-namhyung@gmail.com>
References: <1292490886-6238-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49433 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab0LPJPO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 Dec 2010 04:15:14 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so463141pva.19
        for <linux-sparse@vger.kernel.org>; Thu, 16 Dec 2010 01:15:13 -0800 (PST)
In-Reply-To: <1292490886-6238-1-git-send-email-namhyung@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 validation/escapes.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/validation/escapes.c b/validation/escapes.c
index b0d2b4b742c2..13f8f9c87e21 100644
--- a/validation/escapes.c
+++ b/validation/escapes.c
@@ -1,6 +1,21 @@
 static int e[] = { '\'', '\"', '\?', '\\',
-                   '\a', '\b', '\f', '\n', '\r', '\t', '\v', };
-static char *s = "\'\"\?\\ \a\b\f\n\r\t\v";
+                   '\a', '\b', '\f', '\n', '\r', '\t', '\v',
+		   '\0', '\012', '\x7890', '\xabcd' };
+static char *s = "\'\"\?\\ \a\b\f\n\r\t\v \377\xcafe";
+
+static int bad_e[] = { '\c', '\0123', '\789', '\xdefg' };
 /*
  * check-name: Character escape sequences
+ *
+ * check-error-start
+escapes.c:6:27: warning: Unknown escape 'c'
+escapes.c:6:35: error: Bad character constant
+escapes.c:6:38: error: Bad character constant
+escapes.c:6:42: error: Bad character constant
+escapes.c:6:46: error: Bad character constant
+escapes.c:6:53: error: Bad character constant
+escapes.c:6:56: error: Bad character constant
+escapes.c:6:42: error: Expected } at end of initializer
+escapes.c:6:42: error: got 89
+ * check-error-end
  */
-- 
1.7.3.3.400.g93cef

