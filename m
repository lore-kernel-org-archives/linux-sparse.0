From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sat, 15 Aug 2009 17:57:15 +0300
Message-ID: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp4.welho.com ([213.243.153.38]:40161 "EHLO smtp4.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbZHOPPp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 15 Aug 2009 11:15:45 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, penberg@cs.helsinki.fi, torvalds@linux-foundation.org

Sparse prints a lot of warnings like this for user-space projects:

  /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:33:22: warning: undefined preprocessor identifier '__INT_MAX__'
  /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:64:5: warning: undefined preprocessor identifier '__SHRT_MAX__'
  /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:64:21: warning: undefined preprocessor identifier '__INT_MAX__'
  /usr/include/bits/xopen_lim.h:95:6: warning: undefined preprocessor identifier '__INT_MAX__'
  /usr/include/bits/xopen_lim.h:98:7: warning: undefined preprocessor identifier '__INT_MAX__'

Fix that up by defining some GCC pre-processor builtins.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 ident-list.h  |    7 +++++++
 pre-process.c |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 0ee81bc..c0a2735 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -99,6 +99,13 @@ __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
 
+__IDENT(__SCHAR_MAX__ident, "__SCHAR_MAX__", 0);
+__IDENT(__SHRT_MAX__ident, "__SHRT_MAX__", 0);
+__IDENT(__INT_MAX__ident, "__INT_MAX__", 0);
+__IDENT(__LONG_MAX__ident, "__LONG_MAX__", 0);
+__IDENT(__LONG_LONG_MAX__ident, "__LONG_LONG_MAX__", 0);
+__IDENT(__WCHAR_MAX__ident, "__WCHAR_MAX__", 0);
+
 /* Sparse commands */
 IDENT_RESERVED(__context__);
 IDENT_RESERVED(__range__);
diff --git a/pre-process.c b/pre-process.c
index 34b21ff..de3d3f1 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -106,6 +106,14 @@ static void replace_with_integer(struct token *token, unsigned int val)
 	token->number = buf;
 }
 
+static void replace_with_long_long(struct token *token, unsigned long long val)
+{
+	char *buf = __alloc_bytes(20);
+	sprintf(buf, "%llu", val);
+	token_type(token) = TOKEN_NUMBER;
+	token->number = buf;
+}
+
 static struct symbol *lookup_macro(struct ident *ident)
 {
 	struct symbol *sym = lookup_symbol(ident, NS_MACRO | NS_UNDEF);
@@ -167,6 +175,18 @@ static int expand_one_symbol(struct token **list)
 			time(&t);
 		strftime(buffer, 9, "%T", localtime(&t));
 		replace_with_string(token, buffer);
+	} else if (token->ident == &__SHRT_MAX__ident) {
+		replace_with_integer(token, __SHRT_MAX__);
+	} else if (token->ident == &__SCHAR_MAX__ident) {
+		replace_with_integer(token, __SCHAR_MAX__);
+	} else if (token->ident == &__INT_MAX__ident) {
+		replace_with_integer(token, __INT_MAX__);
+	} else if (token->ident == &__LONG_MAX__ident) {
+		replace_with_integer(token, __LONG_MAX__);
+	} else if (token->ident == &__LONG_LONG_MAX__ident) {
+		replace_with_long_long(token, __LONG_LONG_MAX__);
+	} else if (token->ident == &__WCHAR_MAX__ident) {
+		replace_with_integer(token, __WCHAR_MAX__);
 	}
 	return 1;
 }
-- 
1.5.6.3

