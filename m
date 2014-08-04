From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 03/10] don't call isdigit/tolower with a char argument
Date: Mon, 04 Aug 2014 19:34:30 +0100
Message-ID: <53DFD236.8090309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:36183 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751330AbaHDSkf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:40:35 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id DA7D86F89A8
	for <linux-sparse@vger.kernel.org>; Mon,  4 Aug 2014 17:58:38 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


This suppresses some "array subscript has type 'char'" warnings from
gcc (version 4.8.3). (see also, commit cf5114a1)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 expression.c | 2 +-
 lib.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/expression.c b/expression.c
index 4353dbe..7293d47 100644
--- a/expression.c
+++ b/expression.c
@@ -240,7 +240,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 
 static unsigned long long parse_num(const char *nptr, char **end)
 {
-	if (nptr[0] == '0' && tolower(nptr[1]) == 'b')
+	if (nptr[0] == '0' && tolower((unsigned char)nptr[1]) == 'b')
 		return strtoull(&nptr[2], end, 2);
 	return strtoull(nptr, end, 0);
 }
diff --git a/lib.c b/lib.c
index 4e6fc81..9c7767e 100644
--- a/lib.c
+++ b/lib.c
@@ -281,7 +281,7 @@ static char **handle_switch_D(char *arg, char **next)
 	const char *name = arg + 1;
 	const char *value = "1";
 
-	if (!*name || isspace(*name))
+	if (!*name || isspace((unsigned char)*name))
 		die("argument to `-D' is missing");
 
 	for (;;) {
@@ -699,7 +699,7 @@ static char **handle_param(char *arg, char **next)
 	/* For now just skip any '--param=*' or '--param *' */
 	if (*arg == '\0') {
 		value = *++next;
-	} else if (isspace(*arg) || *arg == '=') {
+	} else if (isspace((unsigned char)*arg) || *arg == '=') {
 		value = ++arg;
 	}
 
-- 
2.0.0
