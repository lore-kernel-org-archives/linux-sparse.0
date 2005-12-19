From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 1/2] introduce __sparse() function
Date: Mon, 19 Dec 2005 21:36:04 +0300
Message-ID: <43A6FD94.62011D1@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:45753 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932242AbVLSRUp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 19 Dec 2005 12:20:45 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

This patch adds __sparse() function for those users which
don't need evaluate.c (see the next patch).

Without this patch it is not possible to link test-dissect
statically, it has to redefine evaluate_symbol_list().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20051210/lib.h~1_SPARSE	2005-11-28 04:40:51.000000000 +0300
+++ git-snapshot-20051210/lib.h	2005-12-19 22:49:49.000000000 +0300
@@ -84,6 +84,7 @@ extern int Wone_bit_signed_bitfield;
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv);
+extern struct symbol_list *__sparse(char **argv);
 extern struct symbol_list *sparse(char **argv);
 
 static inline int symbol_list_size(struct symbol_list* list)
--- git-snapshot-20051210/lib.c~1_SPARSE	2005-11-28 04:40:51.000000000 +0300
+++ git-snapshot-20051210/lib.c	2005-12-19 22:47:50.000000000 +0300
@@ -629,7 +629,7 @@ struct symbol_list *sparse_initialize(in
 	return list;
 }
 
-struct symbol_list * sparse(char **argv)
+struct symbol_list * __sparse(char **argv)
 {
 	struct symbol_list *res;
 	char *filename, *next;
@@ -652,9 +652,16 @@ struct symbol_list * sparse(char **argv)
 	/* Drop the tokens for this file after parsing */
 	clear_token_alloc();
 
+	/* And return it */
+	return res;
+}
+
+struct symbol_list * sparse(char **argv)
+{
+	struct symbol_list *res = __sparse(argv);
+
 	/* Evaluate the complete symbol list */
 	evaluate_symbol_list(res);
 
-	/* And return it */
 	return res;
 }
