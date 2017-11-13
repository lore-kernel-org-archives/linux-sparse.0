From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1/2] V2 Give the constant pseudo value a size
Date: Mon, 13 Nov 2017 23:28:03 +0800
Message-ID: <CANeU7Q=VPubjUkjWP20Ye8rA8d42OfVD=xM1U-quVqGK4kQb+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:53761 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbdKMP2F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Nov 2017 10:28:05 -0500
Received: by mail-yw0-f196.google.com with SMTP id q126so13695284ywq.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Nov 2017 07:28:04 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

Currently value pseudo does not have size.
This create a problem pointed out by Dibyendu.
When using LLVM, calling varidic function with
constant value, there is no where to find the
size.

Linus give out two suggestions. One is give pseudo
a size. The other one is the push instruction.
This is the implementation of the first suggestion.

The model is actual very simple. The pseudo is
exactly as before if you are not looking at the size.
There is a size at create time, which tag alone with
it.

I might not get all the type and cast of the constant
right, we can fix it later if we found some case I did
not cover.

Testing done:

- Test suite passed.
- Kernel compile get the exact same output as the RC5
  at similar time.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 flow.c      |  2 +-
 linearize.c | 23 +++++++++++++----------
 linearize.h |  8 ++++++--
 memops.c    |  2 +-
 simplify.c  | 20 ++++++++++----------
 5 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/flow.c b/flow.c
index 6b2c879a..fa5d31c8 100644
--- a/flow.c
+++ b/flow.c
@@ -517,7 +517,7 @@ found:
  if (!local)
  return 0;
  check_access(insn);
- convert_load_instruction(insn, value_pseudo(0));
+ convert_load_instruction(insn, value_pseudo(insn->type, 0));
  return 1;
  }

diff --git a/linearize.c b/linearize.c
index ba76397e..2aa3acb2 100644
--- a/linearize.c
+++ b/linearize.c
@@ -785,22 +785,25 @@ static pseudo_t symbol_pseudo(struct entrypoint
*ep, struct symbol *sym)
  return pseudo;
 }

-pseudo_t value_pseudo(long long val)
+pseudo_t value_pseudo(struct symbol *type, long long val)
 {
 #define MAX_VAL_HASH 64
  static struct pseudo_list *prev[MAX_VAL_HASH];
  int hash = val & (MAX_VAL_HASH-1);
  struct pseudo_list **list = prev + hash;
+ int size = type ? type->bit_size : value_size(val);
  pseudo_t pseudo;

+
  FOR_EACH_PTR(*list, pseudo) {
- if (pseudo->value == val)
+ if (pseudo->value == val && pseudo->size == size)
  return pseudo;
  } END_FOR_EACH_PTR(pseudo);

  pseudo = __alloc_pseudo(0);
  pseudo->type = PSEUDO_VAL;
  pseudo->value = val;
+ pseudo->size = size;
  add_pseudo(list, pseudo);

  /* Value pseudos have neither nr, usage nor def */
@@ -954,10 +957,10 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
  unsigned long long mask = (1ULL << size) - 1;

  if (shift) {
- store = add_binary_op(ep, ad->source_type, OP_SHL, value,
value_pseudo(shift));
+ store = add_binary_op(ep, ad->source_type, OP_SHL, value,
value_pseudo(ctype, shift));
  mask <<= shift;
  }
- orig = add_binary_op(ep, ad->source_type, OP_AND, orig, value_pseudo(~mask));
+ orig = add_binary_op(ep, ad->source_type, OP_AND, orig,
value_pseudo(ctype, ~mask));
  store = add_binary_op(ep, ad->source_type, OP_OR, orig, store);
  }
  add_store(ep, ad, store);
