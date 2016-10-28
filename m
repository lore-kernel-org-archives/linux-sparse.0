From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: NiosII GCC Compiler Built-Ins Question
Date: Fri, 28 Oct 2016 15:57:14 -0500
Message-ID: <593696ca-67e3-6d71-befe-eac23bdca3b7@opensource.altera.com>
References: <2a743451-2dda-a16c-6eec-a43e223c5c53@opensource.altera.com>
 <CANeU7Q=8Dk_R_auTPpZ72OnfPJVsHGd92O+uXpO9phQWpV=BwA@mail.gmail.com>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:1088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933956AbcJ1VYz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 28 Oct 2016 17:24:55 -0400
In-Reply-To: <CANeU7Q=8Dk_R_auTPpZ72OnfPJVsHGd92O+uXpO9phQWpV=BwA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 10/28/2016 09:46 AM, Christopher Li wrote:
> On Fri, Oct 28, 2016 at 10:21 PM, Thor Thayer
> <tthayer@opensource.altera.com> wrote:
>> Hi,
>>
>> When I'm running sparse on my NiosII Linux build, I'm seeing many errors
>> concerning an undefined identifier which is actually a GCC built-in for the
>> NiosII architecture [1].
>>
>> ./arch/nios2/include/asm/irqflags.h:34:9: error: not a function <noident>
>>
>> Googling this error led me to 2 possible solutions.
>> 1. Comment it out in the Linux source [2].
>
> That is not the way to go.
>
>> 2. Additions in the sparse lib.c file [3].
>
> How about add the prototype in sparse and protect it by
> #ifdef condition. Then sparse still need to have some way to
> introduce the architecture flags. Maybe the default will pick the
> host architecture and allow command options to overwrite the
> architectures. If gcc has similar architecture options we should
> reuse those in sparse.
>
> I am open to other suggestion as well.
>

I'm assuming this would look like the "#ifdef __bfin__\n" section of 
lib.c (line 863).

I'm having trouble finding what the arch define is for nios2 (the 
obvious __nios2__ doesn't work for me) but I'll keep digging.

Thanks for the response and guidance!

Thor

> Chris
>
