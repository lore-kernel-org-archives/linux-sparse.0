From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 02/15] Unhardcode byte size being 8 bits.
Date: Mon, 15 Dec 2008 03:26:00 +0300
Message-ID: <20081215002600.16107.80723.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63676 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYLOAQu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:16:50 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1154922bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:16:48 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

From: David Given <dg@cowlark.com>


---
 compile-i386.c |    2 +-
 evaluate.c     |   26 +++++++++++++-------------
 example.c      |    2 +-
 expand.c       |    2 +-
 flow.c         |   10 ++++++----
 show-parse.c   |    2 +-
 symbol.c       |   10 +++++-----
 target.h       |   10 ++++++++++
 8 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 8526408..37ea52e 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -2081,7 +2081,7 @@ static struct storage *x86_call_expression(struct expression *expr)
 		insn("pushl", new, NULL,
 		     !framesize ? "begin function call" : NULL);
 
-		framesize += size >> 3;
+		framesize += bits_to_bytes(size);
 	} END_FOR_EACH_PTR_REVERSE(arg);
 
 	fn = expr->fn;
diff --git a/evaluate.c b/evaluate.c
index e17da53..c501323 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -72,7 +72,7 @@ static struct symbol *evaluate_string(struct expression *expr)
 	unsigned int length = expr->string->length;
 
 	sym->array_size = alloc_const_expression(expr->pos, length);
-	sym->bit_size = bits_in_char * length;
+	sym->bit_size = bytes_to_bits(length);
 	sym->ctype.alignment = 1;
 	sym->string = 1;
 	sym->ctype.modifiers = MOD_STATIC;
@@ -83,7 +83,7 @@ static struct symbol *evaluate_string(struct expression *expr)
 	initstr->string = expr->string;
 
 	array->array_size = sym->array_size;
-	array->bit_size = bits_in_char * length;
+	array->bit_size = bytes_to_bits(length);
 	array->ctype.alignment = 1;
 	array->ctype.modifiers = MOD_STATIC;
 	array->ctype.base_type = &char_ctype;
@@ -579,7 +579,7 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 	}
 
 	/* Get the size of whatever the pointer points to */
-	multiply = base->bit_size >> 3;
+	multiply = bits_to_bytes(base->bit_size);
 
 	if (ctype == &null_ctype)
 		ctype = &ptr_ctype;
@@ -831,7 +831,7 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
 		struct expression *sub = alloc_expression(expr->pos, EXPR_BINOP);
 		struct expression *div = expr;
 		struct expression *val = alloc_expression(expr->pos, EXPR_VALUE);
-		unsigned long value = lbase->bit_size >> 3;
+		unsigned long value = bits_to_bytes(lbase->bit_size);
 
 		val->ctype = size_t_ctype;
 		val->value = value;
@@ -1591,7 +1591,7 @@ static struct symbol *degenerate(struct expression *expr)
 				e3->op = '+';
 				e3->left = e0;
 				e3->right = alloc_const_expression(expr->pos,
-							expr->r_bitpos >> 3);
+							bits_to_bytes(expr->r_bitpos));
 				e3->ctype = &lazy_ptr_ctype;
 			} else {
 				e3 = e0;
@@ -1727,7 +1727,7 @@ static struct symbol *evaluate_postop(struct expression *expr)
 	} else if (class == TYPE_PTR) {
 		struct symbol *target = examine_pointer_target(ctype);
 		if (!is_function(target))
-			multiply = target->bit_size >> 3;
+			multiply = bits_to_bytes(target->bit_size);
 	}
 
 	if (multiply) {
@@ -1949,7 +1949,7 @@ static struct symbol *evaluate_member_dereference(struct expression *expr)
 			expr->base = deref->base;
 			expr->r_bitpos = deref->r_bitpos;
 		}
