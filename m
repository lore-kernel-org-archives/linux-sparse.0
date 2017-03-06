From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Mon, 6 Mar 2017 21:09:57 +0100
Message-ID: <20170306200956.s6wqxw2mfk2lgjlu@macpro.local>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com>
 <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
 <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com>
 <20170306164306.hibukuy2t4j4camh@macpro.local>
 <CA+55aFx=R=Z2jrTQhT2o4oA-it+sQjKT097zMgPhgKFp0byPFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34142 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbdCFUKg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 15:10:36 -0500
Received: by mail-wr0-f181.google.com with SMTP id l37so124956787wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 12:10:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFx=R=Z2jrTQhT2o4oA-it+sQjKT097zMgPhgKFp0byPFw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 06, 2017 at 10:17:35AM -0800, Linus Torvalds wrote:
> On Mon, Mar 6, 2017 at 8:43 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > With an example:
> > == C code ==
> >         void *foo(int *p) { return p + 5; }
> >
> > == linearized code ==
> >         foo:
> >         .L0:
> >                 <entry-point>
> >                 add.64      %r2 <- %arg1, $20
> >                 cast.64     %r3 <- (64) %r2
> >                 ret.64      %r3
> 
> This is correct.

Interestingly, the following code is linearized a bit differently:
== C code ==
	void *foo(int *p) { return p += 5; }
== linearized code ==
	foo:
	.L0:
	        <entry-point>
	        cast.64     %r98 <- (64) %arg1
	        add.64      %r99 <- %r98, $20
	        ptrcast.64  %r100 <- (64) %r99
	        cast.64     %r101 <- (64) %r100
	        ret.64      %r101

Where the type of %r98 & %r99 is 'unsigned long' (or more probably size_t).
This is then correctly LLVMized as:
	define i8* @foo(i32* %ARG1) {
	L18:
	  %R98 = ptrtoint i32* %ARG1 to i64
	  %R99 = add i64 %R98, 20
	  %R100 = inttoptr i64 %R99 to i32*
	  %R101 = bitcast i32* %R100 to i8*
	  ret i8* %R101
	}
 
> > == LLVM code from sparse-llvm ==
> >
> >         define i8* @foo(i32* %ARG1) {
> >         L0:
> >           %0 = getelementptr i32, i32* %ARG1, inttoptr (i64 20 to i32*)
> >           %R3 = bitcast i32* %0 to i8*
> 
> This is garbage, I'm afraid.
> 
> When sparse does the "add 20 to pointer", it adds the *byte offset* 20
> to the pointer. The LLVM module should not use "getelementptr" for
> this, because it's not element #20, it's the element at offset 20.

It's clear that there is a semantic gap between sparse's & LLVM's IR.

> I think you're supposed to either use "uglygep" with the base pointer
> cast to a simple address-unit pointer (ie unsigned char).
> 
> Or not use GEP at all.
> 
>                 Linus

I bet we'll have others problems with GEP.

Luc
