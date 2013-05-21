From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/5] Fix some "unknown format" warnings
Date: Tue, 21 May 2013 20:17:37 +0100
Message-ID: <519BC851.5090202@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:33940 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520Ab3EUT2L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 15:28:11 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compile-i386.c |  7 ++++---
 example.c      |  7 ++++---
 expand.c       |  5 +++--
 linearize.c    | 15 ++++++++++-----
 parse.c        |  3 ++-
 pre-process.c  |  7 ++++++-
 show-parse.c   | 15 ++++++++++-----
 sparse.c       |  3 ++-
 tokenize.c     |  4 ++--
 9 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index b470952..8ac43d8 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <assert.h>
+#include <inttypes.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -435,7 +436,7 @@ static const char *stor_op_name(struct storage *s)
 		strcpy(name, s->reg->name);
 		break;
 	case STOR_VALUE:
-		sprintf(name, "$%Ld", s->value);
+		sprintf(name, "$%"PRId64, s->value);
 		break;
 	case STOR_LABEL:
 		sprintf(name, "%s.L%d", s->flags & STOR_LABEL_VAL ? "$" : "",
@@ -920,7 +921,7 @@ static void emit_scalar(struct expression *expr, unsigned int bit_size)
 
 	assert(type != NULL);
 
-	printf("\t.%s\t%Ld\n", type, ll);
+	printf("\t.%s\t%"PRId64"\n", type, ll);
 }
 
 static void emit_global_noinit(const char *name, unsigned long modifiers,
@@ -2222,7 +2223,7 @@ static struct storage *x86_symbol_expr(struct symbol *sym)
 		return new;
 	}
 	if (sym->ctype.modifiers & MOD_ADDRESSABLE) {
-		printf("\taddi.%d\t\tv%d,vFP,$%lld\n", bits_in_pointer, new->pseudo, sym->value);
+		printf("\taddi.%d\t\tv%d,vFP,$%"PRId64"\n", bits_in_pointer, new->pseudo, sym->value);
 		return new;
 	}
 	printf("\taddi.%d\t\tv%d,vFP,$offsetof(%s:%p)\n", bits_in_pointer, new->pseudo, show_ident(sym->ident), sym);
diff --git a/example.c b/example.c
index 24444c6..db768e4 100644
--- a/example.c
+++ b/example.c
@@ -6,6 +6,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <assert.h>
+#include <inttypes.h>
 
 #include "symbol.h"
 #include "expression.h"
@@ -187,7 +188,7 @@ static const char *show_op(struct bb_state *state, struct operand *op)
 	case OP_REG:
 		return op->reg->name;
 	case OP_VAL:
-		sprintf(p, "$%lld", op->value);
+		sprintf(p, "$%"PRId64, op->value);
 		break;
 	case OP_MEM:
 	case OP_ADDR:
@@ -597,7 +598,7 @@ static struct hardreg *fill_reg(struct bb_state *state, struct hardreg *hardreg,
 
 	switch (pseudo->type) {
 	case PSEUDO_VAL:
-		output_insn(state, "movl $%lld,%s", pseudo->value, hardreg->name);
+		output_insn(state, "movl $%"PRId64",%s", pseudo->value, hardreg->name);
 		break;
 	case PSEUDO_SYM:
 		src = find_pseudo_storage(state, pseudo, NULL);
@@ -1050,7 +1051,7 @@ static void generate_cast(struct bb_state *state, struct instruction *insn)
 		unsigned long long mask;
 		mask = ~(~0ULL << old);
 		mask &= ~(~0ULL << new);
-		output_insn(state, "andl.%d $%#llx,%s", insn->size, mask, dst->name);
+		output_insn(state, "andl.%d $%#"PRIx64",%s", insn->size, mask, dst->name);
 	}
 	add_pseudo_reg(state, insn->target, dst);
 }
diff --git a/expand.c b/expand.c
index effd27b..67a1bfb 100644
--- a/expand.c
+++ b/expand.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <inttypes.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -96,7 +97,7 @@ Int:
 	if (is_bool_type(newtype)) {
 		expr->value = !!value;
 		if (!conservative && value != 0 && value != 1)
-			warning(old->pos, "odd constant _Bool cast (%llx becomes 1)", value);
+			warning(old->pos, "odd constant _Bool cast (%"PRIx64" becomes 1)", value);
 		return;
 	}
 
