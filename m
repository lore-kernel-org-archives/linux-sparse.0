From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 17:54:47 +0100
Message-ID: <CACXZuxfhQAUuzcZEm+eYQAuSMnouposoV0WRXsUH4hkcf2ODWA@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qh_T89GkTAXtS9ZXiAk9J0Y-b7ohwCjg=K3FPX4qjQOw@mail.gmail.com>
 <CACXZuxfsJLe0uG9aXNSiKgZofYVGf_kYmFhn6Vj5bBT56xnwgw@mail.gmail.com>
 <CAExDi1Qovq8gAXw8d7cSt73Gz+y8_3cH+yc40TaPudY_QNqPVQ@mail.gmail.com>
 <CACXZuxf4T1u1=3pE52V2smtqS_61XSx6Ed7aWXPgRK+3FtDnvw@mail.gmail.com> <CAExDi1Qf85VY8ovn2uRoo6Qivwa0G5L529feuCzHt3FJOBEAog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:37050 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdHNQys (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 12:54:48 -0400
Received: by mail-vk0-f52.google.com with SMTP id r199so33372053vke.4
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 09:54:48 -0700 (PDT)
In-Reply-To: <CAExDi1Qf85VY8ovn2uRoo6Qivwa0G5L529feuCzHt3FJOBEAog@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Luc,

On 14 August 2017 at 17:44, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 6:29 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>
>> I will look at merging your sssa-mini patches to dmrC. I had a quick
>> look - presumably the ptrmap ought to be hash table?
>
> Yes, it's one of the things plan to do but it's not much important
> as it works already quite well in most situations.
>
> This evening, I'll make the change to initialize floats and then it
> will cover already a lot of code.
> I'm also working to redo everything related to casts, will probably
> be finished this evening and should simplify a lots of things,
> especially on LLVM's side.
>

I would rather just have the SSA construction bits first, without too
many other changes. In particular I have workarounds for floating
point (I just don't allow simplification for ops involving floating
point values) - and I am keen not to have rework things on the LLVM
side, or have to deal with new opcodes etc.

Regards
Dibyendu
