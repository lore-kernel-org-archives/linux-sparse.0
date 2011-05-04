From: Ben Pfaff <blp@nicira.com>
Subject: [PATCH] evaluate: Allow sizeof(_Bool) to succeed.
Date: Wed,  4 May 2011 16:39:54 -0700
Message-ID: <1304552394-16280-1-git-send-email-blp@nicira.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 173-167-111-49-sfba.hfc.comcastbusiness.net ([173.167.111.49]:42951
	"EHLO leadville.nicira.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752327Ab1EEA0K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 May 2011 20:26:10 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: Ben Pfaff <blp@nicira.com>, linux-sparse@vger.kernel.org

Without this commit, sizeof(_Bool) provokes an error with "cannot size
expression" because _Bool is a 1-bit type and thus not a multiple of a full
byte in size.  But sizeof(_Bool) is valid C that should evaluate to 1, so
this commit fixes the problem and adds a regression test.

Signed-off-by: Ben Pfaff <blp@nicira.com>
---
 evaluate.c               |    4 +++-
 symbol.h                 |    7 +++++++
 validation/sizeof-bool.c |    9 +++++++++
 3 files changed, 19 insertions(+), 1 deletions(-)
 create mode 100644 validation/sizeof-bool.c

diff --git a/evaluate.c b/evaluate.c
index f8343c2..f196dbc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2033,7 +2033,9 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
 		size = bits_in_char;
 	}
 
-	if ((size < 0) || (size & (bits_in_char - 1)))
+	if (is_bool_type(type))
+		size = bits_in_char;
+	else if ((size < 0) || (size & (bits_in_char - 1)))
 		expression_error(expr, "cannot size expression");
 
 	expr->type = EXPR_VALUE;
diff --git a/symbol.h b/symbol.h
index e567305..2b8f20e 100644
--- a/symbol.h
+++ b/symbol.h
@@ -346,6 +346,13 @@ static inline int is_void_type(struct symbol *type)
 	return type == &void_ctype;
 }
 
+static inline int is_bool_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type == &bool_ctype;
+}
+
 static inline int is_function(struct symbol *type)
 {
 	return type && type->type == SYM_FN;
diff --git a/validation/sizeof-bool.c b/validation/sizeof-bool.c
new file mode 100644
index 0000000..dfcb12a
--- /dev/null
+++ b/validation/sizeof-bool.c
@@ -0,0 +1,9 @@
+static int a(void)
+{
+	return sizeof(_Bool);
+}
+/*
+ * check-name: sizeof(_Bool) is valid
+ * check-description: sizeof(_Bool) was rejected because _Bool is not an even
+ * number of bytes
+ */
-- 
1.7.4.4

