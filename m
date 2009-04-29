From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Wed, 29 Apr 2009 18:25:13 -0400
Message-ID: <49F8D3C9.6060404@garzik.org>
References: <20090426205806.GA20933@havoc.gtf.org>	 <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>	 <49F6342B.30605@garzik.org>	 <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>	 <49F64E9A.2030009@garzik.org>	 <70318cbf0904271804i4b8a14cbqfa62f521dc7258a3@mail.gmail.com>	 <49F65A1A.50300@garzik.org> <70318cbf0904281559u1e8ea134r36282e1e0132fb7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57569 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761645AbZD2WZR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Apr 2009 18:25:17 -0400
In-Reply-To: <70318cbf0904281559u1e8ea134r36282e1e0132fb7a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Christopher Li wrote:
> On Mon, Apr 27, 2009 at 6:21 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> You mean, besides the reasons already listed?  Namely, no upstream changes
>> are required, and I already have something that works.
>>
>> Sure, the same trick can be applied.  But that requires a total backend
>> rewrite plus dealing with linearize obstacles already described (ref
>> linearize_load_gen, linearize_store_gen).  Thus it is obviously a lot more
>> work, with additional obstacles (patching upstream, which affects existing
>> users), just get back to achieving the same result :)
> 
> I take a look at the how LLVM handle bit fields. Please correct me if
> I am wrong.
> LLVM does not take bit field member as a type. Given the example:
> 
> struct s {
>    int a:3;
>    int b:3;
> } foo;
> 
> void func (struct s *a)
> {
>    a->a = 6;
> }
> 
> The LLVM outputs:
> 
> target datalayout =
> "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
> target triple = "i386-pc-linux-gnu"
> 	%struct.s = type <{ i8, [3 x i8] }>
> @foo = common global %struct.s zeroinitializer, align 4		;
> <%struct.s*> [#uses=0]
> 
> define void @func(%struct.s* nocapture %a) nounwind {
> entry:
> 	%0 = getelementptr %struct.s* %a, i32 0, i32 0		; <i8*> [#uses=2]
> 	%1 = load i8* %0, align 1		; <i8> [#uses=1]
> 	%2 = or i8 %1, 6		; <i8> [#uses=1]
> 	%3 = and i8 %2, -2		; <i8> [#uses=1]
> 	store i8 %3, i8* %0, align 1
> 	ret void
> }
> 
> LLVM does not treat bit field as first class types. It apply bit mask
> before/after
> the load/store to fix things up. It actually is the same reason
> linearize_load_gen
> and linearize_store_gen exists in the first place. It does the same thing.

LLVM treats all "i%u" types: i1, i11, i16, i32, i64, etc. as first class 
types.  See http://www.llvm.org/docs/LangRef.html

Therefore, the above is not a fundamental instrinsic of LLVM, but rather 
  how one LLVM _emitter_ -- either llvm-gcc or clang, I assume -- chose 
to handle bitfields.

Big, big difference!

Next, you can see from C99 6.7.2.1 P9, the layout of bit-fields may not 
necessary correspond to ad->bit_offset as linearize_{load,store}_gen assume.

Run "info gcc" and do a search on "bitfield", after reviewing C99 again. 
  linearize hardcodes behavior it should not.



> Let's review why you insist on duplicating the lineariztion effort.
> 
> 1) You have the code already working.
>     True. But a back end base on linearize instruction will be much
>     simpler to your existing code.

This is what we call in the engineering business a "wild-assed guess."

You have obviously not reviewed C99 on bitfields nor looked closely at 
LLVM, so judgement of "will be much simpler" is easily questioned.


> 2) Require up stream changes.
>     Let's compare apple to apple. Using linearize instruction to generate
>     a output exactly as your V2 does not require up stream changes.
>     It is not a reason to pick one over another.

That is a silly comparison, because my LLVM backend is not static at V2. 
It should be self-evident that one looks at future changes needed to 
complete an LLVM backend.


> 3) Obstacles in linearize_load_gen and linearize_store_gen.
>    It turns out those "obstacles" are exactly what you need to handle
>    bit fields. One more reason to use linearize instructions.

False, as shown above.


> 4) More work to get the same results.
>    It will be more work for *you* to write yet another back end.

Yes, and I am doing the work.  For fun.  So this is supremely relevant.

It's amusing how easily you hand-wave away my engineering time :) 
Shades of the kernel...


>    But if you compare the end result. The one base on linearize instruction
>    will be much simpler.

We have no end result to compare.


>    It will be less new code get check in to the sparse
>    tree, less code for people other than you to review. Less work to maintain
>    one implementation of linearization instead of two.

Do you not see the difference between simple tree walking, and forced 
generation of basic blocks and instructions chosen by sparse?  There are 
multiple tree walkers in sparse -- not just linearize.c.


Overall, I think linearized format is too limiting and low level for 
LLVM, and thus chose a different starting point.


I wouldn't mind seeing a single tree walker implementation in sparse, 
but it would be incorrect to assume that linearize.c is a generic tree 
walker.

	Jeff


