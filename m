From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 00:25:58 +0100
Message-ID: <CACXZuxeUWJitGjcb_yjD-KisrodWj-S8RL4pd1KOY3oKnq_8zg@mail.gmail.com>
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
 <CAExDi1SiExepjbRiFbVaPz70DVoFv0=8pgDSiCqJEPaV4HHEpg@mail.gmail.com>
 <CACXZuxe-Q-5J38K-iu38FXFeOm3cQpwhVercFV3iPq+amJKw+A@mail.gmail.com> <CAExDi1QjkWAU7u8JVDTQZ9Q8YtVkqTF60qDZ+361Z4zGzJPd+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34167 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdHMXZ7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:25:59 -0400
Received: by mail-vk0-f43.google.com with SMTP id n125so27061248vke.1
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:25:59 -0700 (PDT)
In-Reply-To: <CAExDi1QjkWAU7u8JVDTQZ9Q8YtVkqTF60qDZ+361Z4zGzJPd+A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 14 August 2017 at 00:22, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 1:17 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>> I see here:
>>> 1) 4 errors with a bitcast wich different sizes on each side.
>>>     I'm a bit surprised as the code seems to do the right thing when
>>>     emitting a bitcast, I'll need to check
>>> 3) 3 errors of pointer compare with different types.
>>>     It should be easy to fix.
>>>
>>
>> When you say you are seeing errors ... do you mean by running
>> sparse-llvm?
>
> yes:
> Invalid bitcast
>   %R36121 = bitcast i32 %R361 to i8
> Both operands to ICmp instruction are not of the same type!
>   %R378 = icmp ne i8* %R3763, %struct.lua_TValue* %R375
> Invalid bitcast
>   %R10918 = bitcast i32 %R1091 to i8
> Invalid bitcast
>   %R12116 = bitcast i32 %R1211 to i8
> Both operands to ICmp instruction are not of the same type!
>   %R1930 = icmp eq { [184 x i8] }* %R1927, { [24 x i8] }* %ARG2
> Both operands to ICmp instruction are not of the same type!
>   %R2124 = icmp eq i8* %R212221, %struct.lua_TValue* %R2121
> Invalid bitcast
>   %R32617 = bitcast i32 %R3261 to i8
>
>> That won't necessarily match what I get.
>
> Yes, I realized already but I have to begin with this.
> They don't seem to be hard or conceptual bugs.
>

I was wondering if you get the same Sparse IR error I got - i.e.
pseudo that is VOID. You should be able to see this without going to
LLVM.

Regards
Dibyendu
