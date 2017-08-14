From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Bad linearized output in RC5
Date: Mon, 14 Aug 2017 15:22:33 +0100
Message-ID: <CACXZuxckLUsHx0zp6rvcoSUpx_4BMKOBU3Lzzw8_Tu7knbHUbw@mail.gmail.com>
References: <CACXZuxf=pO2pXmJoTtWvO2d7HCzpyfCWOqc4EJ7fBjyh7fdsWw@mail.gmail.com>
 <CANeU7Q=jzYvCHhp=oFShz09z3i7qzDx3=Hkdc-t+zUwuyegbFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34414 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdHNOWe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 10:22:34 -0400
Received: by mail-ua0-f176.google.com with SMTP id q25so37180195uah.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 07:22:34 -0700 (PDT)
In-Reply-To: <CANeU7Q=jzYvCHhp=oFShz09z3i7qzDx3=Hkdc-t+zUwuyegbFQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hi Chris,

On 14 August 2017 at 15:05, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 14, 2017 at 3:28 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> lua_settop:
>> .L0:
>>         <entry-point>
>>         setge.32    %r2 <- %arg2, $0
>>         cbr         %r2, .L6, .L2
>>
>> .L6:
>>         load.64     %r5 <- 0[VOID]
>>         load.64     %r7 <- 8[VOID] <===========
>
> Thanks for the report.
>
> So you mean here the arg1 has been optimized to void.
>
> I am able to duplicate this problem with rc5.

That is strange as the output is from test-linearize from rc5.


> Haven't have time to dig deeper. But it seems before
> the optimization,  the first round of linearization
> has the output that arg1 was still there.
>
> Regard to this release.  I don't think we have time to
> make all the IR correct for RC5.
>
> I suggest we make the 0.5.1 release this week.
>
> Then immediate start to work on 0.5.2, make the
> necessary fix there, then we can have RC1 for 0.5.2.
>

Yes I agree that there is no need to hold the release up as most
likely this is an existing issue.

Regards
Dibyendu
