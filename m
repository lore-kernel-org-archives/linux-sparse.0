From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 02:10:24 +0200
Message-ID: <20180920001024.GD20280@nautica>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com>
 <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Miguel Ojeda wrote on Thu, Sep 20, 2018:
> > I've not followed so closely, in particular I'm not sure if it's the
> > only problem with arm32 right now, but that is a regression - the
> > general serie is meant as an improvement, but these two patches fix
> > 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
> > exclusive") which was taken in 4.19-rc1
> >
> > (Miguel, perhaps a Fixes: tag might help remember that?)
> 
> The commit is mentioned in the commit message, although not with the
> Fixes: syntax -- is something now automatically parsing that? I guess
> it is also easier for humans to parse :)

As far as I'm aware, the backport to stable stuff parse these to know up
till how far back they should backport, but it still requires explicit
Cc to the stable@vger list... (not needed here as the "bad" commit never
made it to stable)
I'm not aware of anything else, but as you said, while I now see you
naming the commit now, I managed to miss it earlier and I was somewhat
following this so it's probably also easier on humans :)

> > (If no-one in Cc has anything included in -next I could take them in my
> > 9p branch, but that is quite a bit out of scope from what I advertised
> > this branch as so I think it would be confusing ; I think it might
> > almost be best if Miguel will keep maintaining these in the future to do
> > his own request to inclusion in -next?)
> 
> I can ask for my auxdisplay tree (or better, a new one) to be in -next
> and use that (are non-kernel.org trees allowed to be in -next, by the
> way?).

I think a new one would be great, yes.
(my branch is on github, so Stephen does not appear to mind
non-kernel.org trees)

-- 
Dominique Matinet
