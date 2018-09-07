From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Date: Fri, 7 Sep 2018 20:37:53 +0200
Message-ID: <20180907183751.zozqbmpq3dm4j3tw@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: christophe.leroy@c-s.fr, joe@perches.com, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, sparse@chrisli.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 07, 2018 at 11:19:43AM -0700, Nick Desaulniers wrote:
> On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck wrote:
> >
> > Sparse expand these macros to the same version than the compiler used
> > to compile GCC. I find a bit strange though to have sparse v0.5.2 but
> > using an old compiler.
> 
> So Christophe must have a version of gcc < 4.6 installed somewhere?

It looks so.

> Does sparse use `cc`?

By default sparse use gcc (this can be overriden by using CC=...).

-- Luc
