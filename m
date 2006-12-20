From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] adding anonymous string
Date: Tue, 19 Dec 2006 18:34:15 -0800
Message-ID: <20061220023415.GC8137@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:42185 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbWLTCug (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Dec 2006 21:50:36 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>, Linus Torvalds <torvalds@osdl.org>

Anonymous string is one exception that the back end does
need to generate storage on (read only) data section.

Currently in order to determine a symbol is anonymous string,
we can test:
	symbol is array
	and symbol has no ident.
	and symbol base type is char.
	and symbol initializer is a string expression.

This patch add a bitfield to easier identify an anonymous string.

Signed-off-by: Christopher Li <sparse@chrisli.org>

Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2006-12-12 02:04:05.000000000 -0800
+++ sparse/symbol.h	2006-12-12 02:05:24.000000000 -0800
@@ -118,7 +118,8 @@ struct symbol {
 					initialized:1,
 					examined:1,
 					expanding:1,
-					evaluated:1;
+					evaluated:1,
+					string:1;
 			struct expression *array_size;
 			struct ctype ctype;
 			struct symbol_list *arguments;
Index: sparse/evaluate.c
===================================================================
--- sparse.orig/evaluate.c	2006-12-12 02:04:05.000000000 -0800
+++ sparse/evaluate.c	2006-12-12 02:05:24.000000000 -0800
@@ -74,6 +74,7 @@ static struct symbol *evaluate_string(st
 	sym->array_size = alloc_const_expression(expr->pos, length);
 	sym->bit_size = bits_in_char * length;
 	sym->ctype.alignment = 1;
+	sym->string = 1;
 	sym->ctype.modifiers = MOD_STATIC;
 	sym->ctype.base_type = array;
 	sym->initializer = initstr;
