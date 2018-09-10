From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Date: Mon, 10 Sep 2018 17:15:27 +0200
Message-ID: <20180910151526.ljp3nynngprdmlkb@ltop.local>
References: <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
 <20180910113448.dxnfvznyimtj3tkv@ltop.local>
 <9409138a-dc14-2b12-edc0-cfa0b471da6e@c-s.fr>
 <20180910135604.j2phe7r3k5vs6cik@ltop.local>
 <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, sparse@chrisli.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Sep 10, 2018 at 04:05:34PM +0200, Christophe LEROY wrote:
> 
> This time it works, thanks for your help.

You're welcome.
 
> Should we find a may to automate that in the Makefile when
> CROSS_COMPILE is defined ?

The situation here with an old gcc is really an oddity.
I was instead thinking to update sparse so that it repports a
GCC version of at least 4.6, maybe something even more recent.

But maybe, yes, kbuild could pass GCC_VERSION to sparse so
that both the compiler used and sparse will repport the same.
I'll see. The problem is not tied to cross-compilation, though,
just that sparse may be compiled with an older compiler.

-- Luc
