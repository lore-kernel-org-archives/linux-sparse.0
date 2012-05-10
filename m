From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] simplify: conservative handling of casts with pointers
Date: Thu, 10 May 2012 03:42:59 -0700
Message-ID: <CANeU7QkxsdXw8q-Nw09EEhzjm=vL9NePcPyB9nLRHRF56dsyLg@mail.gmail.com>
References: <4FA92A18.1090208@seznam.cz>
	<4FAA4E4A.8000409@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34240 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758405Ab2EJKnA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 06:43:00 -0400
Received: by yenm10 with SMTP id m10so1289406yen.19
        for <linux-sparse@vger.kernel.org>; Thu, 10 May 2012 03:42:59 -0700 (PDT)
In-Reply-To: <4FAA4E4A.8000409@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 9, 2012 at 4:00 AM, Jan Pokorn=FD <pokorny_jan@seznam.cz> w=
rote:
> On 05/08/2012 04:13 PM, Jan Pokorn=FD wrote:
>> When the cast is optimized out/target pointer type information lost,
>> it may be impossible for backend to recover it (think of
>> "struct foo *my_new_foo =3D malloc(sizeof(*my_new_foo))").
>>
>> Losing such pointer type information can be wider issue (structs and
>> unions maybe), but this is the most exposed one and the patch tries
>> to be minimal in this regard and the impact seems to be minimal
>> too as usually type-correctness is followed.
>
> I expected that if both operands of the cast appear to be pointers, i=
t is
> always OP_PTRCAST case, which is not true.
>
> So this version exchanges inequality test for "or". =A0Beside being
> shorter, it covers such previously missed cases.
>
> Based on asserts I experimented with, OP_PTRCASTs are always captured
> by the condition implicitly (beside OP_CASTs with pointer-like operan=
ds).

The early sparse back end does not care about preserve the
ctype in the back end. The type has been simplify to bit size.
So the pointer type conversion which has the same bit size,
it does not need to generate any back end machine code
e.g. x86 instruction to perform the conversion. I think that
is why it is skipped.

The recent changes, especially the llvm back end care more
about preserving the ctype in the back end instruction level.

The patch is applied.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
