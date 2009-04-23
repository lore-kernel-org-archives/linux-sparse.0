From: Martin Nagy <nagy.martin@gmail.com>
Subject: [PATCH] Add missing checks for Waddress-space
Date: Thu, 23 Apr 2009 22:25:19 +0200
Message-ID: <20090423222519.48191d61@notas>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49631 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbZDWU0i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 Apr 2009 16:26:38 -0400
Received: by ewy24 with SMTP id 24so741683ewy.37
        for <linux-sparse@vger.kernel.org>; Thu, 23 Apr 2009 13:26:36 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Some of these are missing in evaluate.c. Maybe we should change the
option to not consider address space at all, if unset. It would be much
easier to make attribute_address_space() ignore it.

Signed-off-by: Martin Nagy <nagy.martin@gmail.com>
---
 evaluate.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 5c3812e..be7a17c 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1149,7 +1149,7 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 			goto Err;
 		}
 		/* OK, it's pointer on pointer */
-		if (ltype->ctype.as != rtype->ctype.as) {
+		if (Waddress_space && ltype->ctype.as != rtype->ctype.as) {
 			typediff = "different address spaces";
 			goto Err;
 		}
@@ -1339,7 +1339,7 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 			 * we do not remove qualifiers from pointed to [C]
 			 * or mix address spaces [sparse].
 			 */
-			if (t->ctype.as != s->ctype.as) {
+			if (Waddress_space && t->ctype.as != s->ctype.as) {
 				typediff = "different address spaces";
 				goto Err;
 			}
-- 
1.6.0.6

