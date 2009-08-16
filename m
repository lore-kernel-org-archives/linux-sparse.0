From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sun, 16 Aug 2009 03:51:14 -0700
Message-ID: <20090816105114.GA6489@feather>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
 <1250367991.14751.1.camel@penberg-laptop>
 <20090815223602.GA4516@feather>
 <1250406233.32343.9.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:57139 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbZHPKvZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 16 Aug 2009 06:51:25 -0400
Content-Disposition: inline
In-Reply-To: <1250406233.32343.9.camel@penberg-laptop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org

On Sun, Aug 16, 2009 at 10:03:53AM +0300, Pekka Enberg wrote:
> On Sat, 2009-08-15 at 15:36 -0700, Josh Triplett wrote:
> > These defines need to have the right type suffixes.  GCC defines
> > __LONG_LONG_MAX__ with an LL suffix, and __LONG_MAX__ with an L suffix.
> > You could either add the appropriate suffixes, or better yet, stringize
> > the constants and print them as strings.
> 
> Right. Is there a macro in sparse to do the stringification? I didn't
> find one and the best I could come up is this.
[...]
> --- a/lib.c
> +++ b/lib.c
> @@ -788,6 +788,14 @@ void create_builtin_stream(void)
>  		add_pre_buffer("#define __OPTIMIZE__ 1\n");
>  	if (optimize_size)
>  		add_pre_buffer("#define __OPTIMIZE_SIZE__ 1\n");
> +
> +	/* GCC defines these for limits.h */
> +	add_pre_buffer("#weak_define __SHRT_MAX__ " STRINGIFY(__SHRT_MAX__) "\n");
> +	add_pre_buffer("#weak_define __SCHAR_MAX__ " STRINGIFY(__SCHAR_MAX__) "\n");
> +	add_pre_buffer("#weak_define __INT_MAX__ " STRINGIFY(__INT_MAX__) "\n");
> +	add_pre_buffer("#weak_define __LONG_MAX__ " STRINGIFY(__LONG_MAX__) "\n");
> +	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
> +	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
>  }
>  
>  static struct symbol_list *sparse_tokenstream(struct token *token)
> diff --git a/lib.h b/lib.h
> index b22fa93..62f7433 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -17,6 +17,9 @@
>  #include "compat.h"
>  #include "ptrlist.h"
>  
> +#define __STRINGIFY(x) #x
> +#define STRINGIFY(x) __STRINGIFY(x)
> +

This looks fine, with one minor nit: s/__STRINGIFY/STRINGIFY2/g or
similar.  The C language reserves identifiers containing "__" (C99
"7.1.3 Reserved identifiers").

- Josh Triplett
