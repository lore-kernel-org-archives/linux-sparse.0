From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 8/18] Take the rest of storage class keywords to parse.c
Date: Mon, 09 Mar 2009 07:11:28 +0000
Message-ID: <E1LgZe4-0000uZ-1F@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43750 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbZCIHL3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:11:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZe4-0000uZ-1F
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:11:28 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c  |    6 ++++++
 symbol.c |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/parse.c b/parse.c
index 12d2bba..7b1cfb6 100644
--- a/parse.c
+++ b/parse.c
@@ -231,6 +231,12 @@ static struct init_keyword {
 	{ "restrict",	NS_TYPEDEF, .op = &qualifier_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &qualifier_op},
 
+	/* Storage class */
+	{ "auto",	NS_TYPEDEF, MOD_AUTO, .op = &modifier_op },
+	{ "register",	NS_TYPEDEF, MOD_REGISTER, .op = &modifier_op },
+	{ "static",	NS_TYPEDEF, MOD_STATIC, .op = &modifier_op },
+	{ "extern",	NS_TYPEDEF, MOD_EXTERN, .op = &modifier_op },
+
 	/* Statement */
 	{ "if",		NS_KEYWORD, .op = &if_op },
 	{ "return",	NS_KEYWORD, .op = &return_op },
diff --git a/symbol.c b/symbol.c
index c82e530..8a323b5 100644
--- a/symbol.c
+++ b/symbol.c
@@ -700,12 +700,6 @@ static struct sym_init {
 	unsigned int modifiers;
 	struct symbol_op *op;
 } symbol_init_table[] = {
-	/* Storage class */
-	{ "auto",	NULL,		MOD_AUTO },
-	{ "register",	NULL,		MOD_REGISTER },
-	{ "static",	NULL,		MOD_STATIC },
-	{ "extern",	NULL,		MOD_EXTERN },
