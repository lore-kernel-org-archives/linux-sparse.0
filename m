From: Pavel Roskin <proski@gnu.org>
Subject: [RFC PATCH] Make "bad constant expression" a warning, not an error
Date: Fri, 20 Jun 2008 11:08:28 -0400
Message-ID: <1213974508.18379.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:55031 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755812AbYFTPIb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Jun 2008 11:08:31 -0400
Received: from [192.168.0.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id E80CC618F22
	for <linux-sparse@vger.kernel.org>; Fri, 20 Jun 2008 11:08:29 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Do the same to "bad integer constant expression".  It's still possible
to continue parsing the code if those are not constant.  To be on the
safe side, assume the actual value to be the largest value for the
type.
---

 expand.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/expand.c b/expand.c
index 032f0c5..12a8989 100644
--- a/expand.c
+++ b/expand.c
@@ -1201,18 +1201,20 @@ static long long __get_expression_value(struct expression *expr, int strict)
 		expression_error(expr, "bad constant expression type");
 		return 0;
 	}
+
+	mask = 1ULL << (ctype->bit_size-1);
+
 	expand_expression(expr);
 	if (expr->type != EXPR_VALUE) {
-		expression_error(expr, "bad constant expression");
-		return 0;
+		warning(expr->pos, "bad constant expression");
+		return mask;
 	}
 	if (strict && bad_integer_constant_expression(expr)) {
-		expression_error(expr, "bad integer constant expression");
-		return 0;
+		warning(expr->pos, "bad integer constant expression");
+		return mask;
 	}
 
 	value = expr->value;
-	mask = 1ULL << (ctype->bit_size-1);
 
 	if (value & mask) {
 		while (ctype->type != SYM_BASETYPE)

-- 
Regards,
Pavel Roskin