@@ -1002,7 +1005,7 @@ static pseudo_t linearize_load_gen(struct
entrypoint *ep, struct access_data *ad
  pseudo_t new = add_load(ep, ad);

  if (ctype->bit_offset) {
- pseudo_t shift = value_pseudo(ctype->bit_offset);
+ pseudo_t shift = value_pseudo(ctype, ctype->bit_offset);
  pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
  new = newval;
  }
@@ -1034,7 +1037,7 @@ static pseudo_t linearize_inc_dec(struct
entrypoint *ep, struct expression *expr
  return VOID;

  old = linearize_load_gen(ep, &ad);
- one = value_pseudo(expr->op_value);
+ one = value_pseudo(expr->ctype, expr->op_value);
  new = add_binary_op(ep, expr->ctype, op, old, one);
  linearize_store_gen(ep, new, &ad);
  finish_address_gen(ep, &ad);
@@ -1073,7 +1076,7 @@ static pseudo_t linearize_regular_preop(struct
entrypoint *ep, struct expression
  case '+':
  return pre;
  case '!': {
- pseudo_t zero = value_pseudo(0);
+ pseudo_t zero = value_pseudo(expr->ctype, 0);
  return add_binary_op(ep, expr->ctype, OP_SET_EQ, pre, zero);
  }
  case '~':
@@ -1165,7 +1168,7 @@ static inline pseudo_t
add_convert_to_bool(struct entrypoint *ep, pseudo_t src,

  if (is_bool_type(type))
  return src;
- zero = value_pseudo(0);
+ zero = value_pseudo(type, 0);
  op = OP_SET_NE;
  return add_binary_op(ep, &bool_ctype, op, src, zero);
 }
@@ -1591,7 +1594,7 @@ pseudo_t linearize_expression(struct entrypoint
*ep, struct expression *expr)
  return add_symbol_address(ep, expr->symbol);

  case EXPR_VALUE:
- return value_pseudo(expr->value);
+ return value_pseudo(expr->ctype, expr->value);

  case EXPR_STRING: case EXPR_FVALUE: case EXPR_LABEL:
  return add_setval(ep, expr->ctype, expr);
@@ -1681,7 +1684,7 @@ static pseudo_t linearize_one_symbol(struct
entrypoint *ep, struct symbol *sym)
  ad.result_type = sym;
  ad.source_type = base_type(sym);
  ad.address = symbol_pseudo(ep, sym);
- linearize_store_gen(ep, value_pseudo(0), &ad);
+ linearize_store_gen(ep, value_pseudo(sym, 0), &ad);
  }

  value = linearize_initializer(ep, sym->initializer, &ad);
diff --git a/linearize.h b/linearize.h
index bac82d7f..fd8e00d3 100644
--- a/linearize.h
+++ b/linearize.h
@@ -32,7 +32,10 @@ struct pseudo {
  int nr;
  enum pseudo_type type;
  struct pseudo_user_list *users;
- struct ident *ident;
+ union {
+ struct ident *ident;
+ int size; /* OP_SETVAL only */
+ };
  union {
  struct symbol *sym;
  struct instruction *def;
@@ -333,7 +336,8 @@ extern void insert_branch(struct basic_block *bb,
struct instruction *br, struct

 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size);
 pseudo_t alloc_pseudo(struct instruction *def);
-pseudo_t value_pseudo(long long val);
+pseudo_t value_pseudo(struct symbol *type, long long val);
+unsigned int value_size(long long value);

 struct entrypoint *linearize_symbol(struct symbol *sym);
 int unssa(struct entrypoint *ep);
diff --git a/memops.c b/memops.c
index aeacdf56..6a795c19 100644
--- a/memops.c
+++ b/memops.c
@@ -127,7 +127,7 @@ static void simplify_loads(struct basic_block *bb)
  if (!dominators) {
  if (local) {
  assert(pseudo->type != PSEUDO_ARG);
- convert_load_instruction(insn, value_pseudo(0));
+ convert_load_instruction(insn, value_pseudo(insn->type, 0));
  }
  goto next_load;
  }
diff --git a/simplify.c b/simplify.c
index 2bc86f53..1e926e7d 100644
--- a/simplify.c
+++ b/simplify.c
@@ -352,7 +352,7 @@ static int replace_with_pseudo(struct instruction
*insn, pseudo_t pseudo)
  return REPEAT_CSE;
 }

-static unsigned int value_size(long long value)
+unsigned int value_size(long long value)
 {
  value >>= 8;
  if (!value)
@@ -398,7 +398,7 @@ static int simplify_asr(struct instruction *insn,
pseudo_t pseudo, long long val

  if (value >= size) {
  warning(insn->pos, "right shift by bigger than source value");
- return replace_with_pseudo(insn, value_pseudo(0));
+ return replace_with_pseudo(insn, value_pseudo(insn->type, 0));
  }
  if (!value)
  return replace_with_pseudo(insn, pseudo);
@@ -508,7 +508,7 @@ static int simplify_constant_rightside(struct
instruction *insn)
  case OP_SUB:
  if (value) {
  insn->opcode = OP_ADD;
- insn->src2 = value_pseudo(-value);
+ insn->src2 = value_pseudo(insn->type, -value);
  return REPEAT_CSE;
  }
  /* Fall through */
@@ -525,7 +525,7 @@ static int simplify_constant_rightside(struct
instruction *insn)

  case OP_MODU: case OP_MODS:
  if (value == 1)
- return replace_with_pseudo(insn, value_pseudo(0));
+ return replace_with_pseudo(insn, value_pseudo(insn->type, 0));
  return 0;

  case OP_DIVU: case OP_DIVS:
@@ -686,7 +686,7 @@ static int simplify_constant_binop(struct instruction *insn)
  }
  res &= bits;

- replace_with_pseudo(insn, value_pseudo(res));
+ replace_with_pseudo(insn, value_pseudo(insn->type, res));
  return REPEAT_CSE;
 }

@@ -700,14 +700,14 @@ static int simplify_binop_same_args(struct
instruction *insn, pseudo_t arg)
  warning(insn->pos, "self-comparison always evaluates to false");
  case OP_SUB:
  case OP_XOR:
- return replace_with_pseudo(insn, value_pseudo(0));
+ return replace_with_pseudo(insn, value_pseudo(insn->type, 0));

  case OP_SET_EQ:
  case OP_SET_LE: case OP_SET_GE:
  case OP_SET_BE: case OP_SET_AE:
  if (Wtautological_compare)
  warning(insn->pos, "self-comparison always evaluates to true");
- return replace_with_pseudo(insn, value_pseudo(1));
+ return replace_with_pseudo(insn, value_pseudo(insn->type, 1));

  case OP_AND:
  case OP_OR:
@@ -716,7 +716,7 @@ static int simplify_binop_same_args(struct
instruction *insn, pseudo_t arg)
  case OP_AND_BOOL:
  case OP_OR_BOOL:
  remove_usage(arg, &insn->src2);
- insn->src2 = value_pseudo(0);
+ insn->src2 = value_pseudo(insn->type, 0);
  insn->opcode = OP_SET_NE;
  return REPEAT_CSE;

@@ -819,7 +819,7 @@ static int simplify_constant_unop(struct instruction *insn)
  mask = 1ULL << (insn->size-1);
  res &= mask | (mask-1);

- replace_with_pseudo(insn, value_pseudo(res));
+ replace_with_pseudo(insn, value_pseudo(insn->type, res));
  return REPEAT_CSE;
 }

@@ -952,7 +952,7 @@ static int simplify_cast(struct instruction *insn)
  if (constant(src)) {
  int sign = orig_type->ctype.modifiers & MOD_SIGNED;
  long long val = get_cast_value(src->value, orig_size, size, sign);
- src = value_pseudo(val);
+ src = value_pseudo(orig_type, val);
  goto simplify;
  }

-- 
2.13.6
