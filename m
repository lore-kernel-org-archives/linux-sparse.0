From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 09:39:43 +0000
Message-ID: <427C14A0-ED1F-4A13-B5BD-106E491A23F1@cam.ac.uk>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org> <20070212191434.GA1041@chrisli.org> <Pine.LNX.4.64.0702130014290.6264@hermes-1.csi.cam.ac.uk> <20070213014657.GA2922@chrisli.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:39486 "EHLO
	ppsw-3.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965478AbXBMJkE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 04:40:04 -0500
In-Reply-To: <20070213014657.GA2922@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

Hi,

On 13 Feb 2007, at 01:46, Christopher Li wrote:
> I see. In evaluate_call().
> evaluate_arguments() is called before target function arguments
> are converted into pointers.
>
> Can you please try this patch instead?

This one works!  (-:

I put it in and now it does not matter whether the linux/fs.h  
get_bloc_t typedef has the "*" or not, both times it does not give a  
warning at all:

   CHECK   fs/ntfs/file.c
   CC [M]  fs/ntfs/file.o

Best regards,

	Anton


>
> Chris
>
> Index: sparse/symbol.h
> ===================================================================
> --- sparse.orig/symbol.h	2007-02-12 18:10:01.000000000 -0800
> +++ sparse/symbol.h	2007-02-12 18:10:06.000000000 -0800
> @@ -191,6 +191,7 @@ struct symbol {
>  #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
>  #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
>  	MOD_ASSIGNED | MOD_USERTYPE | MOD_FORCE | MOD_ACCESSED |  
> MOD_EXPLICITLY_SIGNED)
> +#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF |  
> MOD_STORAGE)
>
>
>  /* Current parsing/evaluation function */
> Index: sparse/evaluate.c
> ===================================================================
> --- sparse.orig/evaluate.c	2007-02-12 18:10:01.000000000 -0800
> +++ sparse/evaluate.c	2007-02-12 18:10:48.000000000 -0800
> @@ -1282,11 +1282,11 @@ static void examine_fn_arguments(struct
>  				else
>  					ptr->ctype.base_type = arg;
>  				ptr->ctype.as |= s->ctype.as;
> -				ptr->ctype.modifiers |= s->ctype.modifiers;
> +				ptr->ctype.modifiers |= s->ctype.modifiers & MOD_PTRINHERIT;
>
>  				s->ctype.base_type = ptr;
>  				s->ctype.as = 0;
> -				s->ctype.modifiers = 0;
> +				s->ctype.modifiers &= ~MOD_PTRINHERIT;
>  				s->bit_size = 0;
>  				s->examined = 0;
>  				examine_symbol_type(s);
> @@ -1313,8 +1313,6 @@ static struct symbol *convert_to_as_mod(
>  	return sym;
>  }
>
> -#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF |  
> MOD_STORAGE)
> -
>  static struct symbol *create_pointer(struct expression *expr,  
> struct symbol *sym, int degenerate)
>  {
>  	struct symbol *node = alloc_symbol(expr->pos, SYM_NODE);
> @@ -2309,7 +2307,6 @@ static int evaluate_symbol_call(struct e
>  		int ret;
>  		struct symbol *curr = current_fn;
>  		current_fn = ctype->ctype.base_type;
> -		examine_fn_arguments(current_fn);
>
>  		ret = inline_function(expr, ctype);
>
> @@ -2336,6 +2333,7 @@ static struct symbol *evaluate_call(stru
>  	if (ctype->type == SYM_PTR || ctype->type == SYM_ARRAY)
>  		ctype = get_base_type(ctype);
>
> +	examine_fn_arguments(ctype);
>          if (sym->type == SYM_NODE && fn->type == EXPR_PREOP &&
>  	    sym->op && sym->op->args) {
>  		if (!sym->op->args(expr))
>
>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
