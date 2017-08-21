From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 21:02:10 +0200
Message-ID: <CAMHZB6FFO=gdC-i=z5KkHXG+mDrKq5gOiU7=2jQCM=gZ1=uF4A@mail.gmail.com>
References: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
 <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com>
 <CANeU7QkZD4OFjdpTH3Dz5Yq6XMxRvi=+L=G2K5soxFTycDxi_Q@mail.gmail.com>
 <CAMHZB6H9VAT8STaXSuR=waaS3rggky4DE+QRtF6S0vYKWLuRLA@mail.gmail.com> <CANeU7Qmh5HjMykETwV24o0a4EEaVKqdGUgqSiu9Bc1txq2b+NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:38830 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbdHUTCM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 15:02:12 -0400
Received: by mail-vk0-f54.google.com with SMTP id l132so6672297vke.5
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 12:02:11 -0700 (PDT)
In-Reply-To: <CANeU7Qmh5HjMykETwV24o0a4EEaVKqdGUgqSiu9Bc1txq2b+NQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 7:42 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 21, 2017 at 12:57 PM, Luc Van Oostenryck wrote:
>> I just made a small change to the ptrmap and I'm back to slightly
>> faster than rc5. With all March's pending fixes it's even a bit faster.
>> We're talking of something like twice 2%.
>
> Do you have a link for testing? I can run that on my compile server
> and report back with testing my numbers.

I'll send this very soon.

>> With smaller ptrlist it's yet another 2%.
>
> I think the RC5 with the short cut removed is all already a low
> starting point. It should be faster.

Do you have some numbers for rc4 vs. rc5 ?

> A cytron el al should be faster
> than RC5 too.
>
>> Sorry, but for my part I'll give my trust to a published and well
>> received method.
>
> I understand you don't want to think some thing that is new
> and unproven. But that is all new ideas are about.
>
> In your reasoning we might want to consider Cytron et al then.

Sorry but comparing Braun & Hack's method with Cytron's
is not exactly the same as comparing one of these methods
with some new method by yourself.

Plans, ideas, 'should', 'ideal', 'optimal' and ponies are all good
but at some point you need to implement this and have good
confidence that it's working correctly.

-- Luc
