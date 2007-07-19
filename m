From: ricknu-0@student.ltu.se
Subject: [PATCH] expression.c: Adding va_end().
Date: Thu, 19 Jul 2007 02:02:55 +0200
Message-ID: <1184803375.469eaa2f8bff0@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:42510 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937144AbXGSAC5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jul 2007 20:02:57 -0400
Received: from localhost (wc-special5.dc.ltu.se [130.240.42.175])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id l6J02tmn001908
	for <linux-sparse@vger.kernel.org>; Thu, 19 Jul 2007 02:02:55 +0200 (MEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Adding va_end().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
According to the manual, it needs a va_end() in the same function.

diff --git a/expression.c b/expression.c
index 77d665d..857ec08 100644
--- a/expression.c
+++ b/expression.c
@@ -30,15 +30,15 @@
 static int match_oplist(int op, ...)
 {
 	va_list args;
+	int nextop;
 
 	va_start(args, op);
-	for (;;) {
-		int nextop = va_arg(args, int);
-		if (!nextop)
-			return 0;
-		if (op == nextop)
-			return 1;
-	}
+	do {
+		nextop = va_arg(args, int);
+	} while (nextop != 0 && nextop != op);
+	va_end(args);
+
+	return nextop != 0;
 }
 
 static struct token *comma_expression(struct token *, struct expression **);
