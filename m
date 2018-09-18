From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Tue, 18 Sep 2018 19:34:28 +0200
Message-ID: <20180918173428.GA21591@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Sep 18, 2018 at 06:55:42PM +0200, Miguel Ojeda wrote:
> The naked attribute is supported by at least gcc >= 4.6 (for ARM,
> which is the only current user), gcc >= 8 (for x86), clang >= 3.1
> and icc >= 13. See https://godbolt.org/z/350Dyc
> 
> Therefore, move it out of compiler-gcc.h so that the definition
> is shared by all compilers.
> 
> This also fixes Clang support for ARM32 --- 815f0ddb346c
> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

So, with this applied, does clang really build an arm32 kernel
successfully?  No other problem at all?  And this isn't really a
regression, arm32 never really worked with clang yet, right?

thanks,

greg k-h
