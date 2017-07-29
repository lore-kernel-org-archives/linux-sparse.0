From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] pre-process: replace use of vla's with heap allocation
Date: Sat, 29 Jul 2017 15:17:06 +0200
Message-ID: <CAExDi1S_mQRHQmAOOhdctbJOgLCo0pArXO6_QKY2WaNMsb9Y0Q@mail.gmail.com>
References: <5ffb141e-fdb2-a1b8-a5b7-c922d1a9ef08@ramsayjones.plus.com>
 <CANeU7QkmtVVPhhanR2M7=3P9cCse0B9rXJSfx8c1NCC4aHZ-qw@mail.gmail.com> <cce05c3f-a309-9fa7-3107-e6e6831972aa@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34235 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbdG2NRI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 09:17:08 -0400
Received: by mail-qk0-f193.google.com with SMTP id q66so23264799qki.1
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 06:17:07 -0700 (PDT)
In-Reply-To: <cce05c3f-a309-9fa7-3107-e6e6831972aa@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Jul 20, 2017 at 6:44 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 20/07/17 13:02, Christopher Li wrote:
>> On Wed, Jul 19, 2017 at 4:13 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>>
>>> The 'selfcheck' make target issues warnings about using vla's in the
>>> pre-processor code, like so:
>>>
>>>        CHECK    pre-process.c
>>>   pre-process.c:712:25: warning: Variable length array is used.
>>>   pre-process.c:2019:28: warning: Variable length array is used.
>>>
>>> A Makefile change to pass '-Wno-vla' to sparse when processing this
>>> source file (or all source files) may be a better solution than the
>>> one given here.
>>>
>>> Replace the use of vla's with heap allocation. This has performance
>>> implications (although it may me safer), due to the dynamic memory
>>> allocation and the zero initialisation of the memory (using calloc).
>>> I have not done any timing measurements to see if this is a problem
>>> in practice.
>>
>> I purpose the following patch. Make the expand using stack for small
>> argument numbers. That should not have much performance impact
>> at all because long macro arguments are rare.
>
> My first reaction was surprise that you didn't go for the Makefile
> idea - setting '-Wno-vla' would be the simplest solution. ;-)
>
> I can understand warning about vla usage (especially in the kernel),
> but it a 'standard' supported feature. I don't use them myself, partly
> because they are a 'relatively' new feature, but also because I have had
> some bad experience in the past using alloca in similar circumstances.

I second this opinion.
In the kernel, stacks are quite small and it's very natural to:
- limit stack use to the minimal
- control stack usage
and so VLAs are avoided (but not banned).
But in userspace this limit doesn't exist so why make the code
more complicated?

> My second thought was, have you done some timing tests (no I haven't)
> and determined that this causes a noticeable slowdown?

Also, this is not IMO -rc4+ material.

-- Luc
