From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 6/7] Warn about non-empty identifier list outside of definition
Date: Sat, 14 Feb 2009 12:25:55 +0000
Message-ID: <E1LYJal-0001pS-LD@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60902 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZBNMZ4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 07:25:56 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LYJal-0001pS-LD
	for linux-sparse@vger.kernel.org; Sat, 14 Feb 2009 12:25:55 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                         |   12 ++++++++++--
 validation/nested-declarator2.c |   14 ++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/parse.c b/parse.c
index 70cf2fb..9fe87e6 100644
--- a/parse.c
+++ b/parse.c
@@ -1271,8 +1271,16 @@ static enum kind which_kind(struct token *token, struct token **p,
 	if (token_type(next) == TOKEN_IDENT) {
 		if (lookup_type(next))
 			return (dont_nest || prefer_abstract) ? Proto : Nested;
-		if (dont_nest)
-			return (next == token->next) ? K_R : Bad_Func;
+		if (dont_nest) {
+			/* attributes in the K&R identifier list */
+			if (next != token->next)
+				return Bad_Func;
+			/* identifier list not in definition; complain */
+			if (prefer_abstract)
+				warning(token->pos,
+					"identifier list not in definition");
+			return K_R;
+		}
 		return Nested;
 	}
 
diff --git a/validation/nested-declarator2.c b/validation/nested-declarator2.c
index 700c802..795d01f 100644
--- a/validation/nested-declarator2.c
+++ b/validation/nested-declarator2.c
@@ -21,6 +21,7 @@ int y;
 static void w2(int ());
 static void w3(...);
 static void f9(__attribute__((mode(DI))) T);
+static void w4(int f(x,y));
 static void bad1(__attribute__((mode(DI))) x);
 static int (-bad2);
 static void [2](*bad3);
@@ -30,11 +31,12 @@ static void [2](*bad3);
 nested-declarator2.c:17:1: warning: non-ANSI definition of function 'w1'
 nested-declarator2.c:21:21: warning: non-ANSI function declaration of function '<noident>'
 nested-declarator2.c:22:16: warning: variadic functions must have one named argument
-nested-declarator2.c:24:44: error: Expected ) in function declarator
-nested-declarator2.c:24:44: error: got x
-nested-declarator2.c:25:13: error: Expected ) in nested declarator
-nested-declarator2.c:25:13: error: got -
-nested-declarator2.c:26:17: error: Expected ) in function declarator
-nested-declarator2.c:26:17: error: got *
+nested-declarator2.c:24:21: warning: identifier list not in definition
+nested-declarator2.c:25:44: error: Expected ) in function declarator
+nested-declarator2.c:25:44: error: got x
+nested-declarator2.c:26:13: error: Expected ) in nested declarator
+nested-declarator2.c:26:13: error: got -
+nested-declarator2.c:27:17: error: Expected ) in function declarator
+nested-declarator2.c:27:17: error: got *
  * check-error-end:
  */
-- 
1.5.6.6


