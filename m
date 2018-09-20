From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] Compiler Attributes: (naked only, for v4.19)
Date: Thu, 20 Sep 2018 15:57:48 +0200
Message-ID: <20180920135748.GA7749@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Stefan Agner <stefan@agner.ch>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Sep 18, 2018 at 06:55:40PM +0200, Miguel Ojeda wrote:
> These two patches are the 5th and 6th of the Compiler Attributes series,
> which Stefan and Nick requested to go into v4.19 so that the clang ARM32
> build is fixed. The v5 of Compiler Attributes will have these two removed
> if this goes in.

As these seem pretty "obvious" and they do fix a problem for one
system/compiler that we want to support, and because odds are I would
end up getting them submitted to the 4.19-stable tree eventually, I've
now applied them to the tree.

thanks,

greg k-h
