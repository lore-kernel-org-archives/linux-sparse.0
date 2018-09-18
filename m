From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/2] Compiler Attributes: naked can be shared
Date: Mon, 17 Sep 2018 20:19:50 -0700
Message-ID: <40a059bad54389ff2a9ddc26b9d99a4b@agner.ch>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On 13.09.2018 16:59, Miguel Ojeda wrote:
> The naked attribute is supported by at least gcc >= 4.6 (for ARM,
> which is the only current user), gcc >= 8 (for x86), clang >= 3.1
> and icc >= 13. See https://godbolt.org/z/350Dyc
> 
> Therefore, move it out of compiler-gcc.h so that the definition
> is shared by all compilers.
> 
> This also fixes Clang support for ARM32 --- 815f0ddb346c
> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
> 
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

Ideally this two patches should go into v4.19. Not sure which path the patch should take, MAINTAINERS is not quite clear about that. This fixes 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive") for ARM32, which has been merged directly by
Linus, afaict...

--
Stefan

> ---
>  include/linux/compiler-gcc.h   | 8 --------
>  include/linux/compiler_types.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 25d3dd6b2702..4d36b27214fd 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -79,14 +79,6 @@
>  #define __noretpoline __attribute__((indirect_branch("keep")))
>  #endif
>  
> -/*
> - * it doesn't make sense on ARM (currently the only user of __naked)
> - * to trace naked functions because then mcount is called without
> - * stack and frame pointer being set up and there is no chance to
> - * restore the lr register to the value before mcount was called.
> - */
> -#define __naked		__attribute__((naked)) notrace
> -
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>  
>  #define __optimize(level)	__attribute__((__optimize__(level)))
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3525c179698c..db192becfec4 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -226,6 +226,14 @@ struct ftrace_likely_data {
>  #define notrace			__attribute__((no_instrument_function))
>  #endif
>  
> +/*
> + * it doesn't make sense on ARM (currently the only user of __naked)
> + * to trace naked functions because then mcount is called without
> + * stack and frame pointer being set up and there is no chance to
> + * restore the lr register to the value before mcount was called.
> + */
> +#define __naked			__attribute__((naked)) notrace
> +
>  #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
>  
>  /*
