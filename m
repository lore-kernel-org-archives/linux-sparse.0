From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 17:13:04 +0200
Message-ID: <CAExDi1R9OoUZDBTyg0-B4D9-HCjwV001coYR1iwLyTVQV=NG6A@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
 <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com>
 <CAExDi1TftYYi=CS09_yUdMP0xni3zwq-ZJoRz3hEWgykiybLpQ@mail.gmail.com>
 <CACXZuxfimo2VEtihrp=0FFRdBVZiQCL7PSXOPzwfRD7K_2YdGQ@mail.gmail.com> <CACXZuxe1emmxLzt+mShUyENcRfaS_hKpbHcJBp1DWf5ZRZ6ekg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35567 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbdHMPNF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 11:13:05 -0400
Received: by mail-oi0-f41.google.com with SMTP id e124so66936034oig.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 08:13:05 -0700 (PDT)
In-Reply-To: <CACXZuxe1emmxLzt+mShUyENcRfaS_hKpbHcJBp1DWf5ZRZ6ekg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 5:00 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> In the interest of getting the release out I recommend simply undoing
> the single store shortcut change. It was a last minute change and that
> is always risky.

Thing is that this change was made to solve another problem:
sparse going in infinite loops because this shortcut doesn't
handle uninitialized variables while the general case is correct.
So it's a question of correctness vs. performance.

Of course, I also sent yesterday another, more general, bandaid
for these problems but well ...

-- Luc
