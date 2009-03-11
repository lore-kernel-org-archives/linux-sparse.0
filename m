From: Al Viro <viro@ftp.linux.org.uk>
Subject: Simplify get_number_value() and ctype_integer()
Date: Wed, 11 Mar 2009 07:08:15 +0000
Message-ID: <E1LhIY3-0003yb-Dv@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55276 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbZCKHIR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Mar 2009 03:08:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LhIY3-0003yb-Dv
	for linux-sparse@vger.kernel.org; Wed, 11 Mar 2009 07:08:15 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


There's no point whatsoever in constructing modifiers for chosen
type when decoding integer constant only to have them picked
apart by ctype_integer().  Seeing that the former is the only
caller of the latter these days, we can bloody well just pass
the rank and signedness explicitly and save a lot of efforts.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expression.c |   40 ++++++++++++++++++++--------------------
 parse.c      |   13 ++-----------
 parse.h      |    2 +-
 3 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/expression.c b/expression.c
index 124a8ec..7c88a28 100644
--- a/expression.c
+++ b/expression.c
@@ -272,7 +272,7 @@ static void get_number_value(struct expression *expr, struct token *token)
 	const char *str = token->number;
 	unsigned long long value;
 	char *end;
-	unsigned long modifiers = 0;
+	int size = 0, want_unsigned = 0;
 	int overflow = 0, do_warn = 0;
 	int try_unsigned = 1;
 	int bits;
@@ -284,55 +284,55 @@ static void get_number_value(struct expression *expr, struct token *token)
 	if (value == ULLONG_MAX && errno == ERANGE)
 		overflow = 1;
 	while (1) {
-		unsigned long added;
 		char c = *end++;
 		if (!c) {
 			break;
 		} else if (c == 'u' || c == 'U') {
-			added = MOD_UNSIGNED;
+			if (want_unsigned)
+				goto Enoint;
+			want_unsigned = 1;
 		} else if (c == 'l' || c == 'L') {
-			added = MOD_LONG;
+			if (size)
+				goto Enoint;
+			size = 1;
 			if (*end == c) {
-				added |= MOD_LONGLONG;
+				size = 2;
 				end++;
 			}
 		} else
 			goto Float;
-		if (modifiers & added)
-			goto Enoint;
-		modifiers |= added;
 	}
 	if (overflow)
 		goto Eoverflow;
 	/* OK, it's a valid integer */
 	/* decimals can be unsigned only if directly specified as such */
-	if (str[0] != '0' && !(modifiers & MOD_UNSIGNED))
+	if (str[0] != '0' && !want_unsigned)
 		try_unsigned = 0;
-	if (!(modifiers & MOD_LONG)) {
+	if (!size) {
 		bits = bits_in_int - 1;
 		if (!(value & (~1ULL << bits))) {
 			if (!(value & (1ULL << bits))) {
 				goto got_it;
 			} else if (try_unsigned) {
-				modifiers |= MOD_UNSIGNED;
+				want_unsigned = 1;
 				goto got_it;
 			}
 		}
-		modifiers |= MOD_LONG;
+		size = 1;
 		do_warn = 1;
 	}
-	if (!(modifiers & MOD_LONGLONG)) {
+	if (size < 2) {
 		bits = bits_in_long - 1;
 		if (!(value & (~1ULL << bits))) {
 			if (!(value & (1ULL << bits))) {
 				goto got_it;
 			} else if (try_unsigned) {
-				modifiers |= MOD_UNSIGNED;
+				want_unsigned = 1;
 				goto got_it;
 			}
 			do_warn |= 2;
 		}
-		modifiers |= MOD_LONGLONG;
+		size = 2;
 		do_warn |= 1;
 	}
 	bits = bits_in_longlong - 1;
@@ -343,14 +343,14 @@ static void get_number_value(struct expression *expr, struct token *token)
 	if (!try_unsigned)
 		warning(expr->pos, "decimal constant %s is too big for long long",
 			show_token(token));
-	modifiers |= MOD_UNSIGNED;
+	want_unsigned = 1;
 got_it:
 	if (do_warn)
 		warning(expr->pos, "constant %s is so big it is%s%s%s",
 			show_token(token),
-			(modifiers & MOD_UNSIGNED) ? " unsigned":"",
-			(modifiers & MOD_LONG) ? " long":"",
-			(modifiers & MOD_LONGLONG) ? " long":"");
+			want_unsigned ? " unsigned":"",
+			size > 0 ? " long":"",
+			size > 1 ? " long":"");
 	if (do_warn & 2)
 		warning(expr->pos,
 			"decimal constant %s is between LONG_MAX and ULONG_MAX."
@@ -359,7 +359,7 @@ got_it:
 			show_token(token));
         expr->type = EXPR_VALUE;
 	expr->flags = Int_const_expr;
-        expr->ctype = ctype_integer(modifiers);
+        expr->ctype = ctype_integer(size, want_unsigned);
         expr->value = value;
 	return;
 Eoverflow:
diff --git a/parse.c b/parse.c
index fa0c511..e99ca3d 100644
--- a/parse.c
+++ b/parse.c
@@ -1262,18 +1262,9 @@ static struct symbol * const * const types[] = {
 	real_types + 1, char_types, char_types + 1, char_types + 2
 };
 
-struct symbol *ctype_integer(unsigned long spec)
+struct symbol *ctype_integer(int size, int want_unsigned)
 {
-	int size;
-
-	if (spec & MOD_LONGLONG)
-		size = 2;
-	else if (spec & MOD_LONG)
-		size = 1;
-	else
-		size = 0;