-		expr->r_bitpos += offset << 3;
+		expr->r_bitpos += bytes_to_bits(offset);
 		expr->type = EXPR_SLICE;
 		expr->r_nrbits = member->bit_size;
 		expr->r_bitpos += member->bit_offset;
@@ -2037,10 +2037,10 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
 		return NULL;
 
 	size = type->bit_size;
-	if ((size < 0) || (size & 7))
+	if ((size < 0) || (size & (bits_in_char - 1)))
 		expression_error(expr, "cannot size expression");
 	expr->type = EXPR_VALUE;
-	expr->value = size >> 3;
+	expr->value = bits_to_bytes(size);
 	expr->taint = 0;
 	expr->ctype = size_t_ctype;
 	return size_t_ctype;
@@ -2071,10 +2071,10 @@ static struct symbol *evaluate_ptrsizeof(struct expression *expr)
 		return NULL;
 	}
 	size = type->bit_size;
-	if (size & 7)
+	if (size & (bits_in_char-1))
 		size = 0;
 	expr->type = EXPR_VALUE;
-	expr->value = size >> 3;
+	expr->value = bits_to_bytes(size);
 	expr->taint = 0;
 	expr->ctype = size_t_ctype;
 	return size_t_ctype;
@@ -2158,7 +2158,7 @@ static void convert_index(struct expression *e)
 	unsigned from = e->idx_from;
 	unsigned to = e->idx_to + 1;
 	e->type = EXPR_POS;
-	e->init_offset = from * (e->ctype->bit_size>>3);
+	e->init_offset = from * bits_to_bytes(e->ctype->bit_size);
 	e->init_nr = to - from;
 	e->init_expr = child;
 }
@@ -2865,7 +2865,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 			unrestrict(idx, i_class, &i_type);
 			idx = cast_to(idx, size_t_ctype);
 			m = alloc_const_expression(expr->pos,
-						   ctype->bit_size >> 3);
+						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
 			m->flags = Int_const_expr;
 			expr->type = EXPR_BINOP;
diff --git a/example.c b/example.c
index ae897dc..24444c6 100644
--- a/example.c
+++ b/example.c
@@ -1830,7 +1830,7 @@ static void set_up_arch_entry(struct entrypoint *ep, struct instruction *entry)
 			in->type = REG_FRAME;
 			in->offset = offset;
 			
-			offset += bits >> 3;
+			offset += bits_to_bytes(bits);
 		}
 		i++;
 		NEXT_PTR_LIST(argtype);
diff --git a/expand.c b/expand.c
index 032f0c5..3e962d1 100644
--- a/expand.c
+++ b/expand.c
@@ -880,7 +880,7 @@ static unsigned long bit_offset(const struct expression *expr)
 {
 	unsigned long offset = 0;
 	while (expr->type == EXPR_POS) {
-		offset += expr->init_offset << 3;
+		offset += bytes_to_bits(expr->init_offset);
 		expr = expr->init_expr;
 	}
 	if (expr && expr->ctype)
diff --git a/flow.c b/flow.c
index 82fb23a..5bd9a1d 100644
--- a/flow.c
+++ b/flow.c
@@ -16,6 +16,7 @@
 #include "expression.h"
 #include "linearize.h"
 #include "flow.h"
+#include "target.h"
 
 unsigned long bb_generation;
 
@@ -265,8 +266,8 @@ void convert_load_instruction(struct instruction *insn, pseudo_t src)
 
 static int overlapping_memop(struct instruction *a, struct instruction *b)
 {
-	unsigned int a_start = a->offset << 3;
-	unsigned int b_start = b->offset << 3;
+	unsigned int a_start = bytes_to_bits(a->offset);
+	unsigned int b_start = bytes_to_bits(b->offset);
 	unsigned int a_size = a->size;
 	unsigned int b_size = b->size;
 
@@ -581,13 +582,14 @@ void check_access(struct instruction *insn)
 	pseudo_t pseudo = insn->src;
 
 	if (insn->bb && pseudo->type == PSEUDO_SYM) {
-		int offset = insn->offset, bit = (offset << 3) + insn->size;
+		int offset = insn->offset, bit = bytes_to_bits(offset) + insn->size;
 		struct symbol *sym = pseudo->sym;
 
 		if (sym->bit_size > 0 && (offset < 0 || bit > sym->bit_size))
 			warning(insn->pos, "invalid access %s '%s' (%d %d)",
 				offset < 0 ? "below" : "past the end of",
-				show_ident(sym->ident), offset, sym->bit_size >> 3);
+				show_ident(sym->ident), offset,
+				bits_to_bytes(sym->bit_size));
 	}
 }
 
