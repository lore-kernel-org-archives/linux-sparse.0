From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 14/28] scope: extract bind_symbol_with_scope() from
 bind_symbol()
Date: Wed, 20 May 2020 01:44:12 +0100
Message-ID: <94c72b94-814a-ee32-b107-523f43ad9299@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-15-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:32814 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAoQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:44:16 -0400
In-Reply-To: <20200519005728.84594-15-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>



On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> In most cases, the scope that must be used for a symbol is
> given by its namespace.
> 
> However, in some situations a different scope must be used.
> This is then set, for exemple by doing the lookup with

s/exemple/example/

ATB,
Ramsay Jones

> the wrong namespace (but corresponding to the desired scope)
> and changing it just after to its correct value.
> 
> To avoid these contortions, extract from bind_symbol() a version
> where the scope can be explicitly given: bind_symbol_with_scope().
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  symbol.c | 13 +++++++++----
>  symbol.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/symbol.c b/symbol.c
> index c2e6f0b426b3..7044ab3f78ce 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -671,9 +671,8 @@ static void inherit_static(struct symbol *sym)
>  	}
>  }
>  
> -void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
> +void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum namespace ns, struct scope *scope)
>  {
> -	struct scope *scope;
>  	if (sym->bound) {
>  		sparse_error(sym->pos, "internal error: symbol type already bound");
>  		return;
> @@ -690,7 +689,6 @@ void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
>  	sym->ident = ident;
>  	sym->bound = 1;
>  
> -	scope = block_scope;
>  	if (ns == NS_SYMBOL && toplevel(scope)) {
>  		unsigned mod = MOD_ADDRESSABLE | MOD_TOPLEVEL;
>  
> @@ -704,11 +702,18 @@ void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
>  		}
>  		sym->ctype.modifiers |= mod;
>  	}
> +	bind_scope(sym, scope);
> +}
> +
> +void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
> +{
> +	struct scope *scope = block_scope;;
> +
>  	if (ns == NS_MACRO)
>  		scope = file_scope;
>  	if (ns == NS_LABEL)
>  		scope = function_scope;
> -	bind_scope(sym, scope);
> +	bind_symbol_with_scope(sym, ident, ns, scope);
>  }
>  
>  struct symbol *create_symbol(int stream, const char *name, int type, int namespace)
> diff --git a/symbol.h b/symbol.h
> index 50dba78a654a..c297c778dfdf 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -332,6 +332,7 @@ extern void show_type_list(struct symbol *);
>  extern void show_symbol_list(struct symbol_list *, const char *);
>  extern void add_symbol(struct symbol_list **, struct symbol *);
>  extern void bind_symbol(struct symbol *, struct ident *, enum namespace);
> +extern void bind_symbol_with_scope(struct symbol *, struct ident *, enum namespace, struct scope *);
>  
>  extern struct symbol *examine_symbol_type(struct symbol *);
>  extern struct symbol *examine_pointer_target(struct symbol *);
> 
