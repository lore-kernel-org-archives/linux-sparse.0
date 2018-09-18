From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 1/2] Compiler Attributes: naked was fixed in gcc 4.6
Date: Mon, 17 Sep 2018 20:12:56 -0700
Message-ID: <37d9042a2a6331cecd561162a615bd62@agner.ch>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-2-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913235941.31211-2-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On 13.09.2018 16:59, Miguel Ojeda wrote:
> Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
> and noinline on __naked functions") added noinline and noclone
> as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.
> 
> Since now the minimum gcc supported version is 4.6,
> we can clean it up.
> 
> See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
> and https://godbolt.org/z/h6NMIL
> 
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  include/linux/compiler-gcc.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 763bbad1e258..25d3dd6b2702 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -84,14 +84,8 @@
>   * to trace naked functions because then mcount is called without
>   * stack and frame pointer being set up and there is no chance to
>   * restore the lr register to the value before mcount was called.
> - *
> - * The asm() bodies of naked functions often depend on standard calling
> - * conventions, therefore they must be noinline and noclone.
> - *
> - * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
> - * See GCC PR44290.
>   */
> -#define __naked		__attribute__((naked)) noinline __noclone notrace
> +#define __naked		__attribute__((naked)) notrace
>  
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
