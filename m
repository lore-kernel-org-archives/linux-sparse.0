From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] fix result type of relational and logical operators
Date: Mon, 27 May 2013 09:33:42 +0300
Message-ID: <CAOJsxLE9AEcAJwnPvPozpMDpzkgAgJex9qAYGPUT5XiwyWfr9A@mail.gmail.com>
References: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63777 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab3E0Gdo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 May 2013 02:33:44 -0400
Received: by mail-wi0-f172.google.com with SMTP id m6so1267370wiv.17
        for <linux-sparse@vger.kernel.org>; Sun, 26 May 2013 23:33:42 -0700 (PDT)
In-Reply-To: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, May 24, 2013 at 4:30 PM, Xi Wang <xi.wang@gmail.com> wrote:
> The result type of relational operators (e.g., x < y) and logical
> operators (e.g., x && y) in C should be int, rather than bool.
>
> For example, sparse incorrectly evaluates sizeof(x < y) to 1 (i.e.,
> sizeof(int)), which should have been sizeof(int).
>
> This patch fixes the result type of these operators in evaluation,
> linearization, and the LLVM backend.
>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Pekka Enberg <penberg@kernel.org>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
>  evaluate.c              | 15 +++++++++------
>  linearize.c             |  4 ++--
>  sparse-llvm.c           | 29 ++++++++++++++++++-----------
>  validation/cond_expr3.c | 17 +++++++++++++++++
>  4 files changed, 46 insertions(+), 19 deletions(-)
>  create mode 100644 validation/cond_expr3.c
>
> diff --git a/evaluate.c b/evaluate.c
> index 0dfa519..5d87444 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -860,12 +860,13 @@ static struct symbol *evaluate_logical(struct expression *expr)
>         if (!evaluate_conditional(expr->right, 0))
>                 return NULL;
>
> -       expr->ctype = &bool_ctype;
> +       /* the result is int [6.5.13(3), 6.5.14(3)] */
> +       expr->ctype = &int_ctype;
>         if (expr->flags) {
>                 if (!(expr->left->flags & expr->right->flags & Int_const_expr))
>                         expr->flags = 0;
>         }
> -       return &bool_ctype;
> +       return &int_ctype;
>  }
>
>  static struct symbol *evaluate_binop(struct expression *expr)
> @@ -1064,8 +1065,9 @@ static struct symbol *evaluate_compare(struct expression *expr)
>         return NULL;
>
>  OK:
> -       expr->ctype = &bool_ctype;
> -       return &bool_ctype;
> +       /* the result is int [6.5.8(6), 6.5.9(3)]*/
> +       expr->ctype = &int_ctype;
> +       return &int_ctype;
>  }
>
>  /*
> @@ -1805,14 +1807,15 @@ static struct symbol *evaluate_preop(struct expression *expr)
>                         warning(expr->pos, "%s degrades to integer",
>                                 show_typename(ctype->ctype.base_type));
>                 }
> -               ctype = &bool_ctype;
> +               /* the result is int [6.5.3.3(5)]*/
> +               ctype = &int_ctype;
>                 break;
>
>         default:
>                 break;
>         }
>         expr->ctype = ctype;
> -       return &bool_ctype;
> +       return ctype;
>  }
>
>  static struct symbol *find_identifier(struct ident *ident, struct symbol_list *_list, int *offset)
> diff --git a/linearize.c b/linearize.c
> index 1d15cfd..c6ada1e 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -1064,7 +1064,7 @@ static pseudo_t linearize_regular_preop(struct entrypoint *ep, struct expression
>                 return pre;
>         case '!': {
>                 pseudo_t zero = value_pseudo(0);
> -               return add_binary_op(ep, expr->unop->ctype, OP_SET_EQ, pre, zero);
> +               return add_binary_op(ep, expr->ctype, OP_SET_EQ, pre, zero);
>         }
>         case '~':
>                 return add_uniop(ep, expr, OP_NOT, pre);
> @@ -1418,7 +1418,7 @@ static pseudo_t linearize_compare(struct entrypoint *ep, struct expression *expr
>
>         pseudo_t src1 = linearize_expression(ep, expr->left);
>         pseudo_t src2 = linearize_expression(ep, expr->right);
> -       pseudo_t dst = add_binary_op(ep, expr->left->ctype, cmpop[expr->op], src1, src2);
> +       pseudo_t dst = add_binary_op(ep, expr->ctype, cmpop[expr->op], src1, src2);
>         return dst;
>  }
>
> diff --git a/sparse-llvm.c b/sparse-llvm.c
> index 6f2fbd6..6ee4c1d 100644
> --- a/sparse-llvm.c
> +++ b/sparse-llvm.c
> @@ -544,29 +544,34 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
>                 target = LLVMBuildXor(fn->builder, lhs, rhs, target_name);
>                 break;
>         case OP_AND_BOOL: {
> -               LLVMValueRef x, y;
> +               LLVMValueRef lhs_nz, rhs_nz;
> +               LLVMTypeRef dst_type;
>
> -               assert(!symbol_is_fp_type(insn->type));
> -
> -               y = LLVMBuildICmp(fn->builder, LLVMIntNE, lhs, LLVMConstInt(LLVMTypeOf(lhs), 0, 0), "y");
> -               x = LLVMBuildICmp(fn->builder, LLVMIntNE, rhs, LLVMConstInt(LLVMTypeOf(rhs), 0, 0), "x");
> +               lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, "");
> +               rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
> +               target = LLVMBuildAnd(fn->builder, lhs_nz, rhs_nz, target_name);
>
> -               target = LLVMBuildAnd(fn->builder, y, x, target_name);
> +               dst_type = insn_symbol_type(fn->module, insn);
> +               target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
>                 break;
>         }
>         case OP_OR_BOOL: {
> -               LLVMValueRef tmp;
> -
> -               assert(!symbol_is_fp_type(insn->type));
> +               LLVMValueRef lhs_nz, rhs_nz;
> +               LLVMTypeRef dst_type;
>
> -               tmp = LLVMBuildOr(fn->builder, rhs, lhs, "tmp");
> +               lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, "");
> +               rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
> +               target = LLVMBuildOr(fn->builder, lhs_nz, rhs_nz, target_name);
>
> -               target = LLVMBuildICmp(fn->builder, LLVMIntNE, tmp, LLVMConstInt(LLVMTypeOf(tmp), 0, 0), target_name);
> +               dst_type = insn_symbol_type(fn->module, insn);
> +               target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
>                 break;
>         }
>
>         /* Binary comparison */
>         case OP_BINCMP ... OP_BINCMP_END: {
> +               LLVMTypeRef dst_type = insn_symbol_type(fn->module, insn);
> +
>                 if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind) {
>                         LLVMIntPredicate op = translate_op(insn->opcode);
>
> @@ -576,6 +581,8 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
>
>                         target = LLVMBuildFCmp(fn->builder, op, lhs, rhs, target_name);
>                 }
> +
> +               target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
>                 break;
>         }
>         default:

Looks good to me. Chris, are you OK with me picking this up in the llvm tree?

                        Pekka
