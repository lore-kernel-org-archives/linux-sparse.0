From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 09:20:25 +0200
Message-ID: <20180920072025.GB11963@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com>
 <CANiq72kS_w7p3Xe9cDCjCA9j1u-zQ1-C4ZX7N8G+AbP4u7SG8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANiq72kS_w7p3Xe9cDCjCA9j1u-zQ1-C4ZX7N8G+AbP4u7SG8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Sep 20, 2018 at 01:00:41AM +0200, Miguel Ojeda wrote:
> >> I am going to send a v5 of the entire series without these two
> >> patches, based on -rc4 (or -next, which one do you prefer? I would say
> >> these patches should be applied early in the -next branches, so that
> >> everyone is ready for the change, given it "touches" every translation
> >> unit).
> >
> > That's up to whomever takes these into their tree for linux-next
> > inclusion.  If you are about to break everything, then you might
> > consider changing your patches so they do not do that :)
> >
> 
> Well, the series shouldn't break anything (famous last words :), even
> if everyone includes those headers. So, in theory, they *could* be
> applied anywhere, anytime; but given they are global changes...

It doesn't matter the "order" in which global changes are added to
linux-next.  If you think it does, please work with the linux-next
maintainer to properly place your tree in the correct "location".

thanks,

greg k-h
