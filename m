From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] compiler/compiler-gcc: Add __fallthrough
Date: Fri, 10 Feb 2017 14:18:33 -0300
Message-ID: <20170210171833.GB14313@kernel.org>
References: <20170210144238.GC15066@kernel.org>
 <791a2621851fc989bc04dfe975ec29de15cbb557.1486746344.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbdBJRUa (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Feb 2017 12:20:30 -0500
Content-Disposition: inline
In-Reply-To: <791a2621851fc989bc04dfe975ec29de15cbb557.1486746344.git.joe@perches.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Christopher Li <sparse@chrisli.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

Em Fri, Feb 10, 2017 at 09:08:35AM -0800, Joe Perches escreveu:
> gcc v7.0 can warn on missing break statements from case labels
> using a special __attribute__((fallthrough))__ marker.
> 
> Add a __fallthrough convenience macro for gcc versions >= 7 and
> make the generic use of __fallthrough a no-op.

Can you state in the log message were this idea came from? Say,
something like:

"This was introduced in the tools/include/linux/compiler.h, where it was
first noticed while buildint tools/perf/ in a Fedora Rawhide
environment."

BTW, I added this to my tree:

https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=e058554b1418e00864f1702c84bfa1d7cf314627

tools include: Introduce linux/compiler-gcc.h

To match the kernel headers structure, setting up things that are
specific to gcc or to some specific version of gcc.

It gets included by linux/compiler.h when gcc is the compiler being
used.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Perches <joe@perches.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-pi5mxx176lotfce90rn17j88@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks,

- Arnaldo
 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  include/linux/compiler-gcc.h | 7 +++++++
>  include/linux/compiler.h     | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index d5e1fedbad24..6af8d6448f10 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -304,6 +304,13 @@
>  #define __no_sanitize_address __attribute__((no_sanitize_address))
>  #endif
>  
> +#if GCC_VERSION >= 70000
> +/*
> + * Tell the compiler not to warn when a switch/case fallthrough marker exists
> + */
> +#define __fallthrough __attribute__ ((fallthrough))
> +#endif
> +
>  #endif	/* gcc version >= 40000 specific checks */
>  
>  #if !defined(__noclone)
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 6e8e160b1e4b..16b6efc877f4 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -477,6 +477,12 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>  #define __assume_aligned(a, ...)
>  #endif
>  
> +/*
> + * switch/case fallthrough checking
> + */
> +#ifndef __fallthrough
> +#define __fallthrough
> +#endif
>  
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #ifndef __same_type
> -- 
> 2.10.0.rc2.1.g053435c
