From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 14/16] warn on return <void expression>;
Date: Sun, 24 Jun 2007 09:05:31 +0100
Message-ID: <E1I2N6B-0003es-7p@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34709 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbXFXIFc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:05:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N6B-0003es-7p
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:05:31 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


conditional on -Wreturn-void

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |    2 ++
 lib.c      |    2 ++
 lib.h      |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index e3b4940..07ebf0c 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2790,6 +2790,8 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
 	if (!fntype || fntype == &void_ctype) {
 		if (expr && expr->ctype != &void_ctype)
 			expression_error(expr, "return expression in %s function", fntype?"void":"typeless");
+		if (expr && Wreturn_void)
+			warning(stmt->pos, "returning void-valued expression");
 		return NULL;
 	}
 
diff --git a/lib.c b/lib.c
index 4856b65..7f6334c 100644
--- a/lib.c
+++ b/lib.c
@@ -207,6 +207,7 @@ int Wuninitialized = 1;
 int Wold_initializer = 1;
 int Wnon_pointer_null = 1;
 int Wparen_string = 0;
+int Wreturn_void = 0;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
@@ -359,6 +360,7 @@ static const struct warning {
 	{ "old-initializer", &Wold_initializer },
 	{ "non-pointer-null", &Wnon_pointer_null },
 	{ "paren-string", &Wparen_string },
+	{ "return-void", &Wreturn_void },
 };
 
 enum {
diff --git a/lib.h b/lib.h
index 0fe4d2a..bc2a8c2 100644
--- a/lib.h
+++ b/lib.h
@@ -104,6 +104,7 @@ extern int Wuninitialized;
 extern int Wold_initializer;
 extern int Wnon_pointer_null;
 extern int Wparen_string;
+extern int Wreturn_void;
 
 extern int dbg_entry;
 extern int dbg_dead;
-- 
1.5.0-rc2.GIT
