From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Tue, 28 Apr 2009 15:59:34 -0700
Message-ID: <70318cbf0904281559u1e8ea134r36282e1e0132fb7a@mail.gmail.com>
References: <20090426205806.GA20933@havoc.gtf.org>
	 <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>
	 <49F6342B.30605@garzik.org>
	 <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>
	 <49F64E9A.2030009@garzik.org>
	 <70318cbf0904271804i4b8a14cbqfa62f521dc7258a3@mail.gmail.com>
	 <49F65A1A.50300@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:49641 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZD1W7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Apr 2009 18:59:36 -0400
Received: by gxk10 with SMTP id 10so1766128gxk.13
        for <linux-sparse@vger.kernel.org>; Tue, 28 Apr 2009 15:59:34 -0700 (PDT)
In-Reply-To: <49F65A1A.50300@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Apr 27, 2009 at 6:21 PM, Jeff Garzik <jeff@garzik.org> wrote:
> You mean, besides the reasons already listed? =A0Namely, no upstream =
changes
> are required, and I already have something that works.
>
> Sure, the same trick can be applied. =A0But that requires a total bac=
kend
> rewrite plus dealing with linearize obstacles already described (ref
> linearize_load_gen, linearize_store_gen). =A0Thus it is obviously a l=
ot more
> work, with additional obstacles (patching upstream, which affects exi=
sting
> users), just get back to achieving the same result :)

I take a look at the how LLVM handle bit fields. Please correct me if
I am wrong.
LLVM does not take bit field member as a type. Given the example:

struct s {
   int a:3;
   int b:3;
} foo;

void func (struct s *a)
{
   a->a =3D 6;
}

The LLVM outputs:

target datalayout =3D
"e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64=
:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple =3D "i386-pc-linux-gnu"
	%struct.s =3D type <{ i8, [3 x i8] }>
@foo =3D common global %struct.s zeroinitializer, align 4		;
<%struct.s*> [#uses=3D0]

define void @func(%struct.s* nocapture %a) nounwind {
entry:
	%0 =3D getelementptr %struct.s* %a, i32 0, i32 0		; <i8*> [#uses=3D2]
	%1 =3D load i8* %0, align 1		; <i8> [#uses=3D1]
	%2 =3D or i8 %1, 6		; <i8> [#uses=3D1]
	%3 =3D and i8 %2, -2		; <i8> [#uses=3D1]
	store i8 %3, i8* %0, align 1
	ret void
}

LLVM does not treat bit field as first class types. It apply bit mask
before/after
the load/store to fix things up. It actually is the same reason
linearize_load_gen
and linearize_store_gen exists in the first place. It does the same thi=
ng.

So the so call "obstacles" are actually what you need to handle bit
field correctly.
If you use linearized instruction in the first place, you would
already have bit field handle
correctly.

Let's review why you insist on duplicating the lineariztion effort.

1) You have the code already working.
    True. But a back end base on linearize instruction will be much
    simpler to your existing code. It does not make sense to have two
    linearization implementation while they can share one.

2) Require up stream changes.
    Let's compare apple to apple. Using linearize instruction to genera=
te
    a output exactly as your V2 does not require up stream changes.
    It is not a reason to pick one over another.

3) Obstacles in linearize_load_gen and linearize_store_gen.
   It turns out those "obstacles" are exactly what you need to handle
   bit fields. One more reason to use linearize instructions.

4) More work to get the same results.
   It will be more work for *you* to write yet another back end.
   But if you compare the end result. The one base on linearize instruc=
tion
   will be much simpler. It will be less new code get check in to the s=
parse
   tree, less code for people other than you to review. Less work to ma=
intain
   one implementation of linearization instead of two.

Still not convinced using the linearization is a better way to go?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
