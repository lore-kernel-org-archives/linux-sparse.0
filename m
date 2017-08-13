From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 14:18:52 +0100
Message-ID: <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com> <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:38459 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbdHMNSx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 09:18:53 -0400
Received: by mail-ua0-f180.google.com with SMTP id w45so28877524uac.5
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 06:18:53 -0700 (PDT)
In-Reply-To: <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Luc,

On 13 August 2017 at 14:10, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 13, 2017 at 2:56 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I am merging and testing this in my repository. I notice that after
>> applying the changes related to killing of BBs - there is a
>> significant slow down in Sparse.
>>
>> Before the merge:
>>
>> real: 4.3 minutes
>> user: 4.1 minutes
>>
>> After the merge:
>>
>> real: 18.9 minutes
>> user: 18.7 minutes
>>
>> I just noticed this and these are my initial tests. But I thought it
>> worth letting you know.
>
> I very small slowdown is expected (and even it could have positive
> effect too) but not at all something like this.
> And what I (and I think Chris too) measured was indeed quite small.
>
> Care to send your code, I can see where the problem could be?
>

Yes apologies I should have mentioned the test case:

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/lcc/cq.c

I am checking whether the slowdown is due to some other factor such as:

a) Build options - I need to check whether my build is an optimized
build or not.
b) I am using function based ptrlist iterators - so that may be
exacerbating the issue

But still it would be interesting to know what your results are for
this test case.

Regards
Dibyendu
