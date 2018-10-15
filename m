From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] compiler.h: update definition of unreachable()
Date: Mon, 15 Oct 2018 13:13:46 -0700
Message-ID: <CAKwvOdnwfXSdBw_Y2zpAEdcn3aWRqUq9Fh8uk8EnkxPMC+c2Sw@mail.gmail.com>
References: <20181015172221.35709-1-ndesaulniers@google.com> <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: luto@amacapital.net, Josh Poimboeuf <jpoimboe@redhat.com>, Nathan Chancellor <natechancellor@gmail.com>, sparse@chrisli.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 15, 2018 at 11:21 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 15, 2018 at 7:22 PM <ndesaulniers@google.com> wrote:
> >
> > Fixes the objtool warning seen with Clang:
> > arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> > instruction
> >
> > Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> > mutually exclusive")
> >
> > Josh noted that the fallback definition was meant to work around a
> > pre-gcc-4.6 bug. GCC still needs to work around
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365, so compiler-gcc.h
> > defines its own version of unreachable().  Clang and ICC can use this
> > shared definition.
>
> Could we, at the same time, update the comment on compiler-gcc.h as
> well? i.e. remove the 4.5 comment, add the link to the GCC PR.

Looking at commit cb984d101b30 ("compiler-gcc: integrate the various
compiler-gcc[345].h files") it seems that the comment is referring to
gcc 4.4 not supporting __builtin_unreachable().  Looks like it was
added in 4.5 timeframe: https://godbolt.org/z/ugv5QO, so the comment
can be deleted.  Would you prefer a v2 (single patch), or an
additional patch on top?

>
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/204
> > Suggested-by: Andy Lutomirski <luto@amacapital.net>
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Miguel, would you mind taking this up in your new compiler attributes
> > tree?
>
> Sure, will do.
>
> Thanks,
>
> Cheers,
> Miguel



-- 
Thanks,
~Nick Desaulniers
