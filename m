From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 00:20:13 +0100
Message-ID: <CACXZuxdDvRC-WK08vZt0q_L5FZkvNPwnMh4HrmgRT2EgVxYa_Q@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
 <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com>
 <CACXZuxcmg1Q=cmrtpaiEkdNzL=jJCY48J37NrqTP7T6-w0m-0A@mail.gmail.com>
 <CAExDi1SiExepjbRiFbVaPz70DVoFv0=8pgDSiCqJEPaV4HHEpg@mail.gmail.com> <CACXZuxe-Q-5J38K-iu38FXFeOm3cQpwhVercFV3iPq+amJKw+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:38588 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdHMXUO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:20:14 -0400
Received: by mail-ua0-f182.google.com with SMTP id w45so31175645uac.5
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:20:14 -0700 (PDT)
In-Reply-To: <CACXZuxe-Q-5J38K-iu38FXFeOm3cQpwhVercFV3iPq+amJKw+A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 14 August 2017 at 00:17, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 14 August 2017 at 00:10, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Mon, Aug 14, 2017 at 12:55 AM, Dibyendu Majumdar
>> <mobile@majumdar.org.uk> wrote:
>>> Here it is:
>>>
>>> https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/minilua/minilua_preprocessed.c
>>
>> OK, thanks.
>>
>> I see here:
>> 1) 4 errors with a bitcast wich different sizes on each side.
>>     I'm a bit surprised as the code seems to do the right thing when
>>     emitting a bitcast, I'll need to check
>> 3) 3 errors of pointer compare with different types.
>>     It should be easy to fix.
>>
>
> When you say you are seeing errors ... do you mean by running
> sparse-llvm? That won't necessarily match what I get.
>

I mean to say that I am interested in fixing the Sparse IR generation
- so if these are errors in the IR you spotted, then great (I am
amazed at how quickly you found the errors!).

Regards
Dibyendu
