From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Some thoughts on the SSA debate
Date: Wed, 13 Sep 2017 21:10:01 +0200
Message-ID: <CAExDi1QisEx6tEiTB1_kEhSpSLk60GSJuqBZBXFyuJc8wN+Omw@mail.gmail.com>
References: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
 <20170909020604.5io7kuw6itquzbfp@ltop.local> <CACXZuxdtwsp=YXN_4q5Ox=6R6fKdz-6kLUcTYskJcwd6qvh5DQ@mail.gmail.com>
 <CAExDi1QyP5FRTrNgfEx7zK=bKQyPQ36gHgDSBRtqWOi=-Bf-sw@mail.gmail.com>
 <CACXZuxcQrFOaM8T5z-5tZNU3XnY8d4aOQ3FfRs2SSY+Gv1T7rA@mail.gmail.com>
 <CAExDi1QW8U=rkLX-JMzi=uQG0RTJ-bCjRT46m3CTb7LifKXMQA@mail.gmail.com> <CACXZuxeO_rpOFwhjf8vb1SsiHH0NJNneKyoDwF_BzyYyz6n4kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:46763 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdIMTKE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 15:10:04 -0400
Received: by mail-lf0-f49.google.com with SMTP id m199so3066767lfe.3
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 12:10:03 -0700 (PDT)
In-Reply-To: <CACXZuxeO_rpOFwhjf8vb1SsiHH0NJNneKyoDwF_BzyYyz6n4kw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 13, 2017 at 8:25 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 12 September 2017 at 14:06, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Tue, Sep 12, 2017 at 1:47 PM, Dibyendu Majumdar
>>> But the issue
>>> right now is that the simplifications are not always correct even with
>>> the new SSA so that I have to disable everything anyway.
>>
>> It's what you do but it's not what I do.
>> The other part that is broken is simplify_loads() which try to convert
>> more variables after each simplification/CSE steps.
>> Since the code is copied from the code for the initial conversion
>> it's broken in the same ways.
>> I just disabled it and things are then correct.
>>
>
> I probably ought to update my project with the latest version you
> have. Please let me know if you have an updated minimal changes branch
> that I can apply.

For SSSA, I have what you should have already or something quite close:
* https://github.com/lucvoo/sparse/tree/sssa-mini-v3

And the same but with all LLVM fixes and others fixes or optimizations:
* https://github.com/lucvoo/sparse/tree/sssa-next

I also have something I use only as a sort of reference which I have
absolutely no intention to ever submit. It doesn't do the SSA conversion
during linearization and converts more vars. It also seems to be quite
correct and so is useful to me for doing comparisons but that's all (and it's
not tested for against the kernel, for example):
* https://github.com/lucvoo/sparse/tree/mem2ssa-next

None of these trees are stable as I often rebuild them while working
on the base.
So, I'm not sure how useful they can be for you but if you find a problem
with linearization, SSA conversion or optimization, you can always check
with one of these (probably the last one) to see if it's already fixed or not.

-- Luc
