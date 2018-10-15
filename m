From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] compiler.h: update definition of unreachable()
Date: Mon, 15 Oct 2018 20:21:35 +0200
Message-ID: <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com>
References: <20181015172221.35709-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015172221.35709-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: luto@amacapital.net, Josh Poimboeuf <jpoimboe@redhat.com>, Nathan Chancellor <natechancellor@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 15, 2018 at 7:22 PM <ndesaulniers@google.com> wrote:
>
> Fixes the objtool warning seen with Clang:
> arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> instruction
>
> Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> mutually exclusive")
>
> Josh noted that the fallback definition was meant to work around a
> pre-gcc-4.6 bug. GCC still needs to work around
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365, so compiler-gcc.h
> defines its own version of unreachable().  Clang and ICC can use this
> shared definition.

Could we, at the same time, update the comment on compiler-gcc.h as
well? i.e. remove the 4.5 comment, add the link to the GCC PR.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/204
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Miguel, would you mind taking this up in your new compiler attributes
> tree?

Sure, will do.

Thanks,

Cheers,
Miguel
