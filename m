From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 15:47:45 -0400
Message-ID: <CANeU7QnSK_TpAyi7SsBz76TqGeWcHKXQu2j5U7_E5NZ-+bR80g@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
 <CANeU7Q=-vw1=HgVqs7B-4gHj+Ysr6CVQvr+FpvW7ZNgsf7c=Vg@mail.gmail.com>
 <CACXZuxfHu8M1Lxpjmtj6=HS8T0o5dvDzmSryEqkKn6iG7MAxTw@mail.gmail.com>
 <CANeU7QmaBHLLkXFNZt38wpBGUpaAK38SwWOkJM_hCzs2ijEPaw@mail.gmail.com>
 <CACXZuxeB2wUsZH51pPk2PztbH0J4QQJGKCCsc5LkhDqtwfvQ9A@mail.gmail.com> <CANeU7QmSHbQYjptB8pasbNhp75tQ2bWSy1AMGUZxGNeHYfCcvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34759 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbdHNTrq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 15:47:46 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so61072107ywg.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 12:47:46 -0700 (PDT)
In-Reply-To: <CANeU7QmSHbQYjptB8pasbNhp75tQ2bWSy1AMGUZxGNeHYfCcvA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Aug 14, 2017 at 3:23 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 14, 2017 at 2:58 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Here it is:
>>
>> https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/lcc/cq_preprocessed.c

Most of the time is spending on the s714 function.

That function has a lot of variable name and a lot of blocks.

Chris
