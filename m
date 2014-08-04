From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 01/10] Add the __restrict__ keyword
Date: Mon, 04 Aug 2014 19:32:50 +0100
Message-ID: <53DFD1D2.5050600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:36096 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751125AbaHDSif (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:38:35 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 59C3C6F8CE8
	for <linux-sparse@vger.kernel.org>; Mon,  4 Aug 2014 17:56:37 +0100 (BST)
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
index c0fc18f..d5a145f 100644
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
index 55a57a7..9767e59 100644
--- a/parse.c
+++ b/parse.c
@@ -435,6 +435,7 @@ static struct init_keyword {
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
@@ -1553,7 +1554,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 
 	token = abstract_array_static_declarator(token, &has_static);
 
-	if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
+	if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
 		token = abstract_array_static_declarator(token->next, &has_static);
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
2.0.0
