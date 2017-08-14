From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 19:58:15 +0100
Message-ID: <CACXZuxeB2wUsZH51pPk2PztbH0J4QQJGKCCsc5LkhDqtwfvQ9A@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
 <CANeU7Q=-vw1=HgVqs7B-4gHj+Ysr6CVQvr+FpvW7ZNgsf7c=Vg@mail.gmail.com>
 <CACXZuxfHu8M1Lxpjmtj6=HS8T0o5dvDzmSryEqkKn6iG7MAxTw@mail.gmail.com> <CANeU7QmaBHLLkXFNZt38wpBGUpaAK38SwWOkJM_hCzs2ijEPaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:37824 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbdHNS6Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 14:58:16 -0400
Received: by mail-vk0-f45.google.com with SMTP id r199so34448115vke.4
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 11:58:16 -0700 (PDT)
In-Reply-To: <CANeU7QmaBHLLkXFNZt38wpBGUpaAK38SwWOkJM_hCzs2ijEPaw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On 14 August 2017 at 19:52, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 14, 2017 at 2:48 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>
>>
>> https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/lcc/cq.c
>>
>
> Can you run a preprocessor output and put it some where in online?
>
> You can do "sparse -E ...." the rest of normal flags.
>
> That way I can duplicate it here with RC5, otherwise
> I need to duplicate your project compile environment.
>

Here it is:

https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/lcc/cq_preprocessed.c
