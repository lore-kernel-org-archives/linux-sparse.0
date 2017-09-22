From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] compile-i386: Use SPARSE_VERSION instead of __DATE__
Date: Fri, 22 Sep 2017 10:14:10 +0200
Message-ID: <20170922081410.29162-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:45482 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751795AbdIVIOQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 22 Sep 2017 04:14:16 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The compile date isn't very informative for a tool, the version is what really
matters. Additionally using __DATE__ makes the build unreprodicible.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 compile-i386.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/compile-i386.c b/compile-i386.c
index e4d3f27dd8a9..1cedcbda73d8 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -57,6 +57,7 @@
 #include "target.h"
 #include "compile.h"
 #include "bitmap.h"
+#include "version.h"
 
 struct textbuf {
 	unsigned int	len;	/* does NOT include terminating null */
@@ -691,7 +692,7 @@ void emit_unit_begin(const char *basename)
 void emit_unit_end(void)
 {
 	textbuf_emit(&unit_post_text);
-	printf("\t.ident\t\"sparse silly x86 backend (built %s)\"\n", __DATE__);
+	printf("\t.ident\t\"sparse silly x86 backend (version %s)\"\n", SPARSE_VERSION);
 }
 
 /* conditionally switch sections */
-- 
2.14.1

