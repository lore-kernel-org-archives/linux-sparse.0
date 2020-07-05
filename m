From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/15] cleanup: move hexval() to utils.c
Date: Sun,  5 Jul 2020 15:02:20 +0200
Message-ID: <20200705130220.26230-16-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgGENCo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E77C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so39584686ejc.8
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:44 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now lib.c contains almost nothing else than library entrypoints.

Move a small utility, hexval(), to utils.c to complete this cleanup.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c   | 17 -----------------
 lib.h   |  2 --
 utils.c | 17 +++++++++++++++++
 utils.h |  4 ++++
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/lib.c b/lib.c
index f512be2e1a43..57c89a16448e 100644
--- a/lib.c
+++ b/lib.c
@@ -50,23 +50,6 @@
 #include "bits.h"
 
 
-unsigned int hexval(unsigned int c)
-{
-	int retval = 256;
-	switch (c) {
-	case '0'...'9':
-		retval = c - '0';
-		break;
-	case 'a'...'f':
-		retval = c - 'a' + 10;
-		break;
-	case 'A'...'F':
-		retval = c - 'A' + 10;
-		break;
-	}
-	return retval;
-}
-
 static void do_warn(const char *type, struct position pos, const char * fmt, va_list args)
 {
 	static char buffer[512];
diff --git a/lib.h b/lib.h
index 81253a3e7ee5..46483f2bed5c 100644
--- a/lib.h
+++ b/lib.h
@@ -45,8 +45,6 @@
 #endif
 
 
-extern unsigned int hexval(unsigned int c);
-
 struct position {
 	unsigned int type:6,
 		     stream:14,
diff --git a/utils.c b/utils.c
index 094df3f9bf1c..72fff00ff91b 100644
--- a/utils.c
+++ b/utils.c
@@ -8,6 +8,23 @@
 #include <stdio.h>
 
 
+unsigned int hexval(unsigned int c)
+{
+	int retval = 256;
+	switch (c) {
+	case '0'...'9':
+		retval = c - '0';
+		break;
+	case 'a'...'f':
+		retval = c - 'a' + 10;
+		break;
+	case 'A'...'F':
+		retval = c - 'A' + 10;
+		break;
+	}
+	return retval;
+}
+
 void *xmemdup(const void *src, size_t len)
 {
 	return memcpy(__alloc_bytes(len), src, len);
diff --git a/utils.h b/utils.h
index 7bd14f467799..079fb02a3e94 100644
--- a/utils.h
+++ b/utils.h
@@ -8,6 +8,10 @@
 #include <stddef.h>
 #include <stdarg.h>
 
+///
+// return the value coresponding to an hexadecimal digit
+unsigned int hexval(unsigned int c);
+
 ///
 // duplicate a memory buffer in a newly allocated buffer.
 // @src: a pointer to the memory buffer to be duplicated
-- 
2.27.0
