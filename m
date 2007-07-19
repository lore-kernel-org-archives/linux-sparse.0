From: ricknu-0@student.ltu.se
Subject: [PATCH] tokenize.c: Simplify drop_stream_eoln().
Date: Thu, 19 Jul 2007 02:01:28 +0200
Message-ID: <1184803288.469ea9d82a143@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:42425 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936495AbXGSABa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jul 2007 20:01:30 -0400
Received: from localhost (wc-special5.dc.ltu.se [130.240.42.175])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id l6J01Smn001754
	for <linux-sparse@vger.kernel.org>; Thu, 19 Jul 2007 02:01:28 +0200 (MEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Simplifying function drop_stream_eoln().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
Is there a reason to call nextchar() before drop_token()?

diff --git a/tokenize.c b/tokenize.c
index fbe4c5a..f4c3d18 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -578,15 +578,14 @@ static int get_string_token(int next, stream_t *stream)
 
 static int drop_stream_eoln(stream_t *stream)
 {
-	int next = nextchar(stream);
 	drop_token(stream);
 	for (;;) {
-		int curr = next;
-		if (curr == EOF)
-			return next;
-		next = nextchar(stream);
-		if (curr == '\n')
-			return next;
+		switch (nextchar(stream)) {
+		case EOF:
+			return EOF;
+		case '\n':
+			return nextchar(stream);
+		}
 	}
 }
 
