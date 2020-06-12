From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/7] builtin: can be initialized later
Date: Fri, 12 Jun 2020 01:50:18 +0100
Message-ID: <93a18dfc-2cd1-2b90-7bda-ad7ce7a5197d@ramsayjones.plus.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
 <20200610202735.84968-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:60824 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLAuX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 Jun 2020 20:50:23 -0400
In-Reply-To: <20200610202735.84968-2-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 10/06/2020 21:27, Luc Van Oostenryck wrote:
> The itialization of the buitins can be done later,

s/itialization/initialization/

> after that the types have been initialized.

s/that the/the/

> 
> So move the call to init_builtins() to just before declare_builtins().
> This will allow some other small improvements.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  lib.c    | 1 +
>  symbol.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib.c b/lib.c
> index 8f071bfe96ef..aa1c1d656b9d 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -1595,6 +1595,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
>  
>  		predefined_macros();
>  		create_builtin_stream();> +		init_builtins(0);

Hmm, if memory serves (and it may not) doesn't declare_builtins()
also assume stream zero - but it had a FIXME comment against it.
So, should this new call also have a FIXME? ;-)

I think the last time I looked in the debugger, the first call to
init_stream() was for the 'builtins' - so it seems that it would
always be stream 0, but has this changed the relative location of the
init_stream() calls that would invalidate this?

Hmm, I guess not - the builtin init_stream() call was in the
sparse_initialize() call, if memory serves. Also, I guess it would
only affect the stream field of the builtin symbol token, so ...

So, ignore my rambling ... :-D

ATB,
Ramsay Jones

>  		declare_builtins();
>  
>  		list = sparse_initial();
> diff --git a/symbol.c b/symbol.c
> index 7044ab3f78ce..6ee521ba48d8 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -783,7 +783,6 @@ void init_symbols(void)
>  #include "ident-list.h"
>  
>  	init_parser(stream);
> -	init_builtins(stream);
>  }
>  
>  // For fix-sized types
> 
