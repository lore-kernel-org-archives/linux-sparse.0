From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Date: Mon, 10 Sep 2018 11:28:36 +0200
Message-ID: <20180910092835.v5nex5nzfgtl475m@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, sparse@chrisli.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Sep 10, 2018 at 08:49:07AM +0200, Christophe LEROY wrote:
> Le 07/09/2018 à 20:19, Nick Desaulniers a écrit :
> > On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck wrote:
> > > 
> > > Sparse expand these macros to the same version than the compiler used
> > > to compile GCC. I find a bit strange though to have sparse v0.5.2 but
> > > using an old compiler.
> > 
> > So Christophe must have a version of gcc < 4.6 installed somewhere?
> > Does sparse use `cc`? If so, Christophe, does your `ls -l $(which cc)`
> > point to an old version of gcc maybe?
> 
> Indeed it looks like sparse expand these macros to the version of
> the compiler it was compiled with.
> 
> I'm building kernels for a powerpc platforms, with CROSS_COMPILE set
> to ppc-linux- and ppc-linux-gcc being version 5.4
> 
> However my build machine is a CentOS6 and the native gcc has version
> 4.4.7, so sparse expands that version.

OK, I see.
 
> Is there a way to get sparse in line with my cross compiler version
> and not with the local native version ?

When cross-compiling, there is also things like the machine word-size
and the endianness to take in account (they also default to the
native compiler used to compile sparse itself) as well as a few
defines (like __PPC64__). To be in line with your cross-compiler
you can use to the wrapper 'cgcc' (installed with sparse) and call
it, for example, like this:
	$ export REAL_CC=ppc-linux-gcc
	$ cgcc -target=ppcc64 -D_CALL_ELF=2 -D__GCC__=5 -D__GCC_MINOR__=4 ...
or, since this is for the kernel:
	$ export REAL_CC=ppc-linux-gcc
	$ make CHECK='cgcc -target=ppcc64 ...


I think this should solve it. Do not hesitate to report any
difficulties you may encounter.

-- Luc
