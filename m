From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 10/12] Compiler Attributes: KENTRY used twice the "used" attribute
Date: Tue, 4 Sep 2018 09:58:11 -0700
Message-ID: <CAKwvOdk_yMOCGbEWcZH4aPP6ShS4DtSg0Qo6AnU-2+4WKu+Mqw@mail.gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com> <20180903203316.16183-11-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903203316.16183-11-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, luc.vanoostenryck@gmail.com, efriedma@codeaurora.org, sparse@chrisli.org, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, joe@perches.com, asmadeus@codewreck.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Sep 3, 2018 at 1:34 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 4030a2940d6b..17ee9165ca51 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -146,7 +146,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>         extern typeof(sym) sym;                                 \
>         static const unsigned long __kentry_##sym               \
>         __used                                                  \
> -       __attribute__((__section__("___kentry" "+" #sym ), used))       \
> +       __attribute__((__section__("___kentry" "+" #sym )))     \
>         = (unsigned long)&sym;
>  #endif
>
> --
> 2.17.1
>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
