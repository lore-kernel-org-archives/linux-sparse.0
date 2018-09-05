From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 07/12] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
Date: Wed, 5 Sep 2018 20:20:39 +0200
Message-ID: <20180905182038.muv535vfugm72spk@ltop.local>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
 <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Sep 03, 2018 at 10:33:11PM +0200, Miguel Ojeda wrote:
> Sparse knows about a few more attributes now, so we can remove
> the __CHECKER__ conditions from them (which, in turn, allow us
> to move some of them later on to compiler_attributes.h).
> 
>   * assume_aligned: since sparse's commit ffc860b ("sparse:
>     ignore __assume_aligned__ attribute"), included in 0.5.1
> 
>   * error: since sparse's commit 0a04210 ("sparse: Add 'error'
>     to ignored attributes"), included in 0.5.0
> 
>   * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
>     ignore hotpatch attribute"), included in 0.5.1
> 
>   * warning: since sparse's commit 977365d ("Avoid "attribute
>     'warning': unknown attribute" warning"), included in 0.4.2

Hi,

I hadn't noticed in the previous version but I see now that hotpatch
& assume_aligned is only available since sparse 0.5.1 which is only
13 months old. It would be great if everyone use a recent version
but I fear that a lot of people still use something less recent.
v0.5.0 should be OK, though, it's more than 5 years old.

Sorry for not having noticed this earlier.

-- Luc 
