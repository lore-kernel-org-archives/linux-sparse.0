From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 09:49:58 +0200
Message-ID: <CAMuHMdXfSOxigSkV2Ui2akpUoSrkFu3HyVoJiQyTbZY0kGpRWg@mail.gmail.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com> <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica> <20180920072205.GC11963@kroah.com> <20180920073650.GA6001@nautica>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920073650.GA6001@nautica>
Sender: linux-kernel-owner@vger.kernel.org
To: asmadeus@codewreck.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Sep 20, 2018 at 9:37 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Greg Kroah-Hartman wrote on Thu, Sep 20, 2018:
> > "Fixes:" is not just for stable, we use it wherever we have a patch that
> > we know fixes a problem introduced in another patch.
> >
> > For this instance, I think we should just revert the offending patch,
> > which should resolve the issue for everyone and then you can try to redo
> > your series to get it right the next time.
> >
> > Sound good?
>
> Except that 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> mutually exclusive") itself fixes cafa0010cd51 ("Raise the minimum
> required gcc version to 4.6"), which breaks clang altogether (as used by
> example by bcc for most BPF programs, that I caught before -rc1 got
> released so we got both in rc1)
>
> I'm not aware of anything that would break if both were to be reverted,
> I have no opinion on which way to go.

I guess reverting them makes no difference for gcc >= 4.6.

For older compilers (which were declared unsupported by cafa0010cd51),
you also need
https://lore.kernel.org/lkml/20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org/

Been there, done that, happy gcc-4.1.2 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
