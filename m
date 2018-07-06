From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compiler.h, sparse, smatch: Do not define
 COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
Date: Fri, 6 Jul 2018 19:31:21 +0200
Message-ID: <20180706173120.4pg5wwtuqggl6sah@ltop.local>
References: <20180705155726.26716-1-bart.vanassche@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705155726.26716-1-bart.vanassche@wdc.com>
Sender: stable-owner@vger.kernel.org
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <keescook@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>, stable@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Jul 05, 2018 at 08:57:26AM -0700, Bart Van Assche wrote:
> Both sparse and smatch identify themselves as gcc. However, neither
> static analyzer supports any of the __builtin_*_overflow() functions.
> Hence do not define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW for these
> static checkers.
> 
> Fixes: f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/compiler-gcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f1a7492a5cc8..15e55b89e952 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -344,6 +344,6 @@
>   */
>  #define uninitialized_var(x) x = x
>  
> -#if GCC_VERSION >= 50100
> +#if GCC_VERSION >= 50100 && !defined(__CHECKER__)
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> -- 

Hi,

A similar patch has already been posted 2 or 3 weeks ago [1].

Also, the development version of sparse [2] supports the
__builtin_*_overflow() functions *and* supports the __has_builtin()
macro. So I think it's preferable to use __has_builtin(),
at least for sparse (maybe smatch is interested in it too).

-- Luc Van Oostenryck

[1] https://lore.kernel.org/lkml/alpine.LSU.2.21.1806071258310.7958@pobox.suse.cz/
[2] git://github.com/lucvoo/sparse.git
