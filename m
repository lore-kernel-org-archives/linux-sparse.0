From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 23:46:13 +0200
Message-ID: <4676FD25.9030504@redhat.com>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org> <20070618191653.GG21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432AbXFRVqn (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 17:46:43 -0400
In-Reply-To: <20070618191653.GG21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Al Viro wrote:
> On Mon, Jun 18, 2007 at 11:19:08AM -0700, Josh Triplett wrote:
>> Hopefully this would also fix the problem reported by Michael Stefaniuc in
>> <466489FD.7010405@redhat.com>:
>>> Running sparse on
>>>         int i = sizeof((const char []) {'a','a','a',0});
>>> gives
>>>         zzz.c:1:9: error: cannot size expression
> 
> Umm...  I don't think that it's related.  count_array_initializer() would
> work just fine for that one, since the straightforward list element counting
> would work as-is.
Right, it doesn't fixes this error. Actually the output of
make clean; CHECK='sparse -Wno-transparent-union -Wno-old-initializer
-Wno-non-pointer-null' make CC=cgcc > build.out 2>&1
is identical bit by bit with or without Al's patch series.

> Aha... I see what's going on - in evaluate_cast() we examine the type before
> associating it with initializer, so when we get around to evaluate_symbol()
> a bit later in the same function, it's too late - ->examined is already
> set.  I wonder if moving that examine_symbol_type() downstream (and killing
> it in EXPR_INITIALIZER branch) would be enough...  Looks like it should
> work, but I might be missing something here.
> 
> How does something like diff below look to you, folks?  It gets the
> testcase to produce expected result (and puts the right value into
> i); I'm running it on the kernel cross-builds right now, but that
> doesn't guarantee correctness, of course.
Works for Wine and removes most of the "error: cannot size expression"
errors. The 7 remaining errors are preceded by "error: bad constant
expression" in the same line. Have to condense those into a test case too.

> diff --git a/evaluate.c b/evaluate.c
> index c564ad9..6da8f3e 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -2416,7 +2416,7 @@ out:
>  static struct symbol *evaluate_cast(struct expression *expr)
>  {
>  	struct expression *target = expr->cast_expression;
> -	struct symbol *ctype = examine_symbol_type(expr->cast_type);
> +	struct symbol *ctype;
>  	struct symbol *t1, *t2;
>  	int class1, class2;
>  	int as1, as2;
> @@ -2424,9 +2424,6 @@ static struct symbol *evaluate_cast(struct expression *expr)
>  	if (!target)
>  		return NULL;
>  
> -	expr->ctype = ctype;
> -	expr->cast_type = ctype;
> -
>  	/*
>  	 * Special case: a cast can be followed by an
>  	 * initializer, in which case we need to pass
> @@ -2441,7 +2438,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
>  		struct symbol *sym = expr->cast_type;
>  		struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
>  
> -		sym->initializer = expr->cast_expression;
> +		sym->initializer = target;
>  		evaluate_symbol(sym);
>  
>  		addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
> @@ -2455,6 +2452,10 @@ static struct symbol *evaluate_cast(struct expression *expr)
>  		return sym;
>  	}
>  
> +	ctype = examine_symbol_type(expr->cast_type);
> +	expr->ctype = ctype;
> +	expr->cast_type = ctype;
> +
>  	evaluate_expression(target);
>  	degenerate(target);
>  


bye
	michael

-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
