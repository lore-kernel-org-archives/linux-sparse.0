From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 21:09:17 +0100
Message-ID: <20170302200916.4agmd5jihtkzyvp5@macpro.local>
References: <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
 <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
 <20170302171842.xuk535w6wrfxke3b@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34656 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdCBUJp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 15:09:45 -0500
Received: by mail-wr0-f181.google.com with SMTP id l37so60537575wrc.1
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 12:09:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170302171842.xuk535w6wrfxke3b@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 06:18:43PM +0100, Luc Van Oostenryck wrote:
> > > Here is the output from linearize. I think the way stores and loads
> > > are handled is broken. It appears that the last store / load
> > > instruction is stored in insn->target->priv, and then used later on
> > > ... I do not understand what the code is trying to do. Is it trying to
> > > optimize away stores and loads?
> 
> No, no.
> What is stored in ->priv is the target's  LLVMValueRef (and for a store
> the 'target' is what need to be stored).
> And indeed there is a bug there: it's target_in that should be stored in
> ->priv (in fact, for a store, there is no need to put anything at all
> in this field; at least I don't see any reason why it should).
> Nice catch.
> I don't know how it's related to your problem though.

OK, I've just checked and indeed removing this assignment to ->priv
in output_op_store() was wrong and is most probably very related to
your problem. I used something as simple as:
	void foo(int *p, int a, int b)
	{
		int c = a + b;
	
		p[0] = c;
		p[1] = c;
	}

Which returned:
	Stored value type does not match pointer operand type!
	  store void <badref>, i32* %8

And with this assignment removed this error is no more and the
generated LLVM IR is:
	define void @foo(i32*, i32, i32) {
	  %R3 = add i32 %1, %2
	  %3 = bitcast i32* %0 to i8*
	  %4 = getelementptr inbounds i8, i8* %3, i64 0
	  %5 = bitcast i8* %4 to i32*
	  store i32 %R3, i32* %5
	  %6 = bitcast i32* %0 to i8*
	  %7 = getelementptr inbounds i8, i8* %6, i64 4
	  %8 = bitcast i8* %7 to i32*
	  store i32 %R3, i32* %8
	  ret void
	}

And the generated x86 code is:
	addl	%edx, %esi
	movl	%esi, (%rdi)
	movl	%esi, 0x4(%rdi)
	retq


Luc Van Oostenryck
