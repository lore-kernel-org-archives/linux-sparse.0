From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 23:22:50 +0100
Message-ID: <CACXZuxc55Kjm=GRRaLJZ9CfvkcmukynsM3crSPax+My-WrGo1w@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36506 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdC1WW6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 18:22:58 -0400
Received: by mail-it0-f54.google.com with SMTP id e75so73082814itd.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 15:22:52 -0700 (PDT)
In-Reply-To: <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Linus,

On 28 March 2017 at 17:20, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Mar 28, 2017 at 7:19 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Well the unsimplified output is correct. The problem appears after
>> simplification.
>
> No. The unsimplified output has the exact same bug:
>
>   main:
>   .L0:
>         <entry-point>
>         load.32     %r1 <- 0[s3]
>         shl.32      %r2 <- $1, $6
>         and.32      %r3 <- %r1, $-65
>
> That "load.32" loads an uninitialized value from the stack.
>
> The simplification then just simplifies the uninitialized load to just
> be an uninitialized pseudo instead. Exact same code.
>
> And arguably both unsimplified and simplified code is "correct" in the
> sense that it's exactly what the original source code does:
>
>    s3.onebit = 1;
>

I think that the unsimplified output is correct in that it is doing
what the C code says. Because if you look at the C code, the code is
only accessing a field that has been initialized prior to access - so
I do not think this counts as undefined behaviour. I am unable to find
the wording in the C standard that would make this clear one way or
another, but my reading of the standard is that the C code is legal.

I understand that to the simplification phase the first load looks
like load of undefined value - but that is not the semantic of the C
code that led to it.

I checked that clang generates the same sequence of instructions as
sparse when optimization is switched off - but turning on optimization
gets rid of all the code except for the return.

Thanks and Regards
Dibyendu
