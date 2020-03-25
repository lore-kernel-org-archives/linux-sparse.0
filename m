From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] add support for GCC's __auto_type
Date: Wed, 25 Mar 2020 00:37:22 +0000
Message-ID: <42f2b610-4a89-c4c5-2291-228610b01868@ramsayjones.plus.com>
References: <20200324095711.84902-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:58272 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgCYAh2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 24 Mar 2020 20:37:28 -0400
In-Reply-To: <20200324095711.84902-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 24/03/2020 09:57, Luc Van Oostenryck wrote:
> Despite the similarity with typeof, the approach taken here
> is relatively different. A specific symbol type (SYM_TYPEOF)
> is not used, instead a new flag is added to decl_state, another
> one in the declared symbol and a new internal type is used:
> 'autotype_ctype'. It's this new internal type that will be
> resolved to the definitive type at evalution time.
> 
> It seems to be working pretty well, maybe because it
> hasn't been tested well enough.

I haven't tested this (yet) either, but it looks good from what I see
in my email client! ;-) (I deleted my Linux repo many years ago, because
I was always over 90+% used on my disk - and I was only using it as a
'large' repo to test git!).

BTW, I recently upgraded an 32-bit Linux Mint 18.3 to 19.2 using a
'nuke and pave' procedure, rather than the 'upgrade path' provided
by Linux Mint. As part of that, I backed up my $HOME directory from
18.3 and 'restored' it to the new 19.2 (so far, so good). When I built
sparse (before installing llvm), the test-suite failed all of the
'backend/' tests. Given that these tests should have been SKIPed, since
sparse-llvm was disabled, I was a little surprised.

I am sure that you will have guessed by now, that I had an sparse-llvm
executable from 18.3 laying around, ... :-D

I thought about sending a patch to the Makefile to always include the
sparse-llvm program in the clean target (it wouldn't hurt being in the
'rm' invocation twice), but decided that this is unlikely to happen very
often, so ...

