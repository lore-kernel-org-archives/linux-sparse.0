From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Improve error message if using a member of an incomplete
	struct or union
Date: Tue, 05 Jun 2007 18:01:46 -0400
Message-ID: <20070605220145.5683.71073.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:42968 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759965AbXFEWBs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Jun 2007 18:01:48 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1Hvh5h-0004F7-8z
	for linux-sparse@vger.kernel.org; Tue, 05 Jun 2007 18:01:25 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1Hvh62-0001Tw-2S
	for linux-sparse@vger.kernel.org; Tue, 05 Jun 2007 18:01:46 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

sparse should distinguish two cases.  One is when the structure or union
is declared and the member is not found.  Another is when the structure
or union is not yet declared.  In the later case, the message should
indicate that the type is incomplete, rather than complain that the
particular member is not found.

Mention the incomplete type like gcc does, but provide the member name
too, it may be useful.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 evaluate.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 80ac7d1..f68b55e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1723,8 +1723,13 @@ static struct symbol *evaluate_member_dereference(struct expression *expr)
 			name = ctype->ident->name;
 			namelen = ctype->ident->len;
 		}
-		expression_error(expr, "no member '%s' in %s %.*s",
-			show_ident(ident), type, namelen, name);
+		if (ctype->symbol_list)
+			expression_error(expr, "no member '%s' in %s %.*s",
+				show_ident(ident), type, namelen, name);
+		else
+			expression_error(expr, "using member '%s' in "
+				"incomplete %s %.*s", show_ident(ident),
+				type, namelen, name);
 		return NULL;
 	}
 
