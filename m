From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH 15/16] include/linux/compiler.h: remove unused KENTRY macro
Date: Mon, 19 Aug 2019 20:03:58 +0200
Message-ID: <CA+icZUWjJ27CHwRExsvxrnWkaEx71j8pcf7HBeZc8GWnjLcLQw@mail.gmail.com>
References: <20190812215052.71840-1-ndesaulniers@google.com> <20190812215052.71840-15-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190812215052.71840-15-ndesaulniers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: akpm@linux-foundation.org, jpoimboe@redhat.com, yhs@fb.com, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Aug 12, 2019 at 11:53 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> This macro is not used throughout the kernel. Delete it rather than
> update the __section to be a fully spelled out
> __attribute__((__section__())) to avoid
> https://bugs.llvm.org/show_bug.cgi?id=42950.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ Linux v5.3-rc5 ]

Patchset "for-5.3/x86-section-name-escaping" (5 patches):

compiler_attributes.h: add note about __section
include/linux/compiler.h: remove unused KENTRY macro
include/linux: prefer __section from compiler_attributes.h
include/asm-generic: prefer __section from compiler_attributes.h
x86: prefer __section from compiler_attributes.h

Thanks.

- Sedat -

> ---
>  include/linux/compiler.h | 23 -----------------------
>  1 file changed, 23 deletions(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 5e88e7e33abe..f01c1e527f85 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -136,29 +136,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  } while (0)
>  #endif
>
> -/*
> - * KENTRY - kernel entry point
> - * This can be used to annotate symbols (functions or data) that are used
> - * without their linker symbol being referenced explicitly. For example,
> - * interrupt vector handlers, or functions in the kernel image that are found
> - * programatically.
> - *
> - * Not required for symbols exported with EXPORT_SYMBOL, or initcalls. Those
> - * are handled in their own way (with KEEP() in linker scripts).
> - *
> - * KENTRY can be avoided if the symbols in question are marked as KEEP() in the
> - * linker script. For example an architecture could KEEP() its entire
> - * boot/exception vector code rather than annotate each function and data.
> - */
> -#ifndef KENTRY
> -# define KENTRY(sym)                                           \
> -       extern typeof(sym) sym;                                 \
> -       static const unsigned long __kentry_##sym               \
> -       __used                                                  \
> -       __section("___kentry" "+" #sym )                        \
> -       = (unsigned long)&sym;
> -#endif
> -
>  #ifndef RELOC_HIDE
>  # define RELOC_HIDE(ptr, off)                                  \
>    ({ unsigned long __ptr;                                      \
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
