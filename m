From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 3/7] builtin: unify the 2 tables of builtins
Date: Fri, 12 Jun 2020 02:01:17 +0100
Message-ID: <a35f60c0-a5e9-39ce-23bd-f6e3aeabaeac@ramsayjones.plus.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
 <20200610202735.84968-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:33068 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLBBY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 Jun 2020 21:01:24 -0400
In-Reply-To: <20200610202735.84968-4-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 10/06/2020 21:27, Luc Van Oostenryck wrote:
> Till now, 2 tables are used to initialize builtin functions:
> * an older, small one, without type information, used to set
>   a symbol_op to evaluate and/or expand the ones that have
>   effectively an effect.

Hmm, s/effectively an effect/some associated behaviour/?

> * a newer and bigger one which only contains what is effectively
>   the prototype for these builtins in order to avoid warnings
>   about undeclared functions.
> 
> It's kinda annoying to have 2 tables for this, even more so
> because most entries in the first table also need to be in the
> second one (for arguments type & number checking).

s/type & number/type and number/

> 
> Fix this by:
> * adding a field in the second table for the symbol_op
> * merging or moving the entries in the first table into
>   the second one.

I didn't check every entry below, but I didn't see any obvious
mistakes either!

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  builtin.c | 145 +++++++++++++++++++-----------------------------------
>  builtin.h |   1 +
>  2 files changed, 51 insertions(+), 95 deletions(-)
> 
> diff --git a/builtin.c b/builtin.c
> index aa9ce09c0f40..bb9ec65b2d20 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -377,6 +377,7 @@ static void declare_one_builtin(const struct builtin_fn *entry)
>  	sym->ctype.base_type = fun;
>  	sym->ctype.modifiers = MOD_TOPLEVEL;
>  	sym->builtin = 1;
> +	sym->op = entry->op;
>  
>  	fun->ctype.base_type = get_ctype(entry->ret_type);
>  	fun->variadic = entry->variadic;
> @@ -397,39 +398,39 @@ static void declare_builtins(const struct builtin_fn tbl[])
>  static const struct builtin_fn builtins_common[] = {
>  #define size_t_ctype	&size_t_alias
>  #define va_list_ctype	&ptr_ctype
> +	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
> +	{ "__builtin_constant_p", NULL, 1, .op = &constant_p_op },
> +	{ "__builtin_expect", &long_ctype, 0, { &long_ctype ,&long_ctype }, .op = &expect_op },
> +	{ "__builtin_safe_p", NULL, 1, .op = &safe_p_op },
> +	{ "__builtin_warning", NULL, 1, .op = &warning_op },
> +
>  	{ "__builtin_abort", &void_ctype, 0 },
>  	{ "__builtin_abs", &int_ctype , 0, { &int_ctype }},
> +	{ "__builtin_add_overflow", &bool_ctype, 1, .op = &overflow_op },
> +	{ "__builtin_add_overflow_p", &bool_ctype, 1, .op = &overflow_p_op },
>  	{ "__builtin_alloca", &ptr_ctype, 0, { size_t_ctype }},
> -	{ "__builtin_alpha_cmpbge", &long_ctype, 0, { &long_ctype, &long_ctype }},
> -	{ "__builtin_alpha_extbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> -	{ "__builtin_alpha_extwl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> -	{ "__builtin_alpha_insbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> -	{ "__builtin_alpha_inslh", &long_ctype, 0, { &long_ctype, &long_ctype }},
> -	{ "__builtin_alpha_insql", &long_ctype, 0, { &long_ctype, &long_ctype }},
> -	{ "__builtin_alpha_inswl", &long_ctype, 0, { &long_ctype, &long_ctype }},
>  	{ "__builtin_bcmp", &int_ctype , 0, { &const_ptr_ctype, &const_ptr_ctype, size_t_ctype }},
>  	{ "__builtin_bcopy", &void_ctype, 0, { &const_ptr_ctype, &ptr_ctype, size_t_ctype }},
> -	{ "__builtin_bswap16", &ushort_ctype, 0, { &ushort_ctype }},
> -	{ "__builtin_bswap32", &uint_ctype, 0, { &uint_ctype }},
> -	{ "__builtin_bswap64", &ullong_ctype, 0, { &ullong_ctype }},
> +	{ "__builtin_bswap16", &ushort_ctype, 0, { &ushort_ctype }, .op = &bswap_op },
> +	{ "__builtin_bswap32", &uint_ctype, 0, { &uint_ctype }, .op = &bswap_op },
> +	{ "__builtin_bswap64", &ullong_ctype, 0, { &ullong_ctype }, .op = &bswap_op },
>  	{ "__builtin_bzero", &void_ctype, 0, { &ptr_ctype, size_t_ctype }},
>  	{ "__builtin_calloc", &ptr_ctype, 0, { size_t_ctype, size_t_ctype }},
> -	{ "__builtin_clrsb", &int_ctype, 0, { &int_ctype }},
> -	{ "__builtin_clrsbl", &int_ctype, 0, { &long_ctype }},
> -	{ "__builtin_clrsbll", &int_ctype, 0, { &llong_ctype }},
> -	{ "__builtin_clz", &int_ctype, 0, { &int_ctype }},
> -	{ "__builtin_clzl", &int_ctype, 0, { &long_ctype }},
> -	{ "__builtin_clzll", &int_ctype, 0, { &llong_ctype }},
> -	{ "__builtin_ctz", &int_ctype, 0, { &int_ctype }},
> -	{ "__builtin_ctzl", &int_ctype, 0, { &long_ctype }},
> -	{ "__builtin_ctzll", &int_ctype, 0, { &llong_ctype }},
> +	{ "__builtin_clrsb", &int_ctype, 0, { &int_ctype }, .op = &clrsb_op },
> +	{ "__builtin_clrsbl", &int_ctype, 0, { &long_ctype }, .op = &clrsb_op },
> +	{ "__builtin_clrsbll", &int_ctype, 0, { &llong_ctype }, .op = &clrsb_op },
> +	{ "__builtin_clz", &int_ctype, 0, { &int_ctype }, .op = &clz_op },
> +	{ "__builtin_clzl", &int_ctype, 0, { &long_ctype }, .op = &clz_op },
> +	{ "__builtin_clzll", &int_ctype, 0, { &llong_ctype }, .op = &clz_op },
> +	{ "__builtin_ctz", &int_ctype, 0, { &int_ctype }, .op = &ctz_op },
> +	{ "__builtin_ctzl", &int_ctype, 0, { &long_ctype }, .op = &ctz_op },
> +	{ "__builtin_ctzll", &int_ctype, 0, { &llong_ctype }, .op = &ctz_op },
>  	{ "__builtin_exit", &void_ctype, 0, { &int_ctype }},
> -	{ "__builtin_expect", &long_ctype, 0, { &long_ctype ,&long_ctype }},
>  	{ "__builtin_extract_return_addr", &ptr_ctype, 0, { &ptr_ctype }},
>  	{ "__builtin_fabs", &double_ctype, 0, { &double_ctype }},
> -	{ "__builtin_ffs", &int_ctype, 0, { &int_ctype }},
> -	{ "__builtin_ffsl", &int_ctype, 0, { &long_ctype }},
> -	{ "__builtin_ffsll", &int_ctype, 0, { &llong_ctype }},
> +	{ "__builtin_ffs", &int_ctype, 0, { &int_ctype }, .op = &ffs_op },
> +	{ "__builtin_ffsl", &int_ctype, 0, { &long_ctype }, .op = &ffs_op },
> +	{ "__builtin_ffsll", &int_ctype, 0, { &llong_ctype }, .op = &ffs_op },
>  	{ "__builtin_frame_address", &ptr_ctype, 0, { &uint_ctype }},
>  	{ "__builtin_free", &void_ctype, 0, { &ptr_ctype }},
>  	{ "__builtin_huge_val", &double_ctype, 0 },
> @@ -439,16 +440,16 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__builtin_inf", &double_ctype, 0 },
>  	{ "__builtin_inff", &float_ctype, 0 },
>  	{ "__builtin_infl", &ldouble_ctype, 0 },
> -	{ "__builtin_isfinite", &int_ctype, 1 },
> +	{ "__builtin_isfinite", &int_ctype, 1, .op = &fp_unop_op },
>  	{ "__builtin_isgreater", &int_ctype, 0, { &float_ctype, &float_ctype }},
>  	{ "__builtin_isgreaterequal", &int_ctype, 0, { &float_ctype, &float_ctype }},
> -	{ "__builtin_isinf", &int_ctype, 1 },
> -	{ "__builtin_isinf_sign", &int_ctype, 1 },
> +	{ "__builtin_isinf", &int_ctype, 1, .op = &fp_unop_op },
> +	{ "__builtin_isinf_sign", &int_ctype, 1, .op = &fp_unop_op },
>  	{ "__builtin_isless", &int_ctype, 0, { &float_ctype, &float_ctype }},
>  	{ "__builtin_islessequal", &int_ctype, 0, { &float_ctype, &float_ctype }},
>  	{ "__builtin_islessgreater", &int_ctype, 0, { &float_ctype, &float_ctype }},
> -	{ "__builtin_isnan", &int_ctype, 1 },
> -	{ "__builtin_isnormal", &int_ctype, 1 },
> +	{ "__builtin_isnan", &int_ctype, 1, .op = &fp_unop_op },
> +	{ "__builtin_isnormal", &int_ctype, 1, .op = &fp_unop_op },
>  	{ "__builtin_isunordered", &int_ctype, 0, { &float_ctype, &float_ctype }},
>  	{ "__builtin_labs", &long_ctype, 0, { &long_ctype }},
>  	{ "__builtin_llabs", &llong_ctype, 0, { &llong_ctype }},
> @@ -459,16 +460,18 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__builtin_memmove", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype }},
>  	{ "__builtin_mempcpy", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype }},
>  	{ "__builtin_memset", &ptr_ctype, 0, { &ptr_ctype, &int_ctype, size_t_ctype }},
> +	{ "__builtin_mul_overflow", &bool_ctype, 1, .op = &overflow_op },
> +	{ "__builtin_mul_overflow_p", &bool_ctype, 1, .op = &overflow_p_op },
>  	{ "__builtin_nan", &double_ctype, 0, { &const_string_ctype }},
>  	{ "__builtin_nanf", &float_ctype, 0, { &const_string_ctype }},
>  	{ "__builtin_nanl", &ldouble_ctype, 0, { &const_string_ctype }},
>  	{ "__builtin_object_size", size_t_ctype, 0, { &const_ptr_ctype, &int_ctype }},
> -	{ "__builtin_parity", &int_ctype, 0, { &uint_ctype }},
> -	{ "__builtin_parityl", &int_ctype, 0, { &ulong_ctype }},
> -	{ "__builtin_parityll", &int_ctype, 0, { &ullong_ctype }},
> -	{ "__builtin_popcount", &int_ctype, 0, { &uint_ctype }},
> -	{ "__builtin_popcountl", &int_ctype, 0, { &ulong_ctype }},
> -	{ "__builtin_popcountll", &int_ctype, 0, { &ullong_ctype }},
> +	{ "__builtin_parity", &int_ctype, 0, { &uint_ctype }, .op = &parity_op },
> +	{ "__builtin_parityl", &int_ctype, 0, { &ulong_ctype }, .op = &parity_op },
> +	{ "__builtin_parityll", &int_ctype, 0, { &ullong_ctype }, .op = &parity_op },
> +	{ "__builtin_popcount", &int_ctype, 0, { &uint_ctype }, .op = &popcount_op },
> +	{ "__builtin_popcountl", &int_ctype, 0, { &ulong_ctype }, .op = &popcount_op },
> +	{ "__builtin_popcountll", &int_ctype, 0, { &ullong_ctype }, .op = &popcount_op },
>  	{ "__builtin_prefetch", &void_ctype, 1, { &const_ptr_ctype }},
>  	{ "__builtin_printf", &int_ctype, 1, { &const_string_ctype }},
>  	{ "__builtin_puts", &int_ctype, 0, { &const_string_ctype }},
> @@ -478,7 +481,7 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__builtin_sadd_overflow", &bool_ctype, 0, { &int_ctype, &int_ctype, &int_ptr_ctype }},
>  	{ "__builtin_saddl_overflow", &bool_ctype, 0, { &long_ctype, &long_ctype, &long_ptr_ctype }},
>  	{ "__builtin_saddll_overflow", &bool_ctype, 0, { &llong_ctype, &llong_ctype, &llong_ptr_ctype }},
> -	{ "__builtin_signbit", &int_ctype, 1 },
> +	{ "__builtin_signbit", &int_ctype, 1 , .op = &fp_unop_op },
>  	{ "__builtin_smul_overflow", &bool_ctype, 0, { &int_ctype, &int_ctype, &int_ptr_ctype }},
>  	{ "__builtin_smull_overflow", &bool_ctype, 0, { &long_ctype, &long_ctype, &long_ptr_ctype }},
>  	{ "__builtin_smulll_overflow", &bool_ctype, 0, { &llong_ctype, &llong_ctype, &llong_ptr_ctype }},
> @@ -508,6 +511,8 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__builtin_strrchr", &string_ctype, 0, { &const_string_ctype, &int_ctype }},
>  	{ "__builtin_strspn", size_t_ctype, 0, { &const_string_ctype, &const_string_ctype }},
>  	{ "__builtin_strstr", &string_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_sub_overflow", &bool_ctype, 1, .op = &overflow_op },
> +	{ "__builtin_sub_overflow_p", &bool_ctype, 1, .op = &overflow_p_op },
>  	{ "__builtin_trap", &void_ctype, 0 },
>  	{ "__builtin_uadd_overflow", &bool_ctype, 0, { &uint_ctype, &uint_ctype, &uint_ptr_ctype }},
>  	{ "__builtin_uaddl_overflow", &bool_ctype, 0, { &ulong_ctype, &ulong_ctype, &ulong_ptr_ctype }},
> @@ -556,6 +561,15 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__sync_val_compare_and_swap", &int_ctype, 1, { &ptr_ctype }},
>  	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
>  
> +	// Alpha-specific
> +	{ "__builtin_alpha_cmpbge", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_extbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_extwl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_insbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_inslh", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_insql", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_inswl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +
>  	// Blackfin-specific stuff
>  	{ "__builtin_bfin_csync", &void_ctype, 0 },
>  	{ "__builtin_bfin_ssync", &void_ctype, 0 },
> @@ -569,68 +583,9 @@ static const struct builtin_fn builtins_common[] = {
>  	{ }
>  };
>  
> -static struct symbol builtin_fn_type = { .type = SYM_FN /* , .variadic =1 */ };
> -static struct sym_init {
> -	const char *name;
> -	struct symbol *base_type;
> -	unsigned int modifiers;
> -	struct symbol_op *op;
> -} builtins_table[] = {
> -	{ "__builtin_constant_p", &builtin_fn_type, MOD_TOPLEVEL, &constant_p_op },
> -	{ "__builtin_safe_p", &builtin_fn_type, MOD_TOPLEVEL, &safe_p_op },
> -	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
> -	{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
> -	{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
> -	{ "__builtin_bswap16", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
> -	{ "__builtin_bswap32", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
> -	{ "__builtin_bswap64", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
> -	{ "__builtin_clrsb", &builtin_fn_type, MOD_TOPLEVEL, &clrsb_op },
> -	{ "__builtin_clrsbl", &builtin_fn_type, MOD_TOPLEVEL, &clrsb_op },
> -	{ "__builtin_clrsbll", &builtin_fn_type, MOD_TOPLEVEL, &clrsb_op },
> -	{ "__builtin_clz", &builtin_fn_type, MOD_TOPLEVEL, &clz_op },
> -	{ "__builtin_clzl", &builtin_fn_type, MOD_TOPLEVEL, &clz_op },
> -	{ "__builtin_clzll", &builtin_fn_type, MOD_TOPLEVEL, &clz_op },
> -	{ "__builtin_ctz", &builtin_fn_type, MOD_TOPLEVEL, &ctz_op },
> -	{ "__builtin_ctzl", &builtin_fn_type, MOD_TOPLEVEL, &ctz_op },
> -	{ "__builtin_ctzll", &builtin_fn_type, MOD_TOPLEVEL, &ctz_op },
> -	{ "__builtin_ffs", &builtin_fn_type, MOD_TOPLEVEL, &ffs_op },
> -	{ "__builtin_ffsl", &builtin_fn_type, MOD_TOPLEVEL, &ffs_op },
> -	{ "__builtin_ffsll", &builtin_fn_type, MOD_TOPLEVEL, &ffs_op },
> -	{ "__builtin_isfinite", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
> -	{ "__builtin_isinf", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
> -	{ "__builtin_isinf_sign", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
> -	{ "__builtin_isnan", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
> -	{ "__builtin_isnormal", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
> -	{ "__builtin_parity", &builtin_fn_type, MOD_TOPLEVEL, &parity_op },
> -	{ "__builtin_parityl", &builtin_fn_type, MOD_TOPLEVEL, &parity_op },
> -	{ "__builtin_parityll", &builtin_fn_type, MOD_TOPLEVEL, &parity_op },
> -	{ "__builtin_popcount", &builtin_fn_type, MOD_TOPLEVEL, &popcount_op },
> -	{ "__builtin_popcountl", &builtin_fn_type, MOD_TOPLEVEL, &popcount_op },
> -	{ "__builtin_popcountll", &builtin_fn_type, MOD_TOPLEVEL, &popcount_op },
> -	{ "__builtin_signbit", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
> -	{ "__builtin_add_overflow", &builtin_fn_type, MOD_TOPLEVEL, &overflow_op },
> -	{ "__builtin_sub_overflow", &builtin_fn_type, MOD_TOPLEVEL, &overflow_op },
> -	{ "__builtin_mul_overflow", &builtin_fn_type, MOD_TOPLEVEL, &overflow_op },
> -	{ "__builtin_add_overflow_p", &builtin_fn_type, MOD_TOPLEVEL, &overflow_p_op },
> -	{ "__builtin_sub_overflow_p", &builtin_fn_type, MOD_TOPLEVEL, &overflow_p_op },
> -	{ "__builtin_mul_overflow_p", &builtin_fn_type, MOD_TOPLEVEL, &overflow_p_op },
> -	{ NULL,		NULL,		0 }
> -};
> -
>  void init_builtins(int stream)
>  {
> -	struct sym_init *ptr;
> -
> -	builtin_fn_type.variadic = 1;
> -	for (ptr = builtins_table; ptr->name; ptr++) {
> -		struct symbol *sym;
> -		sym = create_symbol(stream, ptr->name, SYM_NODE, NS_SYMBOL);
> -		sym->ctype.base_type = ptr->base_type;
> -		sym->ctype.modifiers = ptr->modifiers;
> -		sym->op = ptr->op;
> -		sym->builtin = 1;
> -	}
>  
> -	init_linearized_builtins(stream);
>  	declare_builtins(builtins_common);
> +	init_linearized_builtins(stream);
>  }
> diff --git a/builtin.h b/builtin.h
> index 233cf2806760..d0d3fd2ccf87 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -9,6 +9,7 @@ struct builtin_fn {
>  	unsigned int variadic:1;
>  	struct symbol *args[6];
>  	struct symbol *_args_null_tail;
> +	struct symbol_op *op;
>  };
>  
>  #endif
> 
