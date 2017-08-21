From: Christopher Li <sparse@chrisli.org>
Subject: Re: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 15:27:16 -0400
Message-ID: <CANeU7Qm114Zc2=OUnkdCatn+axFg0do8Kq=Oy2mbEVpjEuOUjQ@mail.gmail.com>
References: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
 <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com>
 <CANeU7QkZD4OFjdpTH3Dz5Yq6XMxRvi=+L=G2K5soxFTycDxi_Q@mail.gmail.com>
 <CAMHZB6H9VAT8STaXSuR=waaS3rggky4DE+QRtF6S0vYKWLuRLA@mail.gmail.com>
 <CANeU7Qmh5HjMykETwV24o0a4EEaVKqdGUgqSiu9Bc1txq2b+NQ@mail.gmail.com> <CAMHZB6FFO=gdC-i=z5KkHXG+mDrKq5gOiU7=2jQCM=gZ1=uF4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33766 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbdHUT1R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 15:27:17 -0400
Received: by mail-yw0-f174.google.com with SMTP id h127so28336497ywf.0
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 12:27:17 -0700 (PDT)
In-Reply-To: <CAMHZB6FFO=gdC-i=z5KkHXG+mDrKq5gOiU7=2jQCM=gZ1=uF4A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 3:02 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 21, 2017 at 7:42 PM, Christopher Li <sparse@chrisli.org> wrote:
>> On Mon, Aug 21, 2017 at 12:57 PM, Luc Van Oostenryck wrote:
>>> I just made a small change to the ptrmap and I'm back to slightly
>>> faster than rc5. With all March's pending fixes it's even a bit faster.
>>> We're talking of something like twice 2%.
>>
>> Do you have a link for testing? I can run that on my compile server
>> and report back with testing my numbers.
>
> I'll send this very soon.

Great. Looking forward to it.

> Do you have some numbers for rc4 vs. rc5 ?

I will do it now.

>> In your reasoning we might want to consider Cytron et al then.
>
> Sorry but comparing Braun & Hack's method with Cytron's
> is not exactly the same as comparing one of these methods
> with some new method by yourself.

Of course. That is just *ideas*. I am trying to see if there is
some serious fault in the ideas that it is not implementable.
Consider it as some brain storming.

I am not purposing do that idea right now. The development plan
I have in mind was:
1) merge your SSSA patches.
2) enable the old SSA promotion code path (with bugs) to cover the
    case not handle by SSSA.
3) Fix the bug in old SSA promotion path, possibly implement Cytron
   el al.

> Plans, ideas, 'should', 'ideal', 'optimal' and ponies are all good
> but at some point you need to implement this and have good
> confidence that it's working correctly.

Of course. We can implement Cytron first and use that as
verification path for other idea to optimized it. That is why I want
to have debug version of sparse as well.

Chris
