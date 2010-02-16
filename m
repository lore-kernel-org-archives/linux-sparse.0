From: Christopher Li <sparse@chrisli.org>
Subject: Re: Defect in linearization of short circuit &&
Date: Tue, 16 Feb 2010 11:02:40 -0800
Message-ID: <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
	 <4B79AC03.4010608@googlemail.com>
	 <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
	 <1266312482.3433.33.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:14426 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab0BPTCm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 14:02:42 -0500
Received: by qw-out-2122.google.com with SMTP id 5so815343qwi.37
        for <linux-sparse@vger.kernel.org>; Tue, 16 Feb 2010 11:02:41 -0800 (PST)
In-Reply-To: <1266312482.3433.33.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: =?ISO-8859-2?Q?Jacek_=A6liwerski?= <sliwers@googlemail.com>, linux-sparse@vger.kernel.org

On Tue, Feb 16, 2010 at 1:28 AM, Bernd Petrovitsch
<bernd@petrovitsch.priv.at> wrote:
>> $ ./test-linearize parser_check.c
>> parser_check:
>> .L0x7f4e12de3130:
>> =A0 =A0 =A0 <entry-point>
>> =A0 =A0 =A0 br =A0 =A0 =A0 =A0 =A0%arg1, .L0x7f4e12de32e0, .L0x7f4e1=
2de3250
> I assume this means "if %arg1 =3D=3D NULL goto .L0x7f4e12de32e0 else =
goto .L0x7f4e12de3250"

That is right.

> I assume this is the "i > 0" check.

No, this is the not the i > 0 check yet. This is setting the expression=
 value
of the false branch to 0.

>> =A0 =A0 =A0 phisrc.1 =A0 =A0%phi2 <- $0
>> =A0 =A0 =A0 br =A0 =A0 =A0 =A0 =A0.L0x7f4e12de3298
>>
>> .L0x7f4e12de3298:
>> =A0 =A0 =A0 phi.1 =A0 =A0 =A0 %r8 <- %phi1, %phi2
>> =A0 =A0 =A0 setgt.32 =A0 =A0%r10 <- %arg2, $0

This is the "i > 0" check. (%arg2 is "i")

>> =A0 =A0 =A0 and-bool.1 =A0%r11 <- %r8, %r10
>> =A0 =A0 =A0 br =A0 =A0 =A0 =A0 =A0%r11, .L0x7f4e12de3178, .L0x7f4e12=
de31c0
>>
>> .L0x7f4e12de3178:
>> =A0 =A0 =A0 call =A0 =A0 =A0 =A0execute_a, %arg1, %arg2
>> =A0 =A0 =A0 br =A0 =A0 =A0 =A0 =A0.L0x7f4e12de3328
>>
>> In the fast test, the false branch is L0x7f4e12de3250.
>> Which is doing the (i > 0) part and it is safe to do so.

> Are saying that he "i >0 " test done while "st =3D=3D NULL"?
> This is actually wrong as it shouldn't be done (independent of the us=
ed
> variables and especially if the expression has side effects).

That is right. "i > 0" is still being tested.

Consider this example. The same source code and be compile into two
different piece of machine code. They produce the exact same result.
The one with this optimization runs faster than the other one. Do you s=
till
thing that is wrong? How about x86 CPU internally re-ordering the instr=
uction,
is that wrong too?

So I think as long as this behavior is *internal* and *correct*. It is =
fine.
Of course it'd better be faster as well. Otherwise, what is the point.

The goal of the this optimization is trading the branch instruction
with cheaper arithmetic instruction.

=46or modern CPU, the branch instruction is likely more expensive
than normal arithmetic instruction. In X86, branch instruction *might*
flush the instruction pipe line while arithmetic operation can usually =
done
in one cycle.

That is why this optimization is using a cost model. If the left hand
side cost is lower than the branch instruction cost, and it is *safe* t=
o
do so. It turn the branch instruction into arithmetic instruction.

However, in this case, the optimization did not consider this expressio=
n
is used in the if statement, and if statement has build-in branch instr=
uction
associate with it. So this optimization might not worthy while here.

But for this expression:

a =3D st && st->foo && st->bar && i > 0;

This optimization might be worth while.

If the optimization produce incorrect result. That is fatal and that
is a serious bug.
I just want to confirm that is no the case here.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
