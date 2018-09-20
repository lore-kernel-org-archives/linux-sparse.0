From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Thu, 20 Sep 2018 09:19:30 +0200
Message-ID: <20180920071930.GA11963@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com>
 <CANiq72kS_w7p3Xe9cDCjCA9j1u-zQ1-C4ZX7N8G+AbP4u7SG8w@mail.gmail.com>
 <6837090afde15cd5ee155dbfabb0d556@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6837090afde15cd5ee155dbfabb0d556@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 19, 2018 at 11:00:37PM -0700, Stefan Agner wrote:
> On 19.09.2018 16:00, Miguel Ojeda wrote:
> > On Wed, Sep 19, 2018 at 11:14 PM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Tue, Sep 18, 2018 at 08:56:04PM +0200, Miguel Ojeda wrote:
> >>> Hi Greg,
> >>>
> >>
> >>> Since Linus/Andrew/you
> >>> didn't comment on whether you wanted or not this for 4.19, we are
> >>> assuming they would go in for 4.20. However, Stefan/Nick/... wanted
> >>> this for 4.19 instead, they asked me to extract these patches two
> >>> separately for 4.19. I let them comment further on the status of Clang
> >>> on arm32.
> >>
> >> If these do not fix a regression, I don't see how they would be ready
> >> for 4.19-final.
> 
> Clang on arm32 worked with v4.18 when using multi_v7_defconfig -CONFIG_EFI.

That's a narrow definition :)

> With 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
> exclusive") it broke on v4.19-rc1. IMHO this is a regression and we should
> consider this two patches as a fix for it.

Why not just revert 815f0ddb346c instead and work to get it right for
4.20-rc1?

thanks,

greg k-h
