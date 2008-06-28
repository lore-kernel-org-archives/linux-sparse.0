From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 17:17:43 -0700
Message-ID: <70318cbf0806271717v42f4b1e0ocbdf9498b1417878@mail.gmail.com>
References: <486428D7.8080603@cowlark.com> <48643191.307@cowlark.com>
	 <1214560196.20755.73.camel@tara.firmix.at>
	 <4864C710.8000208@cowlark.com>
	 <1214565644.20755.80.camel@tara.firmix.at>
	 <4864F31C.3090606@cowlark.com>
	 <1214577926.20755.98.camel@tara.firmix.at>
	 <48650B35.5040505@cowlark.com>
	 <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com>
	 <486578A9.7000900@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:25021 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbYF1ARs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 20:17:48 -0400
Received: by yw-out-2324.google.com with SMTP id 9so306217ywe.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 17:17:43 -0700 (PDT)
In-Reply-To: <486578A9.7000900@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

Your patch is white space damaged.

While you are there, you might want to consider macro

bits_to_byte(x)
byte_to_bits(x)

To isolate out the conversion. It should generate the same code.
Marginally more readable.

Chris

On Fri, Jun 27, 2008 at 4:32 PM, David Given <dg@cowlark.com> wrote:
> Christopher Li wrote:
> [...]
>> You are right that point out a bug (assumption) of sparse which byte is 8 bits.
>> Using bits_in_byte is instead of 8 is better there.
>> Using bits_in_char assumes char has same bits as byte. That is my read
>> of the C spec.
>
> Yes, indeed, I'd managed to get my terminology muddled to the confusion
> of everyone.
>
> Okay, I've gone and looked at the implementation of this stuff; it would
> appear that modifying the code to supply the back end with units scaled
> in something other than C chars is actually quite complicated, so I
> haven't tried to do that. However, I'm enclosing a patch that should,
> hopefully, fix the cases where it's assuming 8 bit bytes. Hopefully I've
>  managed to catch all the cases, without breaking the octal parse code...
>
> (I haven't used git before; is this the right format?)
>
> --
> ┌─── ｄｇ＠ｃｏｗｌａｒｋ．ｃｏｍ ───── http://www.cowlark.com ─────
> │ "I have always wished for my computer to be as easy to use as my
> │ telephone; my wish has come true because I can no longer figure out
> │ how to use my telephone." --- Bjarne Stroustrup
>
> commit 0752e02d2c7c3f67b7c1835c86bf77f11c8384dd
> Author: dg <dg@cowlark.com>
> Date:   Sat Jun 28 00:24:36 2008 +0100
>
>    Changed use of hardcoded 8s when converting bits to bytes to use bits_in_char instead.
>
> diff --git a/compile-i386.c b/compile-i386.c
> index 8526408..3bbc9c7 100644
> --- a/compile-i386.c
> +++ b/compile-i386.c
> @@ -1584,7 +1584,7 @@ static struct storage *emit_select_expr(struct expression *expr)
>        /*
>         * Do the actual select: check the conditional for zero,
>         * move false over true if zero
> -        */
> +        */
>        insn("test", reg_cond, reg_cond, NULL);
>        insn("cmovz", reg_false, reg_true, NULL);
>
> @@ -2081,7 +2081,7 @@ static struct storage *x86_call_expression(struct expression *expr)
>                insn("pushl", new, NULL,
>                     !framesize ? "begin function call" : NULL);
>
> -               framesize += size >> 3;
> +               framesize += size / bits_in_char;
>        } END_FOR_EACH_PTR_REVERSE(arg);
>
>        fn = expr->fn;
> diff --git a/evaluate.c b/evaluate.c
> index 2a126dd..6018e0c 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -87,13 +87,13 @@ static struct symbol *evaluate_string(struct expression *expr)
>        array->ctype.alignment = 1;
>        array->ctype.modifiers = MOD_STATIC;
>        array->ctype.base_type = &char_ctype;
> -
> +
>        addr->symbol = sym;
>        addr->ctype = &lazy_ptr_ctype;
>
>        expr->type = EXPR_PREOP;
>        expr->op = '*';
> -       expr->unop = addr;
> +       expr->unop = addr;
>        expr->ctype = sym;
>        return sym;
>  }
> @@ -579,7 +579,7 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
>        }
>
>        /* Get the size of whatever the pointer points to */
> -       multiply = base->bit_size >> 3;
> +       multiply = base->bit_size / bits_in_char;
>
>        if (ctype == &null_ctype)
>                ctype = &ptr_ctype;
> @@ -831,7 +831,7 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
>                struct expression *sub = alloc_expression(expr->pos, EXPR_BINOP);
>                struct expression *div = expr;
>                struct expression *val = alloc_expression(expr->pos, EXPR_VALUE);
> -               unsigned long value = lbase->bit_size >> 3;
> +               unsigned long value = lbase->bit_size / bits_in_char;
>
>                val->ctype = size_t_ctype;
>                val->value = value;
> @@ -850,7 +850,7 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
>                div->left = sub;
>                div->right = val;
>        }
> -
> +
>        return ssize_t_ctype;
>  }
>
> @@ -1591,7 +1591,7 @@ static struct symbol *degenerate(struct expression *expr)
>                                e3->op = '+';
>                                e3->left = e0;
>                                e3->right = alloc_const_expression(expr->pos,
> -                                                       expr->r_bitpos >> 3);
> +                                                       expr->r_bitpos / bits_in_char);
>                                e3->ctype = &lazy_ptr_ctype;
>                        } else {
>                                e3 = e0;
> @@ -1727,7 +1727,7 @@ static struct symbol *evaluate_postop(struct expression *expr)
>        } else if (class == TYPE_PTR) {
>                struct symbol *target = examine_pointer_target(ctype);
>                if (!is_function(target))
> -                       multiply = target->bit_size >> 3;
> +                       multiply = target->bit_size / bits_in_char;
>        }
>
>        if (multiply) {
> @@ -1850,7 +1850,7 @@ static struct symbol *find_identifier(struct ident *ident, struct symbol_list *_
>                                        continue;
>                                *offset += sym->offset;
>                                return sub;
> -                       }
> +                       }
>                }
>        } while ((list = list->next) != head);
>        return NULL;
> @@ -1949,7 +1949,7 @@ static struct symbol *evaluate_member_dereference(struct expression *expr)
>                        expr->base = deref->base;
>                        expr->r_bitpos = deref->r_bitpos;
>                }
> -               expr->r_bitpos += offset << 3;
> +               expr->r_bitpos += offset * bits_in_char;
>                expr->type = EXPR_SLICE;
>                expr->r_nrbits = member->bit_size;
>                expr->r_bitpos += member->bit_offset;
> @@ -2040,7 +2040,7 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
>        if ((size < 0) || (size & 7))
>                expression_error(expr, "cannot size expression");
>        expr->type = EXPR_VALUE;
> -       expr->value = size >> 3;
> +       expr->value = size / bits_in_char;
>        expr->taint = 0;
>        expr->ctype = size_t_ctype;
>        return size_t_ctype;
> @@ -2074,7 +2074,7 @@ static struct symbol *evaluate_ptrsizeof(struct expression *expr)
>        if (size & 7)
>                size = 0;
>        expr->type = EXPR_VALUE;
> -       expr->value = size >> 3;
> +       expr->value = size / bits_in_char;
>        expr->taint = 0;
>        expr->ctype = size_t_ctype;
>        return size_t_ctype;
> @@ -2865,7 +2865,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
>                        unrestrict(idx, i_class, &i_type);
>                        idx = cast_to(idx, size_t_ctype);
>                        m = alloc_const_expression(expr->pos,
> -                                                  ctype->bit_size >> 3);
> +                                                  ctype->bit_size / bits_in_char);
>                        m->ctype = size_t_ctype;
>                        m->flags = Int_const_expr;
>                        expr->type = EXPR_BINOP;
> diff --git a/example.c b/example.c
> index ae897dc..b844d4f 100644
> --- a/example.c
> +++ b/example.c
> @@ -27,7 +27,7 @@ static const char *opcodes[] = {
>        [OP_INVOKE] = "invoke",
>        [OP_COMPUTEDGOTO] = "jmp *",
>        [OP_UNWIND] = "unwind",
> -
> +
>        /* Binary */
>        [OP_ADD] = "add",
>        [OP_SUB] = "sub",
> @@ -40,7 +40,7 @@ static const char *opcodes[] = {
>        [OP_SHL] = "shl",
>        [OP_LSR] = "lsr",
>        [OP_ASR] = "asr",
> -
> +
>        /* Logical */
>        [OP_AND] = "and",
>        [OP_OR] = "or",
> @@ -66,7 +66,7 @@ static const char *opcodes[] = {
>
>        /* Special three-input */
>        [OP_SEL] = "select",
> -
> +
>        /* Memory */
>        [OP_MALLOC] = "malloc",
>        [OP_FREE] = "free",
> @@ -818,7 +818,7 @@ static const char *generic(struct bb_state *state, pseudo_t pseudo)
>                put_operand(state, op);
>                reg = target_reg(state, pseudo, NULL);
>                output_insn(state, "lea %s,%s", show_op(state, op), reg->name);
> -               return reg->name;
> +               return reg->name;
>
>        default:
>                str = show_op(state, op);
> @@ -870,7 +870,7 @@ static void kill_dead_reg(struct hardreg *reg)
>  {
>        if (reg->dead) {
>                pseudo_t p;
> -
> +
>                FOR_EACH_PTR(reg->contains, p) {
>                        if (CURRENT_TAG(p) & TAG_DEAD) {
>                                DELETE_CURRENT_PTR(p);
> @@ -1011,7 +1011,7 @@ static void kill_pseudo(struct bb_state *state, pseudo_t pseudo)
>                                continue;
>                        if (CURRENT_TAG(p) & TAG_DEAD)
>                                reg->dead--;
> -                       output_comment(state, "removing pseudo %s from reg %s",
> +                       output_comment(state, "removing pseudo %s from reg %s",
>                                show_pseudo(pseudo), reg->name);
>                        DELETE_CURRENT_PTR(p);
>                } END_FOR_EACH_PTR(p);
> @@ -1069,7 +1069,7 @@ static const char *conditional[] = {
>        [OP_SET_BE] = "be",
>        [OP_SET_AE] = "ae"
>  };
> -
> +
>
>  static void generate_branch(struct bb_state *state, struct instruction *br)
>  {
> @@ -1187,7 +1187,7 @@ static void replace_asm_percent(const char **src_p, char **dst_p, struct asm_arg
>                if (index < nr)
>                        replace_asm_arg(dst_p, args+index);
>                break;
> -       }
> +       }
>        *src_p = src;
>        return;
>  }
> @@ -1583,7 +1583,7 @@ static int final_pseudo_flush(struct bb_state *state, pseudo_t pseudo, struct ha
>        struct hardreg *dst;
>
>        /*
> -        * Since this pseudo is live at exit, we'd better have output
> +        * Since this pseudo is live at exit, we'd better have output
>         * storage for it..
>         */
>        hash = find_storage_hash(pseudo, state->outputs);
> @@ -1829,8 +1829,8 @@ static void set_up_arch_entry(struct entrypoint *ep, struct instruction *entry)
>
>                        in->type = REG_FRAME;
>                        in->offset = offset;
> -
> -                       offset += bits >> 3;
> +
> +                       offset += bits / bits_in_char;
>                }
>                i++;
>                NEXT_PTR_LIST(argtype);
> @@ -1936,7 +1936,7 @@ static int compile(struct symbol_list *list)
>                if (ep)
>                        output(ep);
>        } END_FOR_EACH_PTR(sym);
> -
> +
>        return 0;
>  }
>
> diff --git a/expand.c b/expand.c
> index 032f0c5..d1aa019 100644
> --- a/expand.c
> +++ b/expand.c
> @@ -100,7 +100,7 @@ Int:
>        // Stop here unless checking for truncation
>        if (!Wcast_truncate || conservative)
>                return;
> -
> +
>        // Check if we dropped any bits..
>        oldsignmask = 1ULL << (old_size-1);
>        oldmask = oldsignmask | (oldsignmask-1);
> @@ -179,7 +179,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
>                sl |= ~(mask-1);
>        if (is_signed && (sr & mask))
>                sr |= ~(mask-1);
> -
> +
>        switch (CONVERT(expr->op,is_signed)) {
>        case SIGNED('+'):
>        case UNSIGNED('+'):
> @@ -224,7 +224,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
>
>        case UNSIGNED('/'):
>                if (!r) goto Div;
> -               v = l / r;
> +               v = l / r;
>                break;
>
>        case SIGNED('%'):
> @@ -241,7 +241,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
>        case SIGNED(SPECIAL_LEFTSHIFT):
>        case UNSIGNED(SPECIAL_LEFTSHIFT):
>                v = l << r;
> -               break;
> +               break;
>
>        case SIGNED(SPECIAL_RIGHTSHIFT):
>                v = sl >> r;
> @@ -536,7 +536,7 @@ static int expand_conditional(struct expression *expr)
>
>        return cost + cond_cost + BRANCH_COST;
>  }
> -
> +
>  static int expand_assignment(struct expression *expr)
>  {
>        expand_expression(expr->left);
> @@ -822,7 +822,7 @@ static int expand_expression_list(struct expression_list *list)
>        return cost;
>  }
>
> -/*
> +/*
>  * We can simplify nested position expressions if
>  * this is a simple (single) positional expression.
>  */
> @@ -880,7 +880,7 @@ static unsigned long bit_offset(const struct expression *expr)
>  {
>        unsigned long offset = 0;
>        while (expr->type == EXPR_POS) {
> -               offset += expr->init_offset << 3;
> +               offset += expr->init_offset * bits_in_char;
>                expr = expr->init_expr;
>        }
>        if (expr && expr->ctype)
> diff --git a/flow.c b/flow.c
> index 82fb23a..bdb2c25 100644
> --- a/flow.c
> +++ b/flow.c
> @@ -16,6 +16,7 @@
>  #include "expression.h"
>  #include "linearize.h"
>  #include "flow.h"
> +#include "target.h"
>
>  unsigned long bb_generation;
>
> @@ -265,8 +266,8 @@ void convert_load_instruction(struct instruction *insn, pseudo_t src)
>
>  static int overlapping_memop(struct instruction *a, struct instruction *b)
>  {
> -       unsigned int a_start = a->offset << 3;
> -       unsigned int b_start = b->offset << 3;
> +       unsigned int a_start = a->offset * bits_in_char;
> +       unsigned int b_start = b->offset * bits_in_char;
>        unsigned int a_size = a->size;
>        unsigned int b_size = b->size;
>
> @@ -364,11 +365,11 @@ found_dominator:
>                use_pseudo(insn, phi, add_pseudo(dominators, phi));
>        } END_FOR_EACH_PTR(parent);
>        return 1;
> -}
> +}
>
>  /*
>  * We should probably sort the phi list just to make it easier to compare
> - * later for equality.
> + * later for equality.
>  */
>  void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
>  {
> @@ -529,7 +530,7 @@ static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct b
>  * This should see if the "insn" trivially dominates some previous store, and kill the
>  * store if unnecessary.
>  */
> -static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
> +static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
>        unsigned long generation, struct basic_block *bb, int local, int found)
>  {
>        struct instruction *one;
> @@ -581,13 +582,14 @@ void check_access(struct instruction *insn)
>        pseudo_t pseudo = insn->src;
>
>        if (insn->bb && pseudo->type == PSEUDO_SYM) {
> -               int offset = insn->offset, bit = (offset << 3) + insn->size;
> +               int offset = insn->offset, bit = (offset * bits_in_char) + insn->size;
>                struct symbol *sym = pseudo->sym;
>
>                if (sym->bit_size > 0 && (offset < 0 || bit > sym->bit_size))
>                        warning(insn->pos, "invalid access %s '%s' (%d %d)",
>                                offset < 0 ? "below" : "past the end of",
> -                               show_ident(sym->ident), offset, sym->bit_size >> 3);
> +                               show_ident(sym->ident), offset,
> +                               sym->bit_size / bits_in_char);
>        }
>  }
>
> @@ -705,7 +707,7 @@ external_visibility:
>                        } END_FOR_EACH_PTR(bb);
>                }
>        }
> -
> +
>        return;
>  }
>
> @@ -887,7 +889,7 @@ static void vrfy_children(struct basic_block *bb)
>        default:
>                break;
>        }
> -
> +
>        FOR_EACH_PTR(bb->children, tmp) {
>                vrfy_bb_in_list(bb, tmp->parents);
>        } END_FOR_EACH_PTR(tmp);
> diff --git a/show-parse.c b/show-parse.c
> index 064af32..63d9144 100644
> --- a/show-parse.c
> +++ b/show-parse.c
> @@ -246,8 +246,8 @@ deeper:
>
>                s = modifier_string(mod);
>                len = strlen(s);
> -               name->start -= len;
> -               memcpy(name->start, s, len);
> +               name->start -= len;
> +               memcpy(name->start, s, len);
>                mod = 0;
>                as = 0;
>        }
> @@ -412,7 +412,7 @@ void show_symbol(struct symbol *sym)
>                struct statement *stmt = type->stmt;
>                if (stmt) {
>                        int val;
> -                       printf("\n");
> +                       printf("\n");
>                        val = show_statement(stmt);
>                        if (val)
>                                printf("\tmov.%d\t\tretval,%d\n", stmt->ret->bit_size, val);
> @@ -589,7 +589,7 @@ int show_statement(struct statement *stmt)
>                if (pre_condition) {
>                        if (pre_condition->type == EXPR_VALUE) {
>                                if (!pre_condition->value) {
> -                                       loop_bottom = new_label();
> +                                       loop_bottom = new_label();
>                                        printf("\tjmp\t\t.L%d\n", loop_bottom);
>                                }
>                        } else {
> @@ -623,7 +623,7 @@ int show_statement(struct statement *stmt)
>        }
>        case STMT_NONE:
>                break;
> -
> +
>        case STMT_LABEL:
>                printf(".L%p:\n", stmt->label_identifier);
>                show_statement(stmt->label_statement);
> @@ -649,9 +649,9 @@ int show_statement(struct statement *stmt)
>                int val = show_expression(stmt->range_expression);
>                int low = show_expression(stmt->range_low);
>                int high = show_expression(stmt->range_high);
> -               printf("\trange( %d %d-%d)\n", val, low, high);
> +               printf("\trange( %d %d-%d)\n", val, low, high);
>                break;
> -       }
> +       }
>        }
>        return 0;
>  }
> @@ -673,7 +673,7 @@ static int show_call_expression(struct expression *expr)
>                int new = show_expression(arg);
>                int size = arg->ctype->bit_size;
>                printf("\tpush.%d\t\tv%d\n", size, new);
> -               framesize += size >> 3;
> +               framesize += size / bits_in_char;
>        } END_FOR_EACH_PTR_REVERSE(arg);
>
>        fn = expr->fn;
> @@ -845,7 +845,7 @@ static int show_inc_dec(struct expression *expr, int postop)
>        printf("\t%s.%d\t\tv%d,v%d,$1\n", opname, bits, new, retval);
>        show_store_gen(bits, new, expr->unop, addr);
>        return retval;
> -}
> +}
>
>  static int show_preop(struct expression *expr)
>  {
> @@ -864,7 +864,7 @@ static int show_preop(struct expression *expr)
>  static int show_postop(struct expression *expr)
>  {
>        return show_inc_dec(expr, 1);
> -}
> +}
>
>  static int show_symbol_expr(struct symbol *sym)
>  {
> @@ -918,7 +918,7 @@ static int show_cast_expr(struct expression *expr)
>
>        old_type = expr->cast_expression->ctype;
>        new_type = expr->cast_type;
> -
> +
>        oldbits = old_type->bit_size;
>        newbits = new_type->bit_size;
>        if (oldbits >= newbits)
> @@ -1017,7 +1017,7 @@ again:
>                        entry = entry->ident_expression;
>                        goto again;
>                }
> -
> +
>                if (entry->type == EXPR_INDEX) {
>                        printf(" AT '%d..%d:\n", entry->idx_from, entry->idx_to);
>                        entry = entry->idx_expression;
> @@ -1057,11 +1057,11 @@ int show_expression(struct expression *expr)
>                        pos->line, pos->pos);
>                return 0;
>        }
> -
> +
>        switch (expr->type) {
>        case EXPR_CALL:
>                return show_call_expression(expr);
> -
> +
>        case EXPR_ASSIGNMENT:
>                return show_assignment(expr);
>
> diff --git a/symbol.c b/symbol.c
> index 3292907..a22731f 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -22,7 +22,7 @@
>
>  /*
>  * Secondary symbol list for stuff that needs to be output because it
> - * was used.
> + * was used.
>  */
>  struct symbol_list *translation_unit_used_list = NULL;
>
> @@ -117,7 +117,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
>        }
>
>        bit_size = info->bit_size;
> -       base_size = sym->bit_size;
> +       base_size = sym->bit_size;
>
>        /*
>         * Unsized arrays cause us to not align the resulting
> @@ -128,7 +128,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
>                base_size = 0;
>        }
>
> -       align_bit_mask = (sym->ctype.alignment << 3) - 1;
> +       align_bit_mask = (sym->ctype.alignment * bits_in_char) - 1;
>
>        /*
>         * Bitfields have some very special rules..
> @@ -143,7 +143,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
>                        bit_size = (bit_size + align_bit_mask) & ~align_bit_mask;
>                        bit_offset = 0;
>                }
> -               sym->offset = (bit_size - bit_offset) >> 3;
> +               sym->offset = (bit_size - bit_offset) / bits_in_char;
>                sym->bit_offset = bit_offset;
>                sym->ctype.base_type->bit_offset = bit_offset;
>                info->bit_size = bit_size + width;
> @@ -156,7 +156,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
>         * Otherwise, just align it right and add it up..
>         */
>        bit_size = (bit_size + align_bit_mask) & ~align_bit_mask;
> -       sym->offset = bit_size >> 3;
> +       sym->offset = bit_size / bits_in_char;
>
>        info->bit_size = bit_size + base_size;
>        // warning (sym->pos, "regular: offset=%d", sym->offset);
> @@ -182,7 +182,7 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
>                sym->ctype.alignment = info.max_align;
>        bit_size = info.bit_size;
>        if (info.align_size) {
> -               bit_align = (sym->ctype.alignment << 3)-1;
> +               bit_align = (sym->ctype.alignment * bits_in_char)-1;
>                bit_size = (bit_size + bit_align) & ~bit_align;
>        }
>        sym->bit_size = bit_size;
> @@ -340,7 +340,7 @@ static struct symbol * examine_node_type(struct symbol *sym)
>                if (node_type && node_type->bit_size >= 0)
>                        bit_size = node_type->bit_size * count;
>        }
> -
> +
>        sym->bit_size = bit_size;
>        return sym;
>  }
> @@ -654,7 +654,7 @@ static int expand_warning(struct expression *expr, int cost)
>        FOR_EACH_PTR (arglist, arg) {
>                /*
>                 * Constant strings get printed out as a warning. By the
> -                * time we get here, the EXPR_STRING has been fully
> +                * time we get here, the EXPR_STRING has been fully
>                 * evaluated, so by now it's an anonymous symbol with a
>                 * string initializer.
>                 *
> @@ -877,7 +877,7 @@ void init_ctype(void)
>                struct symbol *sym = ctype->ptr;
>                unsigned long bit_size = ctype->bit_size ? *ctype->bit_size : -1;
>                unsigned long maxalign = ctype->maxalign ? *ctype->maxalign : 0;
> -               unsigned long alignment = (bit_size + 7) >> 3;
> +               unsigned long alignment = (bit_size + bits_in_char - 1) / bits_in_char;
>
>                if (alignment > maxalign)
>                        alignment = maxalign;
> diff --git a/target.c b/target.c
> index bf1bb8f..a0ee010 100644
> --- a/target.c
> +++ b/target.c
> @@ -11,6 +11,8 @@ struct symbol *ssize_t_ctype = &int_ctype;
>  */
>  int max_alignment = 16;
>
> +int bits_in_unit = 8;
> +
>  /*
>  * Integer data types
>  */
> diff --git a/tokenize.c b/tokenize.c
> index e72c56e..67daa97 100644
> --- a/tokenize.c
> +++ b/tokenize.c
> @@ -96,7 +96,7 @@ static char *charstr(char *ptr, unsigned char c, unsigned char escape, unsigned
>        }
>        if (!isdigit(next))
>                return ptr + sprintf(ptr, "%o", c);
> -
> +
>        return ptr + sprintf(ptr, "%03o", c);
>  }
>
> @@ -161,7 +161,7 @@ const char *show_token(const struct token *token)
>        case TOKEN_STREAMEND:
>                sprintf(buffer, "<end of '%s'>", stream_name(token->pos.stream));
>                return buffer;
> -
> +
>        default:
>                return "WTF???";
>        }
> @@ -483,7 +483,7 @@ static int escapechar(int first, int type, stream_t *stream, int *valp)
>                                int nr = 2;
>                                value -= '0';
>                                while (next >= '0' && next <= '9') {
> -                                       value = (value << 3) + (next-'0');
> +                                       value = (value*8) + (next-'0');
>                                        next = nextchar(stream);
>                                        if (!--nr)
>                                                break;
> @@ -572,7 +572,7 @@ static int get_string_token(int next, stream_t *stream)
>        token_type(token) = TOKEN_STRING;
>        token->string = string;
>        add_token(stream);
> -
> +
>        return next;
>  }
>
> @@ -875,7 +875,7 @@ static int get_one_identifier(int c, stream_t *stream)
>        token->ident = ident;
>        add_token(stream);
>        return next;
> -}
> +}
>
>  static int get_one_token(int c, stream_t *stream)
>  {
>
>
