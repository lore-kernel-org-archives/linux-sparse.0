From: Josh Triplett <josht@vnet.ibm.com>
Subject: [PATCH 1/2] Add support for GCC's __builtin_types_compatible_p
	extension
Date: Wed, 05 Jul 2006 15:09:21 -0700
Message-ID: <1152137361.6507.133.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:52420 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965064AbWGEWJX
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Jul 2006 18:09:23 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k65M9KRh005265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 18:09:20 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k65M9gPb187936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 16:09:42 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k65M9JJ4002364
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 16:09:19 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k65M9JuR002332
	for <linux-sparse@vger.kernel.org>; Wed, 5 Jul 2006 16:09:19 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Parse and support GCC's __builtin_types_compatible_p extension, which takes
two types as arguments, and returns 1 for compatible types or 0 for
incompatible types.  Since sparse already supports comparisons with types as
the operands, just transform __builtin_types_compatible_p(a, b) into the
comparison a == b.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
The Linux -rt tree uses this extension, so sparse needs this change in
order to run on the -rt tree.

 expression.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 ident-list.h |    1 +
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/expression.c b/expression.c
index aabea6c..b1ffa6c 100644
--- a/expression.c
+++ b/expression.c
@@ -114,6 +114,45 @@ static int convert_function(struct token
 	return retval;
 }
 
+static struct token *parse_type(struct token *token, struct expression **tree)
+{
+	struct symbol *sym;
+	*tree = alloc_expression(token->pos, EXPR_TYPE);
+	token = typename(token, &sym);
+	if (sym->ident)
+		sparse_error(token->pos,
+			     "type expression should not include identifier "
+			     "\"%s\"", sym->ident->name);
+	(*tree)->symbol = sym;
+	return token;
+}
+
+static struct token *builtin_types_compatible_p_expr(struct token *token,
+						     struct expression **tree)
+{
+	struct expression *expr = alloc_expression(
+		token->pos, EXPR_COMPARE);
+	expr->op = SPECIAL_EQUAL;
+	token = token->next;
+	if (!match_op(token, '('))
+		return expect(token, '(',
+			      "after __builtin_types_compatible_p");
+	token = token->next;
+	token = parse_type(token, &expr->left);
+	if (!match_op(token, ','))
+		return expect(token, ',',
+			      "in __builtin_types_compatible_p");
+	token = token->next;
+	token = parse_type(token, &expr->right);
+	if (!match_op(token, ')'))
+		return expect(token, ')',
+			      "at end of __builtin_types_compatible_p");
+	token = token->next;
+	
+	*tree = expr;
+	return token;
+}
+
 static struct token *string_expression(struct token *token, struct expression *expr)
 {
 	struct string *string = token->string;
@@ -314,8 +353,14 @@ struct token *primary_expression(struct 
 		struct symbol *sym = lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
 		struct token *next = token->next;
 
-		if (!sym && convert_function(token))
-			goto handle_string;
+		if (!sym) {
+			if (convert_function(token))
+				goto handle_string;
+			if (token->ident == &__builtin_types_compatible_p_ident) {
+				token = builtin_types_compatible_p_expr(token, &expr);
+				break;
+			}
+		}
 
 		expr = alloc_expression(token->pos, EXPR_SYMBOL);
 
diff --git a/ident-list.h b/ident-list.h
index 3051e56..4381a4b 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -35,6 +35,7 @@ IDENT_RESERVED(__asm);
 IDENT_RESERVED(__alignof);
 IDENT_RESERVED(__alignof__); 
 IDENT_RESERVED(__sizeof_ptr__);
+IDENT_RESERVED(__builtin_types_compatible_p);
 
 /* Attribute names */
 IDENT(defined); IDENT(packed); IDENT(__packed__);
