From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compiler.h, sparse, smatch: Do not define
 COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
Date: Sat, 7 Jul 2018 11:49:38 +0200
Message-ID: <20180707094935.u24pc47jxezpeuiy@ltop.local>
References: <20180705155726.26716-1-bart.vanassche@wdc.com>
 <20180706173120.4pg5wwtuqggl6sah@ltop.local>
 <e18b8d7326e41cb858ce1e892664489f8aba995b.camel@wdc.com>
 <20180706224600.cerzr5p5yyorqttw@ltop.local>
 <279ce5d2df9ecd195d595933792c12cf6d943444.camel@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <279ce5d2df9ecd195d595933792c12cf6d943444.camel@wdc.com>
Sender: stable-owner@vger.kernel.org
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "keescook@chromium.org" <keescook@chromium.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "sparse@chrisli.org" <sparse@chrisli.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Jul 06, 2018 at 10:53:08PM +0000, Bart Van Assche wrote:
> On Sat, 2018-07-07 at 00:46 +0200, Luc Van Oostenryck wrote:
> > 1) it lacks some essential patches to avoid tons of useless noises,
> >    like for example the patch:
> > 	https://patchwork.kernel.org/patch/10334355/
> 
> Hello Luc,
> 
> To suppress the sizeof(void) warnings I sent the following patch to Linus:
> "[PATCH] kernel.h: Avoid that sparse complains about using sizeof(void)"
> (https://lore.kernel.org/lkml/20180705161709.17028-1-bart.vanassche@wdc.com/).
> Please advise how to proceed with that patch.

The problems I have with this patch are:
1) it increases the difference between the code as seen by sparse
   and the one seen by GCC. It's fine as temporary band-aid but this
   kind of patches tend to stay forever.
2) it shouldn't really be needed because someone, Joey Pabalinas,
   has already, several months ago, done what is needed on sparse's
   side to suppress this warning as soon as it became a problem.

Of course, the real solution would be to keep the maintenance pace
of sparse's official better in synch with the kernel development
Meanwhile, I understand very well the need of your patch.

-- Luc Van Oostenryck
