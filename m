From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC 00/34] ptrlist rework with iterator
Date: Sun, 9 Jul 2017 11:34:54 +0100
Message-ID: <CACXZuxeTWcOX9C1z9mhtifZYVJ-O22iAP6VTui+k_9v0BfodvA@mail.gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qkvy3BLVHszomvdY-SpSZ2A7TSgpofRW9D7Mji=LFub4Q@mail.gmail.com>
 <20170709065004.hkhlj2yy6l7l734y@ltop.local> <CANeU7QmEafcK1ScPajnOaDBJHuG8WrK2UiSQNDQug9Ckx1DkJg@mail.gmail.com>
 <20170709095243.7esx42hsa75yy5w3@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33449 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdGIKe4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 06:34:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so18138343wrb.0
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 03:34:56 -0700 (PDT)
In-Reply-To: <20170709095243.7esx42hsa75yy5w3@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi,

On 9 July 2017 at 10:52, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> On Sun, Jul 09, 2017 at 01:25:36AM -0700, Christopher Li wrote:
>> For the record, I did run your code with kernel source checking.
>> "wasn't anything significative" by itself was not good enough to
>> accept the patch. Such a big rewrite of such fundamental building
>> block better have good enough reason for it. I don't see a lot
>> of up side to justify it. I definitely see the down side in performance.
>
> And what was this slow down you saw? 5%, 1%, less than 1%?
> It would help to have some number. Like I said above, when
> I did the test any speed difference I saw was within the
> noise.
>

As I am using a function based iterator in dmr_C this discussion is of
interest. I agree with Luc that micro benchmarks are not very useful.
Is there data on what the performance impact is on running sparse
against say the Linux kernel. Is there statistically significant
difference?

I personally think that the trade-off for more understandable and
supportable code here is worth it as really the performance difference
if extremely small should not be of great importance to a tool like
sparse which is a development tool, and not something you are running
to handle production workload.

My approach in dmr_C allows me to switch between the macro based
implementation and the function based implementation, primarily so
that when I get failures I can check if the failures are due to the
changes I made. But this has the drawback of maintaining two versions.

Anyway just wanted to put my vote for the changes proposed by Luc.

Regards
Dibyendu
