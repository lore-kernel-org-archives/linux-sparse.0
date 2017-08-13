From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 01:47:57 +0200
Message-ID: <CAExDi1TkuM52Lo6yDWVfi=acGFt+HFmCyfs63AuM0pfPTP5WhA@mail.gmail.com>
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
 <CACXZuxeUWJitGjcb_yjD-KisrodWj-S8RL4pd1KOY3oKnq_8zg@mail.gmail.com>
 <CAExDi1TjLH+tiDj-WgsWGaKMr3Uy8Z+PuyCLrC_LxQHh+rCJ2A@mail.gmail.com> <CACXZuxd_WGV840rYhYt6LcTfL+E2uqj+Wr1WpyzUWd8pZQCo1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35827 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdHMXr6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:47:58 -0400
Received: by mail-oi0-f52.google.com with SMTP id e124so71637280oig.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:47:58 -0700 (PDT)
In-Reply-To: <CACXZuxd_WGV840rYhYt6LcTfL+E2uqj+Wr1WpyzUWd8pZQCo1g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 14, 2017 at 1:42 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> But you should be able to run test-linearize and get the Sparse IR
> output with RC5 - is that also crashing?

No no.
With this tree I haven't yet found a single way to make sparse or
test-linearize crash.

But I need first the patch: 'fix: cast of OP_AND only valid if it's an OP_CAST'
but it will be for another day.

-- Luc
