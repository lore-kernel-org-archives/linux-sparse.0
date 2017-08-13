From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 15:44:41 +0100
Message-ID: <CACXZuxfimo2VEtihrp=0FFRdBVZiQCL7PSXOPzwfRD7K_2YdGQ@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
 <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com> <CAExDi1TftYYi=CS09_yUdMP0xni3zwq-ZJoRz3hEWgykiybLpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:37586 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdHMOon (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 10:44:43 -0400
Received: by mail-ua0-f177.google.com with SMTP id f9so29208762uaf.4
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 07:44:42 -0700 (PDT)
In-Reply-To: <CAExDi1TftYYi=CS09_yUdMP0xni3zwq-ZJoRz3hEWgykiybLpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On 13 August 2017 at 15:18, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 13, 2017 at 3:18 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>
>>> Care to send your code, I can see where the problem could be?
>>
>> Yes apologies I should have mentioned the test case:
>>
>> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/lcc/cq.c
>
> No problem.
>
>> I am checking whether the slowdown is due to some other factor such as:
>
> I just gave a try and, I was a bit surprised as with the current master,
> here it takes me about 5s to get the output of test-linearize (which I find
> already a bit slow). It's far far from the time you have.
>
> OTOH with -rc4, it takes only 0.05s !
>
> The situation is really weird, it's an interaction between the patches:
> - remove single-store shortcut (first slowdown to 0.8s)
> - fix ptrlist corruption while killing unreachable BBs (second slowdown to 2.9s)
> - mark pseudo users as deleted instead of removing them (third slowdown to 5.5s)
>
> All three patches were expected to create *some* slowdown,
> the first one very obviously and much more than the others.
>
> It's interesting to note that without the 'remove single shortcut' patch, the
> two others ones don't seem to have a significative effect on the time.
>

Yes, reinstating the single store shortcut reduces time from 8.3 secs
to 0.16 seconds.

Regards
Dibyendu
