From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Sat, 5 Aug 2017 18:50:28 -0400
Message-ID: <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34541 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdHEWu3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 18:50:29 -0400
Received: by mail-pf0-f177.google.com with SMTP id o86so20462187pfj.1
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 15:50:29 -0700 (PDT)
In-Reply-To: <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 5, 2017 at 6:32 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Aug 5, 2017 at 5:46 PM, Christopher Li <sparse@chrisli.org> wrote:
>> All the code I want is already in sparse-next. A little bit more testing
>> I will soon release the RC5.
>
> sparse-next is currently not fast-forwardable from master.

I think I use one of your branch as base. I will fix it now.
I think just rebase sparse-next to master now.
It should fix the problem.

Chris
