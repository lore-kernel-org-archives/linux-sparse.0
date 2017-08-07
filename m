From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Upcoming sparse release RC5
Date: Mon, 7 Aug 2017 18:41:55 +0200
Message-ID: <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com> <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35596 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdHGQl4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 12:41:56 -0400
Received: by mail-qt0-f181.google.com with SMTP id p3so5872370qtg.2
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 09:41:56 -0700 (PDT)
In-Reply-To: <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 12:50 AM, Christopher Li <sparse@chrisli.org> wrote:
>>> I will soon release the RC5.
>>
>> sparse-next is currently not fast-forwardable from master.
>
> I think I use one of your branch as base. I will fix it now.

You have now rebased an existing branch,
the one for "fix crash with sym->bb_target == NULL".
There was no reasons for that.

Please make good use of 'git pull' instead of rebasing external
branches, it's a pain.
Thanks.

-- Luc
