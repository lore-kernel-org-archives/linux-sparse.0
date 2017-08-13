From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 16:18:08 +0200
Message-ID: <CAExDi1TftYYi=CS09_yUdMP0xni3zwq-ZJoRz3hEWgykiybLpQ@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com> <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36251 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdHMOSJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 10:18:09 -0400
Received: by mail-oi0-f49.google.com with SMTP id g131so66101898oic.3
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 07:18:09 -0700 (PDT)
In-Reply-To: <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 3:18 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:

>> Care to send your code, I can see where the problem could be?
>
> Yes apologies I should have mentioned the test case:
>
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/lcc/cq.c

No problem.

> I am checking whether the slowdown is due to some other factor such as:

I just gave a try and, I was a bit surprised as with the current master,
here it takes me about 5s to get the output of test-linearize (which I find
already a bit slow). It's far far from the time you have.

OTOH with -rc4, it takes only 0.05s !

The situation is really weird, it's an interaction between the patches:
- remove single-store shortcut (first slowdown to 0.8s)
- fix ptrlist corruption while killing unreachable BBs (second slowdown to 2.9s)
- mark pseudo users as deleted instead of removing them (third slowdown to 5.5s)

All three patches were expected to create *some* slowdown,
the first one very obviously and much more than the others.

It's interesting to note that without the 'remove single shortcut' patch, the
two others ones don't seem to have a significative effect on the time.

My guess here is that indeed, with this input, the single-store shortcut
is a huge optimization and without it much much more code is created
(phi-nodes, I suppose) and this impact very negatively the two other fixes.

I'll see what can be done.

-- Luc