diff --git a/show-parse.c b/show-parse.c
index 064af32..c79a288 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -673,7 +673,7 @@ static int show_call_expression(struct expression *expr)
 		int new = show_expression(arg);
 		int size = arg->ctype->bit_size;
 		printf("\tpush.%d\t\tv%d\n", size, new);
-		framesize += size >> 3;
+		framesize += bits_to_bytes(size);
 	} END_FOR_EACH_PTR_REVERSE(arg);
 
 	fn = expr->fn;
diff --git a/symbol.c b/symbol.c
index 3292907..49560ee 100644
--- a/symbol.c
+++ b/symbol.c
@@ -128,7 +128,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 		base_size = 0;
 	}
 
-	align_bit_mask = (sym->ctype.alignment << 3) - 1;
+	align_bit_mask = bytes_to_bits(sym->ctype.alignment) - 1;
 
 	/*
 	 * Bitfields have some very special rules..
@@ -143,7 +143,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 			bit_size = (bit_size + align_bit_mask) & ~align_bit_mask;
 			bit_offset = 0;
 		}
-		sym->offset = (bit_size - bit_offset) >> 3;
+		sym->offset = bits_to_bytes(bit_size - bit_offset);
 		sym->bit_offset = bit_offset;
 		sym->ctype.base_type->bit_offset = bit_offset;
 		info->bit_size = bit_size + width;
@@ -156,7 +156,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 	 * Otherwise, just align it right and add it up..
 	 */
 	bit_size = (bit_size + align_bit_mask) & ~align_bit_mask;
-	sym->offset = bit_size >> 3;
+	sym->offset = bits_to_bytes(bit_size);
 
 	info->bit_size = bit_size + base_size;
 	// warning (sym->pos, "regular: offset=%d", sym->offset);
@@ -182,7 +182,7 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 		sym->ctype.alignment = info.max_align;
 	bit_size = info.bit_size;
 	if (info.align_size) {
-		bit_align = (sym->ctype.alignment << 3)-1;
+		bit_align = bytes_to_bits(sym->ctype.alignment)-1;
 		bit_size = (bit_size + bit_align) & ~bit_align;
 	}
 	sym->bit_size = bit_size;
@@ -877,7 +877,7 @@ void init_ctype(void)
 		struct symbol *sym = ctype->ptr;
 		unsigned long bit_size = ctype->bit_size ? *ctype->bit_size : -1;
 		unsigned long maxalign = ctype->maxalign ? *ctype->maxalign : 0;
-		unsigned long alignment = (bit_size + 7) >> 3;
+		unsigned long alignment = bits_to_bytes(bit_size + bits_in_char - 1);
 
 		if (alignment > maxalign)
 			alignment = maxalign;
diff --git a/target.h b/target.h
index 25f7948..e6b0a12 100644
--- a/target.h
+++ b/target.h
@@ -42,4 +42,14 @@ extern int pointer_alignment;
 extern int bits_in_enum;
 extern int enum_alignment;
 
+/*
+ * Helper functions for converting bits to bytes and vice versa.
+ */
+
+static inline int bits_to_bytes(int bits)
+{ return bits / bits_in_char; }
+
+static inline int bytes_to_bits(int bytes)
+{ return bytes * bits_in_char; }
+
 #endif

