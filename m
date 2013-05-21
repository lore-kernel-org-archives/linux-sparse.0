From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/5] Add the __restrict__ keyword
Date: Tue, 21 May 2013 20:15:44 +0100
Message-ID: <519BC7E0.7030403@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:33954 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752887Ab3EUT2M (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 15:28:12 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 ident-list.h          | 2 +-
 parse.c               | 3 ++-
 validation/reserved.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index e93aae7..78b4890 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -86,7 +86,7 @@ IDENT(stdcall); IDENT(__stdcall__);
 IDENT(fastcall); IDENT(__fastcall__);
 IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
-IDENT(restrict); IDENT(__restrict);
+IDENT(restrict); IDENT(__restrict); IDENT(__restrict__);
 IDENT(artificial); IDENT(__artificial__);
 IDENT(leaf); IDENT(__leaf__);
 IDENT(vector_size); IDENT(__vector_size__);
diff --git a/parse.c b/parse.c
index 890e56b..7b89cc3 100644
--- a/parse.c
+++ b/parse.c
@@ -419,6 +419,7 @@ static struct init_keyword {
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
@@ -1516,7 +1517,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 {
 	struct expression *expr = NULL;
 
-	if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
+	if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
 		token = token->next;
 	token = parse_expression(token, &expr);
 	sym->array_size = expr;
diff --git a/validation/reserved.c b/validation/reserved.c
index caacd21..e5d7af8 100644
--- a/validation/reserved.c
+++ b/validation/reserved.c
@@ -30,6 +30,7 @@ reserved.c:8:12: error: Trying to use reserved word '__const' as identifier
 reserved.c:9:12: error: Trying to use reserved word '__const__' as identifier
 reserved.c:10:12: error: Trying to use reserved word 'restrict' as identifier
 reserved.c:11:12: error: Trying to use reserved word '__restrict' as identifier
+reserved.c:12:12: error: Trying to use reserved word '__restrict__' as identifier
 reserved.c:13:12: error: Trying to use reserved word 'typedef' as identifier
 reserved.c:14:12: error: Trying to use reserved word '__typeof' as identifier
 reserved.c:15:12: error: Trying to use reserved word '__typeof__' as identifier
-- 
1.8.2