@@ -117,7 +118,7 @@ Int:
 	// OK if the bits were (and still are) purely sign bits
 	if (value & dropped) {
 		if (!(value & oldsignmask) || !(value & signmask) || (value & dropped) != dropped)
-			warning(old->pos, "cast truncates bits from constant value (%llx becomes %llx)",
+			warning(old->pos, "cast truncates bits from constant value (%"PRIx64" becomes %"PRIx64")",
 				value & oldmask,
 				value & mask);
 	}
diff --git a/linearize.c b/linearize.c
index 1d15cfd..d587187 100644
--- a/linearize.c
+++ b/linearize.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <assert.h>
+#include <inttypes.h>
 
 #include "parse.h"
 #include "expression.h"
@@ -121,7 +122,7 @@ const char *show_pseudo(pseudo_t pseudo)
 		if (expr) {
 			switch (expr->type) {
 			case EXPR_VALUE:
-				snprintf(buf, 64, "<symbol value: %lld>", expr->value);
+				snprintf(buf, 64, "<symbol value: %"PRId64">", expr->value);
 				break;
 			case EXPR_STRING:
 				return show_string(expr->string);
@@ -139,9 +140,9 @@ const char *show_pseudo(pseudo_t pseudo)
 	case PSEUDO_VAL: {
 		long long value = pseudo->value;
 		if (value > 1000 || value < -1000)
-			snprintf(buf, 64, "$%#llx", value);
+			snprintf(buf, 64, "$%#"PRIx64, value);
 		else
-			snprintf(buf, 64, "$%lld", value);
+			snprintf(buf, 64, "$%"PRId64, value);
 		break;
 	}
 	case PSEUDO_ARG:
@@ -336,10 +337,14 @@ const char *show_instruction(struct instruction *insn)
 			
 		switch (expr->type) {
 		case EXPR_VALUE:
-			buf += sprintf(buf, "%lld", expr->value);
+			buf += sprintf(buf, "%"PRId64, expr->value);
 			break;
 		case EXPR_FVALUE:
+#if !defined(__MINGW32__)
 			buf += sprintf(buf, "%Lf", expr->fvalue);
+#else
+			buf += sprintf(buf, "%f", (double)expr->fvalue);
+#endif
 			break;
 		case EXPR_STRING:
 			buf += sprintf(buf, "%.40s", show_string(expr->string));
@@ -463,7 +468,7 @@ const char *show_instruction(struct instruction *insn)
 	}
 
 	if (buf >= buffer + sizeof(buffer))
-		die("instruction buffer overflowed %td\n", buf - buffer);
+		die("instruction buffer overflowed %d\n", (int)(buf - buffer));
 	do { --buf; } while (*buf == ' ');
 	*++buf = 0;
 	return buffer;
diff --git a/parse.c b/parse.c
index 7b89cc3..151e6b1 100644
--- a/parse.c
+++ b/parse.c
@@ -18,6 +18,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <inttypes.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -1756,7 +1757,7 @@ static struct token *handle_bitfield(struct token *token, struct decl_state *ctx
 	bitfield->bit_size = width;
 
 	if (width < 0 || width > INT_MAX) {
-		sparse_error(token->pos, "invalid bitfield width, %lld.", width);
+		sparse_error(token->pos, "invalid bitfield width, %"PRId64".", width);
 		width = -1;
 	} else if (*ctx->ident && width == 0) {
 		sparse_error(token->pos, "invalid named zero-width bitfield `%s'",
diff --git a/pre-process.c b/pre-process.c
index d521318..0becdc4 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -158,12 +158,17 @@ static int expand_one_symbol(struct token **list)
 	} else if (token->ident == &__DATE___ident) {
 		if (!t)
 			time(&t);
+#if !defined(__MINGW32__)
 		strftime(buffer, 12, "%b %e %Y", localtime(&t));
+#else
+		strftime(buffer, 12, "%b %d %Y", localtime(&t));
+		if (buffer[4] == '0') buffer[4] = ' ';
+#endif
 		replace_with_string(token, buffer);
 	} else if (token->ident == &__TIME___ident) {
 		if (!t)
 			time(&t);
-		strftime(buffer, 9, "%T", localtime(&t));
+		strftime(buffer, 9, "%H:%M:%S", localtime(&t));
 		replace_with_string(token, buffer);
 	}
 	return 1;
diff --git a/show-parse.c b/show-parse.c
index 1333e30..ad1b1c6 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -15,6 +15,7 @@
 #include <ctype.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <inttypes.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -352,7 +353,7 @@ deeper:
 			append(name, " )");
 			was_ptr = 0;
 		}
-		append(name, "[%lld]", get_expression_value(sym->array_size));
+		append(name, "[%"PRId64"]", get_expression_value(sym->array_size));
 		break;
 
 	case SYM_RESTRICT:
@@ -502,10 +503,10 @@ static void show_switch_statement(struct statement *stmt)
 			printf("    default");
 		} else {
 			if (expr->type == EXPR_VALUE) {
-				printf("    case %lld", expr->value);
+				printf("    case %"PRId64, expr->value);
 				if (to) {
 					if (to->type == EXPR_VALUE) {
-						printf(" .. %lld", to->value);
+						printf(" .. %"PRId64, to->value);
 					} else {
 						printf(" .. what?");
 					}
@@ -911,7 +912,7 @@ static int show_symbol_expr(struct symbol *sym)
 		return new;
 	}
 	if (sym->ctype.modifiers & MOD_ADDRESSABLE) {
-		printf("\taddi.%d\t\tv%d,vFP,$%lld\n", bits_in_pointer, new, sym->value);
+		printf("\taddi.%d\t\tv%d,vFP,$%"PRId64"\n", bits_in_pointer, new, sym->value);
 		return new;
 	}
 	printf("\taddi.%d\t\tv%d,vFP,$offsetof(%s:%p)\n", bits_in_pointer, new, show_ident(sym->ident), sym);
@@ -971,7 +972,7 @@ static int show_value(struct expression *expr)
 	int new = new_pseudo();
 	unsigned long long value = expr->value;
 
-	printf("\tmovi.%d\t\tv%d,$%llu\n", expr->ctype->bit_size, new, value);
+	printf("\tmovi.%d\t\tv%d,$%"PRIu64"\n", expr->ctype->bit_size, new, value);
 	return new;
 }
 
@@ -980,7 +981,11 @@ static int show_fvalue(struct expression *expr)
 	int new = new_pseudo();
 	long double value = expr->fvalue;
 
+#if !defined(__MINGW32__)
 	printf("\tmovf.%d\t\tv%d,$%Lf\n", expr->ctype->bit_size, new, value);
+#else
+	printf("\tmovf.%d\t\tv%d,$%f\n", expr->ctype->bit_size, new, (double)value);
+#endif
 	return new;
 }
 
diff --git a/sparse.c b/sparse.c
index 67b7d9e..d0b7565 100644
--- a/sparse.c
+++ b/sparse.c
@@ -15,6 +15,7 @@
 #include <ctype.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <inttypes.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -138,7 +139,7 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
 	if (count->type == PSEUDO_VAL) {
 		long long val = count->value;
 		if (val <= 0 || val > 100000)
-			warning(insn->pos, "%s with byte count of %lld",
+			warning(insn->pos, "%s with byte count of %"PRId64,
 				show_ident(insn->func->sym->ident), val);
 		return;
 	}
diff --git a/tokenize.c b/tokenize.c
index 3eb643d..025dd84 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -547,8 +547,8 @@ static int get_one_number(int c, int next, stream_t *stream)
 	}
 
 	if (p == buffer_end) {
-		sparse_error(stream_pos(stream), "number token exceeds %td characters",
-		      buffer_end - buffer);
+		sparse_error(stream_pos(stream), "number token exceeds %d characters",
+		      (int)(buffer_end - buffer));
 		// Pretend we saw just "1".
 		buffer[0] = '1';
 		p = buffer + 1;
-- 
1.8.2