BTW, I noticed that we don't install 'sparse-llvm-dis' or 'sparsei' as
part of the 'llvm programs' - should we?

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  parse.c                  | 38 +++++++++++++++++++++++++++
>  symbol.c                 | 19 ++++++++++++++
>  symbol.h                 |  2 ++
>  validation/autotype-ko.c | 45 ++++++++++++++++++++++++++++++++
>  validation/autotype.c    | 55 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 159 insertions(+)
>  create mode 100644 validation/autotype-ko.c
>  create mode 100644 validation/autotype.c
> 
> diff --git a/parse.c b/parse.c
> index 0e6f66a86037..a29c67c8cf41 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -60,6 +60,7 @@ static declarator_t
>  	thread_specifier, const_qualifier, volatile_qualifier;
>  static declarator_t restrict_qualifier;
>  static declarator_t atomic_qualifier;
> +static declarator_t autotype_specifier;
>  
>  static struct token *parse_if_statement(struct token *token, struct statement *stmt);
>  static struct token *parse_return_statement(struct token *token, struct statement *stmt);
> @@ -213,6 +214,13 @@ static struct symbol_op typeof_op = {
>  	.set = Set_S|Set_T,
>  };
>  
> +static struct symbol_op autotype_op = {
> +	.type = KW_SPECIFIER,
> +	.declarator = autotype_specifier,
> +	.test = Set_Any,
> +	.set = Set_S|Set_T,
> +};
> +
>  static struct symbol_op attribute_op = {
>  	.type = KW_ATTRIBUTE,
>  	.declarator = attribute_specifier,
> @@ -505,6 +513,7 @@ static struct init_keyword {
>  	{ "typeof", 	NS_TYPEDEF, .op = &typeof_op },
>  	{ "__typeof", 	NS_TYPEDEF, .op = &typeof_op },
>  	{ "__typeof__",	NS_TYPEDEF, .op = &typeof_op },
> +	{ "__auto_type",NS_TYPEDEF, .op = &autotype_op },
>  
>  	{ "__attribute",   NS_TYPEDEF, .op = &attribute_op },
>  	{ "__attribute__", NS_TYPEDEF, .op = &attribute_op },
> @@ -1078,6 +1087,13 @@ static struct token *typeof_specifier(struct token *token, struct decl_state *ct
>  	return expect(token, ')', "after typeof");
>  }
>  
> +static struct token *autotype_specifier(struct token *token, struct decl_state *ctx)
> +{
> +	ctx->ctype.base_type = &autotype_ctype;
> +	ctx->autotype = 1;
> +	return token;
> +}
> +
>  static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct decl_state *ctx)
>  {
>  	struct expression *expr = NULL;
> @@ -2985,6 +3001,11 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  			}
>  		}
>  	} else if (base_type && base_type->type == SYM_FN) {
> +		if (base_type->ctype.base_type == &autotype_ctype) {
> +			sparse_error(decl->pos, "'%s()' has __auto_type return type",
> +				show_ident(decl->ident));
> +			base_type->ctype.base_type = &int_ctype;
> +		}
>  		if (base_type->ctype.base_type == &incomplete_ctype) {
>  			warning(decl->pos, "'%s()' has implicit return type",
>  				show_ident(decl->ident));
> @@ -3037,6 +3058,23 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  			}
>  		}
>  
> +		if (ctx.autotype) {
> +			const char *msg = NULL;
> +			if (decl->ctype.base_type != &autotype_ctype)
> +				msg = "on non-identifier";
> +			else if (match_op(token, ','))
> +				msg = "on declaration list";
> +			else if (!decl->initializer)
> +				msg = "without initializer";
> +			else if (decl->initializer->type == EXPR_SYMBOL &&
> +				 decl->initializer->symbol == decl)
> +				msg = "on self-init var";
> +			if (msg) {
> +				sparse_error(decl->pos, "__auto_type %s", msg);
> +				decl->ctype.base_type = &bad_ctype;
> +			}
> +		}
> +
>  		if (!match_op(token, ','))
>  			break;
>  
> diff --git a/symbol.c b/symbol.c
> index ab6e9841696f..c2e6f0b426b3 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -192,6 +192,10 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
>  
>  	fn = advance ? lay_out_struct : lay_out_union;
>  	FOR_EACH_PTR(sym->symbol_list, member) {
> +		if (member->ctype.base_type == &autotype_ctype) {
> +			sparse_error(member->pos, "member '%s' has __auto_type", show_ident(member->ident));
> +			member->ctype.base_type = &incomplete_ctype;
> +		}
>  		fn(member, &info);
>  	} END_FOR_EACH_PTR(member);
>  
> @@ -210,6 +214,19 @@ static struct symbol *examine_base_type(struct symbol *sym)
>  {
>  	struct symbol *base_type;
>  
> +	if (sym->ctype.base_type == &autotype_ctype) {
> +		struct symbol *type = evaluate_expression(sym->initializer);
> +		if (!type)
> +			type = &bad_ctype;
> +		if (is_bitfield_type(type)) {
> +			warning(sym->pos, "__auto_type on bitfield");
> +			if (type->type == SYM_NODE)
> +				type = type->ctype.base_type;
> +			type = type->ctype.base_type;
> +		}
> +		sym->ctype.base_type = type;
> +	}
> +
>  	/* Check the base type */
>  	base_type = examine_symbol_type(sym->ctype.base_type);
>  	if (!base_type || base_type->type == SYM_PTR)
> @@ -734,6 +751,7 @@ struct symbol	bool_ctype, void_ctype, type_ctype,
>  		string_ctype, ptr_ctype, lazy_ptr_ctype,
>  		incomplete_ctype, label_ctype, bad_ctype,
>  		null_ctype;
> +struct symbol	autotype_ctype;
>  struct symbol	int_ptr_ctype, uint_ptr_ctype;
>  struct symbol	long_ptr_ctype, ulong_ptr_ctype;
>  struct symbol	llong_ptr_ctype, ullong_ptr_ctype;
> @@ -792,6 +810,7 @@ static const struct ctype_declare {
>  	{ &void_ctype,         T_BASETYPE },
>  	{ &type_ctype,         T_BASETYPE },
>  	{ &incomplete_ctype,   T_BASETYPE },
> +	{ &autotype_ctype,     T_BASETYPE },
>  	{ &bad_ctype,          T_BASETYPE },
>  
>  	{ &char_ctype,         T__INT(-2, char) },
> diff --git a/symbol.h b/symbol.h
> index 270ae098cacf..c86dfb335e29 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -110,6 +110,7 @@ struct decl_state {
>  	unsigned long f_modifiers;		// function attributes
>  	unsigned char prefer_abstract, is_inline, storage_class, is_tls;
>  	unsigned char is_ext_visible;
> +	unsigned char autotype;
>  };
>  
>  struct pseudo;
> @@ -281,6 +282,7 @@ extern struct symbol	bool_ctype, void_ctype, type_ctype,
>  			string_ctype, ptr_ctype, lazy_ptr_ctype,
>  			incomplete_ctype, label_ctype, bad_ctype,
>  			null_ctype;
> +extern struct symbol	autotype_ctype;
>  extern struct symbol	int_ptr_ctype, uint_ptr_ctype;
>  extern struct symbol	long_ptr_ctype, ulong_ptr_ctype;
>  extern struct symbol	llong_ptr_ctype, ullong_ptr_ctype;
> diff --git a/validation/autotype-ko.c b/validation/autotype-ko.c
> new file mode 100644
> index 000000000000..5b6cd708ade7
> --- /dev/null
> +++ b/validation/autotype-ko.c
> @@ -0,0 +1,45 @@
> +__auto_type u;				// KO: no initializer
> +__auto_type r[2] = { 0, 1 };		// KO: not a plain identifier
> +__auto_type foo(void) { }		// KO: not a plain identifier
> +__auto_type v = 0, w = 1;		// KO: in list
> +struct { __auto_type x; } s;		// KO: not valid for struct/union
> +__auto_type self = self;		// KO: self-declared
> +__auto_type undc = this;		// KO: undeclared
> +
> +int i = 1;
> +double f = 1.0;
> +__auto_type i = 2;			// KO: redecl, same type
> +__auto_type f = 2.0f;			// KO: redecl, diff type
> +
> +
> +static int foo(int a, const int *ptr)
> +{
> +	__auto_type i = a;
> +	__auto_type c = *ptr;
> +
> +	c += 1;
> +	return i;
> +}
> +
> +/*
> + * check-name: autotype-ko
> + * check-command: sparse -Wno-decl $file
> + *
> + * check-error-start
> +autotype-ko.c:1:13: error: __auto_type without initializer
> +autotype-ko.c:2:13: error: __auto_type on non-identifier
> +autotype-ko.c:3:13: error: 'foo()' has __auto_type return type
> +autotype-ko.c:4:13: error: __auto_type on declaration list
> +autotype-ko.c:6:13: error: __auto_type on self-init var
> +autotype-ko.c:2:20: error: invalid initializer
> +autotype-ko.c:5:22: error: member 'x' has __auto_type
> +autotype-ko.c:7:20: error: undefined identifier 'this'
> +autotype-ko.c:11:13: error: symbol 'i' has multiple initializers (originally initialized at autotype-ko.c:9)
> +autotype-ko.c:12:13: error: symbol 'f' has multiple initializers (originally initialized at autotype-ko.c:10)
> +autotype-ko.c:12:13: error: symbol 'f' redeclared with different type (different type sizes):
> +autotype-ko.c:12:13:    float [addressable] [toplevel] f
> +autotype-ko.c:10:8: note: previously declared as:
> +autotype-ko.c:10:8:    double [addressable] [toplevel] f
> +autotype-ko.c:20:9: error: assignment to const expression
> + * check-error-end
> + */
> diff --git a/validation/autotype.c b/validation/autotype.c
> new file mode 100644
> index 000000000000..98683c93d2e8
> --- /dev/null
> +++ b/validation/autotype.c
> @@ -0,0 +1,55 @@
> +#ifdef __CHECKER__
> +#define	is_type(X, T)	_Static_assert([typeof(X)] == [T], "")
> +#else
> +#define	is_type(X, T)	_Static_assert(1, "")
> +#endif
> +
> +struct s {
> +	int x;
> +	int bf:3;
> +};
> +
> +extern char ch;
> +extern const int ci;
> +
> +__auto_type i = 0;		is_type(i, int);
> +__auto_type m = 1UL;		is_type(m, unsigned long);
> +__auto_type l = (int)0L;	is_type(l, int);
> +__auto_type c = (char)'\n';	is_type(c, char);
> +__auto_type p = &i;		is_type(p, int *);
> +__auto_type f = 0.0;		is_type(f, double);
> +__auto_type s = (struct s){0};	is_type(s, struct s);
> +__auto_type pci = &ci;		is_type(pci, const int *);
> +
> +// ~~: not valid for bitfield
> +__auto_type b = (struct s){0}.bf; is_type(b, int);
> +
> +static __auto_type si = 0;	is_type(si, int);
> +const  __auto_type ci = 0;	is_type(ci, const int);
> +__auto_type ch = (char) '\n';	is_type(ch, char);
> +
> +static int foo(int a)
> +{
> +	__auto_type i = a;	is_type(i, int);
> +	__auto_type c = ch;	is_type(c, char);
> +	__auto_type ct = ci;	is_type(&ct, const int *);
> +
> +	return ct += i + c;
> +}
> +
> +
> +
> +#define __as __attribute__((address_space(42)))
> +extern int __as aa;
> +
> +__auto_type pa = &aa;		is_type(pa, int __as *);
> +
> +/*
> + * check-name: autotype
> + * check-command: sparse -Wno-decl $file
> + *
> + * check-error-start
> +autotype.c:25:13: warning: __auto_type on bitfield
> +autotype.c:37:16: error: assignment to const expression
> + * check-error-end
> + */
> 
