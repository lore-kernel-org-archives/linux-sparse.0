From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 01:05:04 +0200
Message-ID: <20180919230504.GA20280@nautica>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180919211458.GA8757@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Greg Kroah-Hartman wrote on Wed, Sep 19, 2018:
> > > So, with this applied, does clang really build an arm32 kernel
> > > successfully?  No other problem at all?  And this isn't really a
> > > regression, arm32 never really worked with clang yet, right?
> > 
> > To recap a bit: these two patches come from the "Compiler Attributes"
> > series which is meant as a general improvement.
> 
> Ok, so that's not for regressions, that's fine.

I've not followed so closely, in particular I'm not sure if it's the
only problem with arm32 right now, but that is a regression - the
general serie is meant as an improvement, but these two patches fix
815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
exclusive") which was taken in 4.19-rc1

(Miguel, perhaps a Fixes: tag might help remember that?)

> If these do not fix a regression, I don't see how they would be ready
> for 4.19-final.

So the rest of the series is not a regression and isn't ready for
4.19-final, these two would be, but only got tested by the handful of
people in Cc here ; so ultimately it's your call.


> > I am going to send a v5 of the entire series without these two
> > patches, based on -rc4 (or -next, which one do you prefer? I would say
> > these patches should be applied early in the -next branches, so that
> > everyone is ready for the change, given it "touches" every translation
> > unit).
> 
> That's up to whomever takes these into their tree for linux-next
> inclusion.  If you are about to break everything, then you might
> consider changing your patches so they do not do that :)

I think that was more or less his question, there is no maintainer for
these files, so who should that whomever be? :)
The thing is linux took this kind of patch directly last time, but
ideally it really should sink in -next for a bit...

(If no-one in Cc has anything included in -next I could take them in my
9p branch, but that is quite a bit out of scope from what I advertised
this branch as so I think it would be confusing ; I think it might
almost be best if Miguel will keep maintaining these in the future to do
his own request to inclusion in -next?)

-- 
Dominique Martinet
