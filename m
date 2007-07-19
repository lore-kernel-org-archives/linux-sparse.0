From: ricknu-0@student.ltu.se
Subject: [PATCH] tokenize.c: Replacing handmade rutin with existing function.
Date: Thu, 19 Jul 2007 02:04:36 +0200
Message-ID: <1184803476.469eaa94bd1a8@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:42585 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759893AbXGSAEi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jul 2007 20:04:38 -0400
Received: from localhost (wc-special5.dc.ltu.se [130.240.42.175])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id l6J04amn002071
	for <linux-sparse@vger.kernel.org>; Thu, 19 Jul 2007 02:04:36 +0200 (MEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Replace handwritten with existing function.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
Equal, right?

diff --git a/tokenize.c b/tokenize.c
index fbe4c5a..e72c56e 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -792,16 +792,9 @@ static struct ident *create_hashed_ident(const char *name,
int len, unsigned lon
 	p = &hash_table[hash];
 	while ((ident = *p) != NULL) {
 		if (ident->len == (unsigned char) len) {
-			const char *n = name;
-			const char *m = ident->name;
-			int l = len;
-			do {
-				if (*n != *m)
-					goto next;
-				n++;
-				m++;
-			} while (--l);
-				
+			if (strncmp(name, ident->name, len) != 0)
+				goto next;
+
 			ident_hit++;
 			return ident;
 		}
