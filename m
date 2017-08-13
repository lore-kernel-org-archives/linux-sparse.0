From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 00:42:26 +0100
Message-ID: <CACXZuxd_WGV840rYhYt6LcTfL+E2uqj+Wr1WpyzUWd8pZQCo1g@mail.gmail.com>
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
 <CACXZuxe-Q-5J38K-iu38FXFeOm3cQpwhVercFV3iPq+amJKw+A@mail.gmail.com>
 <CAExDi1QjkWAU7u8JVDTQZ9Q8YtVkqTF60qDZ+361Z4zGzJPd+A@mail.gmail.com>
 <CACXZuxeUWJitGjcb_yjD-KisrodWj-S8RL4pd1KOY3oKnq_8zg@mail.gmail.com> <CAExDi1TjLH+tiDj-WgsWGaKMr3Uy8Z+PuyCLrC_LxQHh+rCJ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34294 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdHMXm1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:42:27 -0400
Received: by mail-vk0-f43.google.com with SMTP id n125so27109465vke.1
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:42:27 -0700 (PDT)
In-Reply-To: <CAExDi1TjLH+tiDj-WgsWGaKMr3Uy8Z+PuyCLrC_LxQHh+rCJ2A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 14 August 2017 at 00:35, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 1:25 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I was wondering if you get the same Sparse IR error I got - i.e.
>> pseudo that is VOID. You should be able to see this without going to
>> LLVM.
>
> No but I'm not surprised as I have no idea of what exactly you have for changes
>
> -rc5 crash with an assert because of missing FPCAST but well, master
> has none of the needed patches for LLVM.
>

But you should be able to run test-linearize and get the Sparse IR
output with RC5 - is that also crashing?

Regards
Dibyendu
