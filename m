From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Support __COUNTER__ macro
Date: Fri, 23 Jan 2015 23:26:44 +0100
Message-ID: <20150123222644.GA691@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:43431 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbbAWWed (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 17:34:33 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Christopher Li <sparse@chrisli.org>

OUNTER__ macro is expanded to a sequential number starting from 0.
This is sometimes used to declare unique variable names.

Implement support for __COUNTER__ in sparse including a
small test program for the test suite.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I had hit this before - and then I saw a mil about it today.
So took a quick look at it.
It seems to work as expected.

 ident-list.h                             |  1 +
 pre-process.c                            |  3 +++
 validation/preprocessor/preprocessor24.c | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 validation/preprocessor/preprocessor24.c

diff --git a/ident-list.h b/ident-list.h
index d5a145f..98e1764 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -108,6 +108,7 @@ __IDENT(__TIME___ident, "__TIME__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
+__IDENT(__COUNTER__ident, "__COUNTER__", 0);
 
 /* Sparse commands */
 IDENT_RESERVED(__context__);
diff --git a/pre-process.c b/pre-process.c
index 1aa3d2c..67cc81f 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -181,6 +181,9 @@ static int expand_one_symbol(struct token **list)
 			time(&t);
 		strftime(buffer, 9, "%T", localtime(&t));
 		replace_with_string(token, buffer);
+	} else if (token->ident == &__COUNTER__ident) {
+		static int counter = 0;
+		replace_with_integer(token, counter++);
 	}
 	return 1;
 }
diff --git a/validation/preprocessor/preprocessor24.c b/validation/preprocessor/preprocessor24.c
new file mode 100644
index 0000000..381b823
--- /dev/null
+++ b/validation/preprocessor/preprocessor24.c
@@ -0,0 +1,20 @@
+#define DO_CONCAT(a, b) a##b
+#define CONCAT(a, b) DO_CONCAT(a, b)
+#define VARNAME(name) CONCAT(name, __COUNTER__)
+
+int VARNAME(x);
+int VARNAME(x);
+
+/*
+ * check-name: Preprocessor #24 __COUNTER__
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+int x0;
+int x1;
+* check-output-end
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
1.9.3

