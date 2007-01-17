From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 10] Marking anonymous string.
Date: Tue, 16 Jan 2007 18:45:45 -0800
Message-ID: <20070117024545.GK962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([63.240.77.85]:60782 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXAQDIn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 22:08:43 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


The back end need to generate some storage for anonymous string. 
This simplify testing of anonymous string.

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
