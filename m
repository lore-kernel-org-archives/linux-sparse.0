From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 00:35:31 +0100
Message-ID: <CACXZuxePTQU4FUCtJrGfyZ+5P1gyVgwWwJteA26RE2Tm=J_fyQ@mail.gmail.com>
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
 <CACXZuxdDvRC-WK08vZt0q_L5FZkvNPwnMh4HrmgRT2EgVxYa_Q@mail.gmail.com> <CAExDi1QP=WF8attJOrndB2qO3ydRD2NoG3KWw8Tu95ZmXeZqvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36962 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdHMXfc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:35:32 -0400
Received: by mail-vk0-f53.google.com with SMTP id r199so26984649vke.4
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:35:32 -0700 (PDT)
In-Reply-To: <CAExDi1QP=WF8attJOrndB2qO3ydRD2NoG3KWw8Tu95ZmXeZqvA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 14 August 2017 at 00:28, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 1:20 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I mean to say that I am interested in fixing the Sparse IR generation
>> - so if these are errors in the IR you spotted, then great
>
> Yes, I know.
> But I confess that doing this through sparse-llvm is kinda a pita for me :)
>
>> (I am
>> amazed at how quickly you found the errors!).
>
> Hey, I have now a small reproducer for one of the problem:
>     char a, b;
>     void c(void)
>     {
>         b = a & 1;
>     }
>
> and we can solve it and put in the testsuite to avoid future regressions.
>

I am not really sure I understand. In dmrC I get following LLVM output
for above:
; ModuleID = 'out.bc'
source_filename = "dmrC"

@a = global i8 0, align 1
@b = global i8 0, align 1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i32(i8* nocapture writeonly, i8, i32, i32, i1) #0

define void @c() {
L0:
  %R1 = load i8, i8* @a
  %R2 = sext i8 %R1 to i32
  %R3 = and i32 %R2, 1
  %R31 = trunc i32 %R3 to i8
  store i8 %R31, i8* @b
  ret void
}

attributes #0 = { argmemonly nounwind }


What do you get?

Regards
Dibyendu
