From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/2] sparse, llvm: Fix varargs functions
Date: Wed, 01 Feb 2012 21:47:34 +1100
Message-ID: <1328093254.28487.74.camel@pasglop>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	 <1328090152-28299-2-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35969 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab2BAKrr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 05:47:47 -0500
In-Reply-To: <1328090152-28299-2-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, 2012-02-01 at 11:55 +0200, Pekka Enberg wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> We need to tell llvm about it or it won't generate the proper
> stack frame & argument list on some architectures.
> 
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [ penberg@kernel.org: Fix function pointer calls ]
> Signed-off-by: Pekka Enberg <penberg@kernel.org>
> ---
>  sparse-llvm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sparse-llvm.c b/sparse-llvm.c
> index a291a0d..9226a21 100644
> --- a/sparse-llvm.c
> +++ b/sparse-llvm.c
> @@ -79,7 +79,7 @@ static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
>  		arg_type[idx++] = symbol_type(module, arg_sym);
>  	} END_FOR_EACH_PTR(arg);
>  	func_type = LLVMFunctionType(ret_type, arg_type, n_arg,
> -				     /* varargs? */ 0);
> +				     sym->ctype.base_type->variadic);
>  
>  	return func_type;
>  }

Is the above hunk correct ? It was really just a guess, I haven't tested
that code path :-)

From my understanding (please correct me if I'm wrong) this is used to
generate a type for a function pointer inside a structure definition or
an argument list... so I -assume- base_type will work but still only
have a very blurry version of the big picture in mind...

(And no time to do more than answer email on that subject today)

> @@ -744,7 +744,7 @@ static LLVMTypeRef get_func_type(struct function *fn, struct instruction *insn)
>  	} END_FOR_EACH_PTR(arg);
>  
>  	func_type = LLVMFunctionType(ret_type, arg_type, n_arg,
> -				     /* varargs? */ 0);
> +				     insn->fntype->variadic);
>  
>  	return func_type;
>  }

Cheers,
Ben.


