From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/7] builtin: use a table for the builtins
Date: Fri, 12 Jun 2020 01:56:20 +0100
Message-ID: <62b18141-89be-d0e0-a848-8cf096d0f160@ramsayjones.plus.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
 <20200610202735.84968-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:32843 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLA4Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 Jun 2020 20:56:25 -0400
In-Reply-To: <20200610202735.84968-3-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 10/06/2020 21:27, Luc Van Oostenryck wrote:
> The curent way to declare the builtins is not by using a table
> but via a (variadic) function call, one for each builtin.
> 
> A table is table is preferable but a complication for doing this

s/table is table is/table is/

> is that some elements are not constant. For example, 'size_t_ctype'
> is dynamically set in the early steps of the type initialization.
> Doing a series of function calls allowed to circumvent this.
> 
> Fix this by:
> * Using a constant temporary alias for non-constant entries. It's the
>   value of these alias that will be used when registering the builtins.
> * using a table to declare the builtin functions.
> 
> Note: the motivation for doing this is to be able to add sub-tables
>       for the arch-specific builtins (and use the same mechanism
>       as for the main table).
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  builtin.c | 411 ++++++++++++++++++++++++++++--------------------------
>  builtin.h |  14 ++
>  lib.c     |   1 -
>  symbol.h  |   1 -
>  4 files changed, 227 insertions(+), 200 deletions(-)
>  create mode 100644 builtin.h
> 
> diff --git a/builtin.c b/builtin.c
> index 5ed17700d422..aa9ce09c0f40 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -23,6 +23,7 @@
>   * THE SOFTWARE.
>   */
>  
> +#include "builtin.h"
>  #include "expression.h"
>  #include "evaluate.h"
>  #include "expand.h"
> @@ -357,6 +358,217 @@ static struct symbol_op overflow_p_op = {
>  /*
>   * Builtin functions
>   */
> +static struct symbol size_t_alias;
> +
> +static struct symbol *get_ctype(struct symbol *sym)
> +{
> +	if (sym == &size_t_alias)
> +		return size_t_ctype;
> +	return sym;
> +}
> +
> +static void declare_one_builtin(const struct builtin_fn *entry)
> +{
> +	struct symbol *sym = create_symbol(0, entry->name, SYM_NODE, NS_SYMBOL);

So, assuming stream 0 here as well ...

> +	struct symbol *fun = alloc_symbol(sym->pos, SYM_FN);
> +	struct symbol *arg;
> +	int i;
> +
> +	sym->ctype.base_type = fun;
> +	sym->ctype.modifiers = MOD_TOPLEVEL;
> +	sym->builtin = 1;
> +
> +	fun->ctype.base_type = get_ctype(entry->ret_type);
> +	fun->variadic = entry->variadic;
> +
> +	for (i = 0; (arg = entry->args[i]); i++) {
> +		struct symbol *anode = alloc_symbol(sym->pos, SYM_NODE);
> +		anode->ctype.base_type = get_ctype(arg);
> +		add_symbol(&fun->arguments, anode);
> +	}
> +}
> +
> +static void declare_builtins(const struct builtin_fn tbl[])
> +{
> +	while (tbl->name)
> +		declare_one_builtin(tbl++);
> +}
> +
> +static const struct builtin_fn builtins_common[] = {
> +#define size_t_ctype	&size_t_alias
> +#define va_list_ctype	&ptr_ctype
> +	{ "__builtin_abort", &void_ctype, 0 },
> +	{ "__builtin_abs", &int_ctype , 0, { &int_ctype }},
> +	{ "__builtin_alloca", &ptr_ctype, 0, { size_t_ctype }},
> +	{ "__builtin_alpha_cmpbge", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_extbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_extwl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_insbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_inslh", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_insql", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_alpha_inswl", &long_ctype, 0, { &long_ctype, &long_ctype }},
> +	{ "__builtin_bcmp", &int_ctype , 0, { &const_ptr_ctype, &const_ptr_ctype, size_t_ctype }},
> +	{ "__builtin_bcopy", &void_ctype, 0, { &const_ptr_ctype, &ptr_ctype, size_t_ctype }},
> +	{ "__builtin_bswap16", &ushort_ctype, 0, { &ushort_ctype }},
> +	{ "__builtin_bswap32", &uint_ctype, 0, { &uint_ctype }},
> +	{ "__builtin_bswap64", &ullong_ctype, 0, { &ullong_ctype }},
> +	{ "__builtin_bzero", &void_ctype, 0, { &ptr_ctype, size_t_ctype }},
> +	{ "__builtin_calloc", &ptr_ctype, 0, { size_t_ctype, size_t_ctype }},
> +	{ "__builtin_clrsb", &int_ctype, 0, { &int_ctype }},
> +	{ "__builtin_clrsbl", &int_ctype, 0, { &long_ctype }},
> +	{ "__builtin_clrsbll", &int_ctype, 0, { &llong_ctype }},
> +	{ "__builtin_clz", &int_ctype, 0, { &int_ctype }},
> +	{ "__builtin_clzl", &int_ctype, 0, { &long_ctype }},
> +	{ "__builtin_clzll", &int_ctype, 0, { &llong_ctype }},
> +	{ "__builtin_ctz", &int_ctype, 0, { &int_ctype }},
> +	{ "__builtin_ctzl", &int_ctype, 0, { &long_ctype }},
> +	{ "__builtin_ctzll", &int_ctype, 0, { &llong_ctype }},
> +	{ "__builtin_exit", &void_ctype, 0, { &int_ctype }},
> +	{ "__builtin_expect", &long_ctype, 0, { &long_ctype ,&long_ctype }},
> +	{ "__builtin_extract_return_addr", &ptr_ctype, 0, { &ptr_ctype }},
> +	{ "__builtin_fabs", &double_ctype, 0, { &double_ctype }},
> +	{ "__builtin_ffs", &int_ctype, 0, { &int_ctype }},
> +	{ "__builtin_ffsl", &int_ctype, 0, { &long_ctype }},
> +	{ "__builtin_ffsll", &int_ctype, 0, { &llong_ctype }},
> +	{ "__builtin_frame_address", &ptr_ctype, 0, { &uint_ctype }},
> +	{ "__builtin_free", &void_ctype, 0, { &ptr_ctype }},
> +	{ "__builtin_huge_val", &double_ctype, 0 },
> +	{ "__builtin_huge_valf", &float_ctype, 0 },
> +	{ "__builtin_huge_vall", &ldouble_ctype, 0 },
> +	{ "__builtin_index", &string_ctype, 0, { &const_string_ctype, &int_ctype }},
> +	{ "__builtin_inf", &double_ctype, 0 },
> +	{ "__builtin_inff", &float_ctype, 0 },
> +	{ "__builtin_infl", &ldouble_ctype, 0 },
> +	{ "__builtin_isfinite", &int_ctype, 1 },
> +	{ "__builtin_isgreater", &int_ctype, 0, { &float_ctype, &float_ctype }},
> +	{ "__builtin_isgreaterequal", &int_ctype, 0, { &float_ctype, &float_ctype }},
> +	{ "__builtin_isinf", &int_ctype, 1 },
> +	{ "__builtin_isinf_sign", &int_ctype, 1 },
> +	{ "__builtin_isless", &int_ctype, 0, { &float_ctype, &float_ctype }},
> +	{ "__builtin_islessequal", &int_ctype, 0, { &float_ctype, &float_ctype }},
> +	{ "__builtin_islessgreater", &int_ctype, 0, { &float_ctype, &float_ctype }},
> +	{ "__builtin_isnan", &int_ctype, 1 },
> +	{ "__builtin_isnormal", &int_ctype, 1 },
> +	{ "__builtin_isunordered", &int_ctype, 0, { &float_ctype, &float_ctype }},
> +	{ "__builtin_labs", &long_ctype, 0, { &long_ctype }},
> +	{ "__builtin_llabs", &llong_ctype, 0, { &llong_ctype }},
> +	{ "__builtin_malloc", &ptr_ctype, 0, { size_t_ctype }},
> +	{ "__builtin_memchr", &ptr_ctype, 0, { &const_ptr_ctype, &int_ctype, size_t_ctype }},
> +	{ "__builtin_memcmp", &int_ctype, 0, { &const_ptr_ctype, &const_ptr_ctype, size_t_ctype }},
> +	{ "__builtin_memcpy", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype }},
> +	{ "__builtin_memmove", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype }},
> +	{ "__builtin_mempcpy", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype }},
> +	{ "__builtin_memset", &ptr_ctype, 0, { &ptr_ctype, &int_ctype, size_t_ctype }},
> +	{ "__builtin_nan", &double_ctype, 0, { &const_string_ctype }},
> +	{ "__builtin_nanf", &float_ctype, 0, { &const_string_ctype }},
> +	{ "__builtin_nanl", &ldouble_ctype, 0, { &const_string_ctype }},
> +	{ "__builtin_object_size", size_t_ctype, 0, { &const_ptr_ctype, &int_ctype }},
> +	{ "__builtin_parity", &int_ctype, 0, { &uint_ctype }},
> +	{ "__builtin_parityl", &int_ctype, 0, { &ulong_ctype }},
> +	{ "__builtin_parityll", &int_ctype, 0, { &ullong_ctype }},
> +	{ "__builtin_popcount", &int_ctype, 0, { &uint_ctype }},
> +	{ "__builtin_popcountl", &int_ctype, 0, { &ulong_ctype }},
> +	{ "__builtin_popcountll", &int_ctype, 0, { &ullong_ctype }},
> +	{ "__builtin_prefetch", &void_ctype, 1, { &const_ptr_ctype }},
> +	{ "__builtin_printf", &int_ctype, 1, { &const_string_ctype }},
> +	{ "__builtin_puts", &int_ctype, 0, { &const_string_ctype }},
> +	{ "__builtin_realloc", &ptr_ctype, 0, { &ptr_ctype, size_t_ctype }},
> +	{ "__builtin_return_address", &ptr_ctype, 0, { &uint_ctype }},
> +	{ "__builtin_rindex", &string_ctype, 0, { &const_string_ctype, &int_ctype }},
> +	{ "__builtin_sadd_overflow", &bool_ctype, 0, { &int_ctype, &int_ctype, &int_ptr_ctype }},
> +	{ "__builtin_saddl_overflow", &bool_ctype, 0, { &long_ctype, &long_ctype, &long_ptr_ctype }},
> +	{ "__builtin_saddll_overflow", &bool_ctype, 0, { &llong_ctype, &llong_ctype, &llong_ptr_ctype }},
> +	{ "__builtin_signbit", &int_ctype, 1 },
> +	{ "__builtin_smul_overflow", &bool_ctype, 0, { &int_ctype, &int_ctype, &int_ptr_ctype }},
> +	{ "__builtin_smull_overflow", &bool_ctype, 0, { &long_ctype, &long_ctype, &long_ptr_ctype }},
> +	{ "__builtin_smulll_overflow", &bool_ctype, 0, { &llong_ctype, &llong_ctype, &llong_ptr_ctype }},
> +	{ "__builtin_snprintf", &int_ctype, 1, { &string_ctype, size_t_ctype, &const_string_ctype }},
> +	{ "__builtin_sprintf", &int_ctype, 1, { &string_ctype, &const_string_ctype }},
> +	{ "__builtin_ssub_overflow", &bool_ctype, 0, { &int_ctype, &int_ctype, &int_ptr_ctype }},
> +	{ "__builtin_ssubl_overflow", &bool_ctype, 0, { &long_ctype, &long_ctype, &long_ptr_ctype }},
> +	{ "__builtin_ssubll_overflow", &bool_ctype, 0, { &llong_ctype, &llong_ctype, &llong_ptr_ctype }},
> +	{ "__builtin_stpcpy", &string_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_stpncpy", &string_ctype, 0, { &const_string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin_strcasecmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_strcasestr", &string_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_strcat", &string_ctype, 0, { &string_ctype, &const_string_ctype }},
> +	{ "__builtin_strchr", &string_ctype, 0, { &const_string_ctype, &int_ctype }},
> +	{ "__builtin_strcmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_strcpy", &string_ctype, 0, { &string_ctype, &const_string_ctype }},
> +	{ "__builtin_strcspn", size_t_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_strdup", &string_ctype, 0, { &const_string_ctype }},
> +	{ "__builtin_strlen", size_t_ctype, 0, { &const_string_ctype }},
> +	{ "__builtin_strncasecmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin_strncat", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin_strncmp", &int_ctype, 0, { &const_string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin_strncpy", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin_strndup", &string_ctype, 0, { &const_string_ctype, size_t_ctype }},
> +	{ "__builtin_strnstr", &string_ctype, 0, { &const_string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin_strpbrk", &string_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_strrchr", &string_ctype, 0, { &const_string_ctype, &int_ctype }},
> +	{ "__builtin_strspn", size_t_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_strstr", &string_ctype, 0, { &const_string_ctype, &const_string_ctype }},
> +	{ "__builtin_trap", &void_ctype, 0 },
> +	{ "__builtin_uadd_overflow", &bool_ctype, 0, { &uint_ctype, &uint_ctype, &uint_ptr_ctype }},
> +	{ "__builtin_uaddl_overflow", &bool_ctype, 0, { &ulong_ctype, &ulong_ctype, &ulong_ptr_ctype }},
> +	{ "__builtin_uaddll_overflow", &bool_ctype, 0, { &ullong_ctype, &ullong_ctype, &ullong_ptr_ctype }},
> +	{ "__builtin_umul_overflow", &bool_ctype, 0, { &uint_ctype, &uint_ctype, &uint_ptr_ctype }},
> +	{ "__builtin_umull_overflow", &bool_ctype, 0, { &ulong_ctype, &ulong_ctype, &ulong_ptr_ctype }},
> +	{ "__builtin_umulll_overflow", &bool_ctype, 0, { &ullong_ctype, &ullong_ctype, &ullong_ptr_ctype }},
> +	{ "__builtin_unreachable", &void_ctype, 0 },
> +	{ "__builtin_usub_overflow", &bool_ctype, 0, { &uint_ctype, &uint_ctype, &uint_ptr_ctype }},
> +	{ "__builtin_usubl_overflow", &bool_ctype, 0, { &ulong_ctype, &ulong_ctype, &ulong_ptr_ctype }},
> +	{ "__builtin_usubll_overflow", &bool_ctype, 0, { &ullong_ctype, &ullong_ctype, &ullong_ptr_ctype }},
> +	{ "__builtin_va_arg_pack_len", size_t_ctype, 0 },
> +	{ "__builtin_vprintf", &int_ctype, 0, { &const_string_ctype, va_list_ctype }},
> +	{ "__builtin_vsnprintf", &int_ctype, 0, { &string_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
> +	{ "__builtin_vsprintf", &int_ctype, 0, { &string_ctype, &const_string_ctype, va_list_ctype }},
> +
> +	{ "__builtin___memcpy_chk", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype }},
> +	{ "__builtin___memmove_chk", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype }},
> +	{ "__builtin___mempcpy_chk", &ptr_ctype, 0, { &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype }},
> +	{ "__builtin___memset_chk", &ptr_ctype, 0, { &ptr_ctype, &int_ctype, size_t_ctype, size_t_ctype }},
> +	{ "__builtin___snprintf_chk", &int_ctype, 1, { &string_ctype, size_t_ctype, &int_ctype , size_t_ctype, &const_string_ctype }},
> +	{ "__builtin___sprintf_chk", &int_ctype, 1, { &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype }},
> +	{ "__builtin___stpcpy_chk", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin___strcat_chk", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin___strcpy_chk", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype }},
> +	{ "__builtin___strncat_chk", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype, size_t_ctype }},
> +	{ "__builtin___strncpy_chk", &string_ctype, 0, { &string_ctype, &const_string_ctype, size_t_ctype, size_t_ctype }},
> +	{ "__builtin___vsnprintf_chk", &int_ctype, 0, { &string_ctype, size_t_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
> +	{ "__builtin___vsprintf_chk", &int_ctype, 0, { &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
> +
> +	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_bool_compare_and_swap", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_fetch_and_add", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_fetch_and_and", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_fetch_and_nand", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_fetch_and_or", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_fetch_and_sub", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_fetch_and_xor", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_lock_release", &void_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_lock_test_and_set", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_nand_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_or_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_sub_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_synchronize", &void_ctype, 0 },
> +	{ "__sync_val_compare_and_swap", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +
> +	// Blackfin-specific stuff
> +	{ "__builtin_bfin_csync", &void_ctype, 0 },
> +	{ "__builtin_bfin_ssync", &void_ctype, 0 },
> +	{ "__builtin_bfin_norm_fr1x32", &int_ctype, 0, { &int_ctype }},
> +
> +	// Nios-II-specific
> +	{ "__builtin_rdctl", &int_ctype, 0, { &int_ctype }},
> +	{ "__builtin_wrctl", &void_ctype, 0, { &int_ctype, &int_ctype }},
> +	{ "__builtin_custom_ini", &int_ctype, 0, { &int_ctype }},
> +
> +	{ }
> +};
> +
>  static struct symbol builtin_fn_type = { .type = SYM_FN /* , .variadic =1 */ };
>  static struct sym_init {
>  	const char *name;
> @@ -420,202 +632,5 @@ void init_builtins(int stream)
>  	}
>  
>  	init_linearized_builtins(stream);
> -}
> -
> -static void declare_builtin(const char *name, struct symbol *rtype, int variadic, ...)
> -{
> -	int stream = 0;			// FIXME

... and, yes, here is the FIXME (so my memory is not as bad
as I thought!).

This all looks good.

ATB,
Ramsay Jones

> -	struct symbol *sym = create_symbol(stream, name, SYM_NODE, NS_SYMBOL);
> -	struct symbol *fun = alloc_symbol(sym->pos, SYM_FN);
> -	struct symbol *arg;
> -	va_list args;
> -
> -	sym->ctype.base_type = fun;
> -	sym->ctype.modifiers = MOD_TOPLEVEL;
> -	sym->builtin = 1;
> -
> -	fun->ctype.base_type = rtype;
> -	fun->variadic = variadic;
> -
> -	va_start(args, variadic);
> -	while ((arg = va_arg(args, struct symbol *))) {
> -		struct symbol *anode = alloc_symbol(sym->pos, SYM_NODE);
> -		anode->ctype.base_type = arg;
> -		add_symbol(&fun->arguments, anode);
> -	}
> -	va_end(args);
> -}
> -
> -void declare_builtins(void)
> -{
> -	struct symbol *va_list_ctype = &ptr_ctype;
> -
> -	declare_builtin("__builtin_abort", &void_ctype, 0, NULL);
> -	declare_builtin("__builtin_abs", &int_ctype , 0, &int_ctype, NULL);
> -	declare_builtin("__builtin_alloca", &ptr_ctype, 0, size_t_ctype, NULL);
> -	declare_builtin("__builtin_alpha_cmpbge", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> -	declare_builtin("__builtin_alpha_extbl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> -	declare_builtin("__builtin_alpha_extwl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> -	declare_builtin("__builtin_alpha_insbl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> -	declare_builtin("__builtin_alpha_inslh", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> -	declare_builtin("__builtin_alpha_insql", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> -	declare_builtin("__builtin_alpha_inswl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> -	declare_builtin("__builtin_bcmp", &int_ctype , 0, &const_ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_bcopy", &void_ctype, 0, &const_ptr_ctype, &ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_bswap16", &ushort_ctype, 0, &ushort_ctype, NULL);
> -	declare_builtin("__builtin_bswap32", &uint_ctype, 0, &uint_ctype, NULL);
> -	declare_builtin("__builtin_bswap64", &ullong_ctype, 0, &ullong_ctype, NULL);
> -	declare_builtin("__builtin_bzero", &void_ctype, 0, &ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_calloc", &ptr_ctype, 0, size_t_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_clrsb", &int_ctype, 0, &int_ctype, NULL);
> -	declare_builtin("__builtin_clrsbl", &int_ctype, 0, &long_ctype, NULL);
> -	declare_builtin("__builtin_clrsbll", &int_ctype, 0, &llong_ctype, NULL);
> -	declare_builtin("__builtin_clz", &int_ctype, 0, &int_ctype, NULL);
> -	declare_builtin("__builtin_clzl", &int_ctype, 0, &long_ctype, NULL);
> -	declare_builtin("__builtin_clzll", &int_ctype, 0, &llong_ctype, NULL);
> -	declare_builtin("__builtin_ctz", &int_ctype, 0, &int_ctype, NULL);
> -	declare_builtin("__builtin_ctzl", &int_ctype, 0, &long_ctype, NULL);
> -	declare_builtin("__builtin_ctzll", &int_ctype, 0, &llong_ctype, NULL);
> -	declare_builtin("__builtin_exit", &void_ctype, 0, &int_ctype, NULL);
> -	declare_builtin("__builtin_expect", &long_ctype, 0, &long_ctype ,&long_ctype, NULL);
> -	declare_builtin("__builtin_extract_return_addr", &ptr_ctype, 0, &ptr_ctype, NULL);
> -	declare_builtin("__builtin_fabs", &double_ctype, 0, &double_ctype, NULL);
> -	declare_builtin("__builtin_ffs", &int_ctype, 0, &int_ctype, NULL);
> -	declare_builtin("__builtin_ffsl", &int_ctype, 0, &long_ctype, NULL);
> -	declare_builtin("__builtin_ffsll", &int_ctype, 0, &llong_ctype, NULL);
> -	declare_builtin("__builtin_frame_address", &ptr_ctype, 0, &uint_ctype, NULL);
> -	declare_builtin("__builtin_free", &void_ctype, 0, &ptr_ctype, NULL);
> -	declare_builtin("__builtin_huge_val", &double_ctype, 0, NULL);
> -	declare_builtin("__builtin_huge_valf", &float_ctype, 0, NULL);
> -	declare_builtin("__builtin_huge_vall", &ldouble_ctype, 0, NULL);
> -	declare_builtin("__builtin_index", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
> -	declare_builtin("__builtin_inf", &double_ctype, 0, NULL);
> -	declare_builtin("__builtin_inff", &float_ctype, 0, NULL);
> -	declare_builtin("__builtin_infl", &ldouble_ctype, 0, NULL);
> -	declare_builtin("__builtin_isfinite", &int_ctype, 1, NULL);
> -	declare_builtin("__builtin_isgreater", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
> -	declare_builtin("__builtin_isgreaterequal", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
> -	declare_builtin("__builtin_isinf", &int_ctype, 1, NULL);
> -	declare_builtin("__builtin_isinf_sign", &int_ctype, 1, NULL);
> -	declare_builtin("__builtin_isless", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
> -	declare_builtin("__builtin_islessequal", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
> -	declare_builtin("__builtin_islessgreater", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
> -	declare_builtin("__builtin_isnan", &int_ctype, 1, NULL);
> -	declare_builtin("__builtin_isnormal", &int_ctype, 1, NULL);
> -	declare_builtin("__builtin_isunordered", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
> -	declare_builtin("__builtin_labs", &long_ctype, 0, &long_ctype, NULL);
> -	declare_builtin("__builtin_llabs", &llong_ctype, 0, &llong_ctype, NULL);
> -	declare_builtin("__builtin_malloc", &ptr_ctype, 0, size_t_ctype, NULL);
> -	declare_builtin("__builtin_memchr", &ptr_ctype, 0, &const_ptr_ctype, &int_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_memcmp", &int_ctype, 0, &const_ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_memcpy", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_memmove", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_mempcpy", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_memset", &ptr_ctype, 0, &ptr_ctype, &int_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_nan", &double_ctype, 0, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_nanf", &float_ctype, 0, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_nanl", &ldouble_ctype, 0, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_object_size", size_t_ctype, 0, &const_ptr_ctype, &int_ctype, NULL);
> -	declare_builtin("__builtin_parity", &int_ctype, 0, &uint_ctype, NULL);
> -	declare_builtin("__builtin_parityl", &int_ctype, 0, &ulong_ctype, NULL);
> -	declare_builtin("__builtin_parityll", &int_ctype, 0, &ullong_ctype, NULL);
> -	declare_builtin("__builtin_popcount", &int_ctype, 0, &uint_ctype, NULL);
> -	declare_builtin("__builtin_popcountl", &int_ctype, 0, &ulong_ctype, NULL);
> -	declare_builtin("__builtin_popcountll", &int_ctype, 0, &ullong_ctype, NULL);
> -	declare_builtin("__builtin_prefetch", &void_ctype, 1, &const_ptr_ctype, NULL);
> -	declare_builtin("__builtin_printf", &int_ctype, 1, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_puts", &int_ctype, 0, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_realloc", &ptr_ctype, 0, &ptr_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_return_address", &ptr_ctype, 0, &uint_ctype, NULL);
> -	declare_builtin("__builtin_rindex", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
> -	declare_builtin("__builtin_sadd_overflow", &bool_ctype, 0, &int_ctype, &int_ctype, &int_ptr_ctype, NULL);
> -	declare_builtin("__builtin_saddl_overflow", &bool_ctype, 0, &long_ctype, &long_ctype, &long_ptr_ctype, NULL);
> -	declare_builtin("__builtin_saddll_overflow", &bool_ctype, 0, &llong_ctype, &llong_ctype, &llong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_signbit", &int_ctype, 1, NULL);
> -	declare_builtin("__builtin_smul_overflow", &bool_ctype, 0, &int_ctype, &int_ctype, &int_ptr_ctype, NULL);
> -	declare_builtin("__builtin_smull_overflow", &bool_ctype, 0, &long_ctype, &long_ctype, &long_ptr_ctype, NULL);
> -	declare_builtin("__builtin_smulll_overflow", &bool_ctype, 0, &llong_ctype, &llong_ctype, &llong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_snprintf", &int_ctype, 1, &string_ctype, size_t_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_sprintf", &int_ctype, 1, &string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_ssub_overflow", &bool_ctype, 0, &int_ctype, &int_ctype, &int_ptr_ctype, NULL);
> -	declare_builtin("__builtin_ssubl_overflow", &bool_ctype, 0, &long_ctype, &long_ctype, &long_ptr_ctype, NULL);
> -	declare_builtin("__builtin_ssubll_overflow", &bool_ctype, 0, &llong_ctype, &llong_ctype, &llong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_stpcpy", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_stpncpy", &string_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_strcasecmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strcasestr", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strcat", &string_ctype, 0, &string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strchr", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
> -	declare_builtin("__builtin_strcmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strcpy", &string_ctype, 0, &string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strcspn", size_t_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strdup", &string_ctype, 0, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strlen", size_t_ctype, 0, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strncasecmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_strncat", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_strncmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_strncpy", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_strndup", &string_ctype, 0, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_strnstr", &string_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin_strpbrk", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strrchr", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
> -	declare_builtin("__builtin_strspn", size_t_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_strstr", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin_trap", &void_ctype, 0, NULL);
> -	declare_builtin("__builtin_uadd_overflow", &bool_ctype, 0, &uint_ctype, &uint_ctype, &uint_ptr_ctype, NULL);
> -	declare_builtin("__builtin_uaddl_overflow", &bool_ctype, 0, &ulong_ctype, &ulong_ctype, &ulong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_uaddll_overflow", &bool_ctype, 0, &ullong_ctype, &ullong_ctype, &ullong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_umul_overflow", &bool_ctype, 0, &uint_ctype, &uint_ctype, &uint_ptr_ctype, NULL);
> -	declare_builtin("__builtin_umull_overflow", &bool_ctype, 0, &ulong_ctype, &ulong_ctype, &ulong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_umulll_overflow", &bool_ctype, 0, &ullong_ctype, &ullong_ctype, &ullong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_unreachable", &void_ctype, 0, NULL);
> -	declare_builtin("__builtin_usub_overflow", &bool_ctype, 0, &uint_ctype, &uint_ctype, &uint_ptr_ctype, NULL);
> -	declare_builtin("__builtin_usubl_overflow", &bool_ctype, 0, &ulong_ctype, &ulong_ctype, &ulong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_usubll_overflow", &bool_ctype, 0, &ullong_ctype, &ullong_ctype, &ullong_ptr_ctype, NULL);
> -	declare_builtin("__builtin_va_arg_pack_len", size_t_ctype, 0, NULL);
> -	declare_builtin("__builtin_vprintf", &int_ctype, 0, &const_string_ctype, va_list_ctype, NULL);
> -	declare_builtin("__builtin_vsnprintf", &int_ctype, 0, &string_ctype, size_t_ctype, &const_string_ctype, va_list_ctype, NULL);
> -	declare_builtin("__builtin_vsprintf", &int_ctype, 0, &string_ctype, &const_string_ctype, va_list_ctype, NULL);
> -
> -	declare_builtin("__builtin___memcpy_chk", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___memmove_chk", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___mempcpy_chk", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___memset_chk", &ptr_ctype, 0, &ptr_ctype, &int_ctype, size_t_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___snprintf_chk", &int_ctype, 1, &string_ctype, size_t_ctype, &int_ctype , size_t_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin___sprintf_chk", &int_ctype, 1, &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, NULL);
> -	declare_builtin("__builtin___stpcpy_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___strcat_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___strcpy_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___strncat_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___strncpy_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, size_t_ctype, NULL);
> -	declare_builtin("__builtin___vsnprintf_chk", &int_ctype, 0, &string_ctype, size_t_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype, NULL);
> -	declare_builtin("__builtin___vsprintf_chk", &int_ctype, 0, &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype, NULL);
> -
> -	declare_builtin("__sync_add_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_and_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_bool_compare_and_swap", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_fetch_and_add", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_fetch_and_and", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_fetch_and_nand", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_fetch_and_or", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_fetch_and_sub", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_fetch_and_xor", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_lock_release", &void_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_lock_test_and_set", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_nand_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_or_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_sub_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_synchronize", &void_ctype, 0, NULL);
> -	declare_builtin("__sync_val_compare_and_swap", &int_ctype, 1, &ptr_ctype, NULL);
> -	declare_builtin("__sync_xor_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
> -
> -	// Blackfin-specific stuff
> -	declare_builtin("__builtin_bfin_csync", &void_ctype, 0, NULL);
> -	declare_builtin("__builtin_bfin_ssync", &void_ctype, 0, NULL);
> -	declare_builtin("__builtin_bfin_norm_fr1x32", &int_ctype, 0, &int_ctype, NULL);
> -
> -	// Nios-II-specific
> -	declare_builtin("__builtin_rdctl", &int_ctype, 0, &int_ctype, NULL);
> -	declare_builtin("__builtin_wrctl", &void_ctype, 0, &int_ctype, &int_ctype, NULL);
> -	declare_builtin("__builtin_custom_ini", &int_ctype, 0, &int_ctype, NULL);
> +	declare_builtins(builtins_common);
>  }
> diff --git a/builtin.h b/builtin.h
> new file mode 100644
> index 000000000000..233cf2806760
> --- /dev/null
> +++ b/builtin.h
> @@ -0,0 +1,14 @@
> +#ifndef _BUILTIN_H_
> +#define _BUILTIN_H_
> +
> +#include "symbol.h"
> +
> +struct builtin_fn {
> +	const char *name;
> +	struct symbol *ret_type;
> +	unsigned int variadic:1;
> +	struct symbol *args[6];
> +	struct symbol *_args_null_tail;
> +};
> +
> +#endif
> diff --git a/lib.c b/lib.c
> index aa1c1d656b9d..951d400ea2fa 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -1596,7 +1596,6 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
>  		predefined_macros();
>  		create_builtin_stream();
>  		init_builtins(0);
> -		declare_builtins();
>  
>  		list = sparse_initial();
>  
> diff --git a/symbol.h b/symbol.h
> index a16a27c24afe..13e1d90ac76d 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -325,7 +325,6 @@ extern struct symbol *create_symbol(int stream, const char *name, int type, int
>  extern void init_symbols(void);
>  extern void init_builtins(int stream);
>  extern void init_linearized_builtins(int stream);
> -extern void declare_builtins(void);
>  extern void init_ctype(void);
>  extern struct symbol *alloc_symbol(struct position, int type);
>  extern void show_type(struct symbol *);
> 
