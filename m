From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH](take II) Sparse fooled by double semicolon
Date: Tue, 30 Jan 2007 23:17:17 -0800
Message-ID: <20070131071717.GA23495@chrisli.org>
References: <1170219027.11455.68.camel@dv> <20070131065838.GA23326@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:62110 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXAaHnj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 02:43:39 -0500
Content-Disposition: inline
In-Reply-To: <20070131065838.GA23326@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

Actually, this version is better because it handle semicolon
as the first member as well.

Fix double semicolon in struct declare

Pavel discover this test case:
#include <string.h>
void test(void)
{
       struct { int foo;; } val;
       memset(&val, 0, sizeof(val));
}

Sparse ends up create a node with empty ctype in the member list.
Skip that seems fix it.

Signed-Off-By: Christopher Li<spase@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-01-30 23:28:24.000000000 -0800
+++ sparse/parse.c	2007-01-30 23:34:21.000000000 -0800
@@ -1034,7 +1034,8 @@ static struct token *declaration_list(st
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
 {
 	while (!match_op(token, '}')) {
-		token = declaration_list(token, list);
+		if (!match_op(token, ';'))
+			token = declaration_list(token, list);
 		if (!match_op(token, ';')) {
 			sparse_error(token->pos, "expected ; at end of declaration");
 			break;
