From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 01:40:47 +0200
Message-ID: <CAExDi1SHASROtgwQ3UDU+C6mJ6aTbxDy+0d_o0MK4ubR7XivPQ@mail.gmail.com>
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
 <CACXZuxdDvRC-WK08vZt0q_L5FZkvNPwnMh4HrmgRT2EgVxYa_Q@mail.gmail.com>
 <CAExDi1QP=WF8attJOrndB2qO3ydRD2NoG3KWw8Tu95ZmXeZqvA@mail.gmail.com> <CACXZuxePTQU4FUCtJrGfyZ+5P1gyVgwWwJteA26RE2Tm=J_fyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36647 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdHMXks (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:40:48 -0400
Received: by mail-oi0-f49.google.com with SMTP id g131so71264376oic.3
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:40:48 -0700 (PDT)
In-Reply-To: <CACXZuxePTQU4FUCtJrGfyZ+5P1gyVgwWwJteA26RE2Tm=J_fyQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 14, 2017 at 1:35 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I am not really sure I understand. In dmrC I get following LLVM output
> for above:
> ; ModuleID = 'out.bc'
> source_filename = "dmrC"
>
> @a = global i8 0, align 1
> @b = global i8 0, align 1
>
> ; Function Attrs: argmemonly nounwind
> declare void @llvm.memset.p0i8.i32(i8* nocapture writeonly, i8, i32, i32, i1) #0
>
> define void @c() {
> L0:
>   %R1 = load i8, i8* @a
>   %R2 = sext i8 %R1 to i32
>   %R3 = and i32 %R2, 1
>   %R31 = trunc i32 %R3 to i8
>   store i8 %R31, i8* @b
>   ret void
> }
>
> attributes #0 = { argmemonly nounwind }
>
>
> What do you get?

Nothing at all since I get LLVM error:
Invalid bitcast
  %R31 = bitcast i32 %R3 to i8

I suppose you must have some fixes I haven't or
one of my other fixes created this problem.
I even think I now know which one.

-- Luc
