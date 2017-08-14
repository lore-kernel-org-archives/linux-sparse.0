From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Bad linearized output in RC5
Date: Mon, 14 Aug 2017 15:23:20 +0100
Message-ID: <CACXZuxfkYrXzY5y5exRM3=7e4zq8+-Fetf3nGvFwuNk6Zmhd2g@mail.gmail.com>
References: <CACXZuxf=pO2pXmJoTtWvO2d7HCzpyfCWOqc4EJ7fBjyh7fdsWw@mail.gmail.com>
 <CANeU7Q=jzYvCHhp=oFShz09z3i7qzDx3=Hkdc-t+zUwuyegbFQ@mail.gmail.com> <CACXZuxckLUsHx0zp6rvcoSUpx_4BMKOBU3Lzzw8_Tu7knbHUbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34661 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdHNOXV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 10:23:21 -0400
Received: by mail-vk0-f46.google.com with SMTP id n125so31984715vke.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 07:23:21 -0700 (PDT)
In-Reply-To: <CACXZuxckLUsHx0zp6rvcoSUpx_4BMKOBU3Lzzw8_Tu7knbHUbw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On 14 August 2017 at 15:22, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 14 August 2017 at 15:05, Christopher Li <sparse@chrisli.org> wrote:
>> On Mon, Aug 14, 2017 at 3:28 AM, Dibyendu Majumdar
>> <mobile@majumdar.org.uk> wrote:
>>> lua_settop:
>>> .L0:
>>>         <entry-point>
>>>         setge.32    %r2 <- %arg2, $0
>>>         cbr         %r2, .L6, .L2
>>>
>>> .L6:
>>>         load.64     %r5 <- 0[VOID]
>>>         load.64     %r7 <- 8[VOID] <===========
>>
>> Thanks for the report.
>>
>> So you mean here the arg1 has been optimized to void.
>>
>> I am able to duplicate this problem with rc5.
>
> That is strange as the output is from test-linearize from rc5.
>

Ah apologies I thought you meant you were not able to reproduce.

Regards
