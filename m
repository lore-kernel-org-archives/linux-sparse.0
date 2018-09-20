From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 09:36:50 +0200
Message-ID: <20180920073650.GA6001@nautica>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com>
 <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica>
 <20180920072205.GC11963@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920072205.GC11963@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Greg Kroah-Hartman wrote on Thu, Sep 20, 2018:
> "Fixes:" is not just for stable, we use it wherever we have a patch that
> we know fixes a problem introduced in another patch.
> 
> For this instance, I think we should just revert the offending patch,
> which should resolve the issue for everyone and then you can try to redo
> your series to get it right the next time.
> 
> Sound good?

Except that 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
mutually exclusive") itself fixes cafa0010cd51 ("Raise the minimum
required gcc version to 4.6"), which breaks clang altogether (as used by
example by bcc for most BPF programs, that I caught before -rc1 got
released so we got both in rc1)

I'm not aware of anything that would break if both were to be reverted,
I have no opinion on which way to go.

> Why not just route these through Andrew?  He takes lots of stuff like
> this for this very reason.

That works for me (although it might have helped if Andrew had been in
Cc at any point in this discussion...), but part of the discussion was
about seriously maintaining these files, and Miguel stepped up to help
with that so it could make sense to have his own tree.


Frankly, after this whole episode I'd find quite helpful if "compiler
stuff" (or headers maintainance in general) were to grow its own mailing
list and start being considered like a proper component of the kernel.

It does impact quite a few people, and it's neigh-impossible to review
this stuff as things are right now with a hand-picked list of CCs, no
matter how large it is -- I don't mind if it goes in -next through its
own branch or through Andrew, but a proper place where folks interested
in these could subscribe and test/review the patches would be awesome.

-- 
Dominique Martinet
