From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 07/12] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
Date: Wed, 5 Sep 2018 21:49:01 +0200
Message-ID: <20180905194900.oln7qsifgcyuozrq@ltop.local>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
 <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
 <20180905182038.muv535vfugm72spk@ltop.local>
 <20180905193035.GB3420@localhost>
 <CA+55aFxWcAqzuYOn1OPnRy5g5Uj69mQvxDK9Tn5HqecA-f3eiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxWcAqzuYOn1OPnRy5g5Uj69mQvxDK9Tn5HqecA-f3eiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 05, 2018 at 12:40:26PM -0700, Linus Torvalds wrote:
> On Wed, Sep 5, 2018 at 12:30 PM Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > Unlike GCC, I don't think it's at all unreasonable to assume a
> > *relatively* recent version of Sparse.
> 
> Yeah, sparse is small and easy to build and installs in your own
> ~/bin/ directory by default.
> 
> Anybody who can build the kernel can trivially fetch and build sparse
> in seconds.  It literally builds from scratch in 2.5s for me.
> 
> I don't think you even need any development packages that you don't
> already need for the kernel. Just a C compiler and libc, basically.
> 
> Sure, some parts of sparse can use things like libxml and llvm and
> even gtk, but that's for functionality that the "check kernel with
> sparse" doesn't even need, and the makefile will automatically disable
> them if you don't have it installed.
> 
> So if people are having trouble, just point them to the sparse repo,
> and tell them that
> 
>     git clone ...
>     cd sparse
>     make -j8
>     make install
> 
> fixes the issue in 30 seconds.
> 
> Although maybe I'm misstating just how easy sparse is to build and
> install, and people have had problems?
> 

I never heard of anyone having a problem to build sparse but I
guess that a lot of people just use their distro's version.

That said, I'm of course, all for encouraging people to upgrad
to a recent version.


-- Luc
