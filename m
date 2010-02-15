From: Christopher Li <sparse@chrisli.org>
Subject: Re: Defect in linearization of short circuit &&
Date: Mon, 15 Feb 2010 13:11:39 -0800
Message-ID: <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
	 <4B79AC03.4010608@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f200.google.com ([209.85.221.200]:48349 "EHLO
	mail-qy0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab0BOVLm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Feb 2010 16:11:42 -0500
Received: by qyk38 with SMTP id 38so714357qyk.1
        for <linux-sparse@vger.kernel.org>; Mon, 15 Feb 2010 13:11:41 -0800 (PST)
In-Reply-To: <4B79AC03.4010608@googlemail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-2?Q?Jacek_=A6liwerski?= <sliwers@googlemail.com>
Cc: linux-sparse@vger.kernel.org

2010/2/15 Jacek =C5=9Aliwerski <sliwers@googlemail.com>:
>
> Please, check my case. =C2=A0The condition is:

I did, I did not see any thing wrong with it.

>
> if (st && st->other && st->value > i && i > 0)...
>
> Obviously, if st is NULL, then the execution should be transferred
> immediately to the else branch. =C2=A0But it does not. =C2=A0It skips=
 the second test
> and goes directly to the third one: st->value > i. =C2=A0If a compile=
r was built
> with sparse as a frontend, execution of the generated code would end =
up with
> a segmentation fault. =C2=A0And this code is perfectly valid.

I totally agree the source code is valid.
I just haven't see the seg fault part.

$ ./test-linearize parser_check.c
parser_check:
=2EL0x7f4e12de3130:
	<entry-point>
	br          %arg1, .L0x7f4e12de32e0, .L0x7f4e12de3250

=2EL0x7f4e12de32e0:
	load.32     %r3 <- 4[%arg1]
	br          %r3, .L0x7f4e12de3208, .L0x7f4e12de3250

=2EL0x7f4e12de3208:
	load.32     %r5 <- 0[%arg1]
	setgt.32    %r7 <- %r5, %arg2
	phisrc.1    %phi1 <- %r7
	br          .L0x7f4e12de3298

=2EL0x7f4e12de3250:
	phisrc.1    %phi2 <- $0
	br          .L0x7f4e12de3298

=2EL0x7f4e12de3298:
	phi.1       %r8 <- %phi1, %phi2
	setgt.32    %r10 <- %arg2, $0
	and-bool.1  %r11 <- %r8, %r10
	br          %r11, .L0x7f4e12de3178, .L0x7f4e12de31c0

=2EL0x7f4e12de3178:
	call        execute_a, %arg1, %arg2
	br          .L0x7f4e12de3328

=2EL0x7f4e12de31c0:
	call        execute_b, %arg1
	br          .L0x7f4e12de3328

=2EL0x7f4e12de3328:
	ret

In the fast test, the false branch is L0x7f4e12de3250.
Which is doing the (i > 0) part and it is safe to do so.

It skip the two load.32 operation. It will not generate the seg fault.
I still don't see where the is seg fault part. Please let me know if I =
am
missing some thing obvious.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
