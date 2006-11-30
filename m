From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] delay removing file scope
Date: Thu, 30 Nov 2006 02:16:08 -0800
Message-ID: <20061130101608.GB27500@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([206.18.177.54]:10658 "EHLO
	alnrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S934962AbWK3K1u (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Nov 2006 05:27:50 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Sparse only returns the used symbol. By the time it return
the symbol, it already destroyed the file scope.

This patch preserve the file scope. The caller can
examine the unused symbols. e.g. If I want to generate
ctags base on sparse, it need those unused symbols.

Signed-off-by: Christopher Li <sparse@chrisli.org>

Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2006-11-30 01:55:06.000000000 -0800
+++ sparse/lib.c	2006-11-30 01:55:23.000000000 -0800
@@ -661,9 +661,8 @@
 	/* Clear previous symbol list */
 	translation_unit_used_list = NULL;
 
-	start_file_scope();
+	new_file_scope();
 	res = sparse_file(filename);
-	end_file_scope();
 
 	/* Drop the tokens for this file after parsing */
 	clear_token_alloc();
Index: sparse/scope.c
===================================================================
--- sparse.orig/scope.c	2006-11-30 01:54:23.000000000 -0800
+++ sparse/scope.c	2006-11-30 01:55:23.000000000 -0800
@@ -96,6 +96,13 @@
 	end_scope(&file_scope);
 }
 
+void new_file_scope(void)
+{
+	if (file_scope != &builtin_scope)
+		end_file_scope();
+	start_file_scope();
+}
+
 void end_symbol_scope(void)
 {
 	end_scope(&block_scope);
Index: sparse/scope.h
===================================================================
--- sparse.orig/scope.h	2006-11-30 01:54:23.000000000 -0800
+++ sparse/scope.h	2006-11-30 01:55:23.000000000 -0800
@@ -28,6 +28,7 @@
 
 extern void start_file_scope(void);
 extern void end_file_scope(void);
+extern void new_file_scope(void);
 
 extern void start_symbol_scope(void);
 extern void end_symbol_scope(void);
