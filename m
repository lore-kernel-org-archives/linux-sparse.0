From: Tomas Winkler <tomasw@gmail.com>
Subject: Re: Arrays of variable length
Date: Thu, 9 Mar 2017 16:21:26 +0200
Message-ID: <CA+i0qc4VOXbHBSbhTOGEZ6D04X-tQsMmtAoj8JtzEf6TCOm=Pg@mail.gmail.com>
References: <CA+i0qc5_NFqb=_6P46yrebrQYzSuCCKgq_xyeui_x6nTRGx62A@mail.gmail.com>
 <yw1xlgsjdcjk.fsf@unicorn.mansr.com> <20170305211254.GA3220@khazad-dum.debian.net>
 <yw1xh937ckl4.fsf@unicorn.mansr.com> <CA+i0qc6+m61dz-Bj95355ZmpPqKW8-RrWFRswTaajx5_fEOg0A@mail.gmail.com>
 <yw1xk27ybo30.fsf@unicorn.mansr.com> <CA+i0qc4iwENN0HyG2--suhgc3_Q=RpFt0tFNgCqWQvALqot4dA@mail.gmail.com>
 <yw1xfuimbkml.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33528 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbdCIOW5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Mar 2017 09:22:57 -0500
In-Reply-To: <yw1xfuimbkml.fsf@unicorn.mansr.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Mar 9, 2017 at 4:16 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wr=
ote:
> Tomas Winkler <tomasw@gmail.com> writes:
>
>> On Thu, Mar 9, 2017 at 3:02 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com>=
 wrote:
>>> Tomas Winkler <tomasw@gmail.com> writes:
>>>
>>>> On Mon, Mar 6, 2017 at 2:31 AM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
>>>>> Henrique de Moraes Holschuh <hmh@hmh.eng.br> writes:
>>>>>
>>>>>> On Sun, 05 Mar 2017, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>>> Tomas Winkler <tomasw@gmail.com> writes:
>>>>>>> > Sparse complains for arrays declared with variable length
>>>>>>> >
>>>>>>> > 'warning: Variable length array is used'
>>>>>>> >
>>>>>>> > Prior to c99 this was not allowed but lgcc (c99) doesn't have pro=
blem
>>>>>>> > with that  https://gcc.gnu.org/onlinedocs/gcc/Variable-Length.htm=
l.
>>>>>>> > And also Linux kernel compilation with W=3D1 doesn't complain.
>>>>>>> >
>>>>>>> > Since sparse is used extensively would like to ask what is the co=
rrect
>>>>>>> > usage of arrays of variable length
>>>>>>> > within Linux Kernel.
>>>>>>>
>>>>>>> Variable-length arrays are a very bad idea.  Don't use them, ever.
>>>>>>> If the size has a sane upper bound, just use that value statically.
>>>>>>> Otherwise, you have a stack overflow waiting to happen and should b=
e
>>>>>>> using some kind of dynamic allocation instead.
>>>>>>>
>>>>>>> Furthermore, use of VLAs generally results in less efficient code. =
 For
>>>>>>> instance, it forces gcc to waste a register for the frame pointer, =
and
>>>>>>> it often prevents inlining.
>>>>>>
>>>>>> Well, if we're going to forbid VLAs in the kernel, IMHO the kernel b=
uild
>>>>>> system should call gcc with -Werror=3Dvla to get that point across e=
arly,
>>>>>> and flush out any offenders.
>>>>>
>>>>> If it were up to me, that's exactly what I'd do.
>>>>
>>>>>
>>>> Some parts of the kernel depends on VLA such as ___ON_STACK macros in
>>>> include/crypto/hash.h
>>>> It's actually pretty neat implementation, maybe it's too harsh to
>>>> disable  VLA completely.
>>>
>>> And what happens if the requested size is insane?
>>
>> One option is to add '-Wvla-larger-than=3Dn'
>
> If you know the upper bound, why use VLAs in the first place?

This is a water mark and not  actual usage, but maybe I didn't
understand your comment.

Tomas
