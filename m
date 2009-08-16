From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sun, 16 Aug 2009 05:41:57 -0700
Message-ID: <20090816124157.GA6936@feather>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
 <1250367991.14751.1.camel@penberg-laptop>
 <20090815223602.GA4516@feather>
 <1250406233.32343.9.camel@penberg-laptop>
 <20090816105114.GA6489@feather>
 <1250420733.9535.1.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:35430 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbZHPMxg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 16 Aug 2009 08:53:36 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 5D08786052
	for <linux-sparse@vger.kernel.org>; Sun, 16 Aug 2009 13:42:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250420733.9535.1.camel@penberg-laptop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org

On Sun, Aug 16, 2009 at 02:05:33PM +0300, Pekka Enberg wrote:
> Of course. Here's the final patch. *fingers crossed*

Looks good to me.

Acked-by: Josh Triplett <josh@joshtriplett.org>

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> Date: Sat, 15 Aug 2009 23:22:24 +0300
> Subject: [PATCH] Define GCC builtin defines for limits.h
> 
> Sparse produces a bunch of warnings like this when compiling against
> glibc:
> 
>   /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:33:22: warning: undefined preprocessor identifier '__INT_MAX__'
>   /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:64:5: warning: undefined preprocessor identifier '__SHRT_MAX__'
>   /usr/lib/gcc/i486-linux-gnu/4.3.2//include-fixed/limits.h:64:21: warning: undefined preprocessor identifier '__INT_MAX__'
>   /usr/include/bits/xopen_lim.h:95:6: warning: undefined preprocessor identifier '__INT_MAX__'
>   /usr/include/bits/xopen_lim.h:98:7: warning: undefined preprocessor identifier '__INT_MAX__'
> 
> Fix that up by adding some add_pre_buffer() calls to
> create_builtin_define(). For future reference, GCC defines the builtins
> in the c_cpp_builtins() function in gcc/c-cppbuiltin.c.
> 
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
>  lib.c |    8 ++++++++
>  lib.h |    3 +++
>  2 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/lib.c b/lib.c
> index 42affcd..fb7e9bc 100644
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
> index b22fa93..25abb80 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -17,6 +17,9 @@
>  #include "compat.h"
>  #include "ptrlist.h"
>  
> +#define DO_STRINGIFY(x) #x
> +#define STRINGIFY(x) DO_STRINGIFY(x)
> +
>  extern int verbose, optimize, optimize_size, preprocessing;
>  extern int die_if_error;
>  extern int repeat_phase, merge_phi_sources;
