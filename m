From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC 00/34] ptrlist rework with iterator
Date: Sun, 9 Jul 2017 08:50:05 +0200
Message-ID: <20170709065004.hkhlj2yy6l7l734y@ltop.local>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qkvy3BLVHszomvdY-SpSZ2A7TSgpofRW9D7Mji=LFub4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33877 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdGIGuJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 02:50:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so17228411wrc.1
        for <linux-sparse@vger.kernel.org>; Sat, 08 Jul 2017 23:50:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 08, 2017 at 08:13:15AM -0700, Christopher Li wrote:
> On Fri, Jul 7, 2017 at 6:39 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Here is some patches reworking the whole ptrlist API
> > which move all the logic currently present in the macros
> > in a small set of primitive functions using an iterator
> > structure.
> 
> I am not considering it for this release for sure.

It was, of course, not meant for.
 
> Actually, NACK on the function based iterator API.
> 
> There is no much of a real function enhancement.
> And it is a big slow down.

See below.
 
> I actually like Linus' macro based implementation. I want
> to keep it that way.

No problem.
 
> It looks very clean on the caller side. It perform extremely
> fast. All the internal variable will easy promote to register.

But since all real use of the macros will call some functions
inside the loops all those nice registers will need to be pushed
on the stack.

> I am all about using code to squeezing very last bit of performance
> out of the hardware.

Sure.
Of course, I prefer for now to focus on correctness and
robustness instead of hypothetical micro-performance. Hence
all the fixes, the changes in the testsuite and all the other
testing I made. And don't take me wrong, I've done my share of
timing and profiling, as I'm *very* performance conscious.
 
> Now the function based iterator:
> 
...
> 
> Here is the program just iterate over a long list for many times
> with some condition testing inside the list item.

This sort of artificial benchmark doesn't mean anything, you
should know that. What you need to measure is how the stuff is
really used to see the real effect on cache and generated code.
The we can talk about timing, slowdown & performance.
Have you done this and seen a significative difference?
(I did it, of course, and there wasn't anything significative,
all witihn the noise of the measurements).

Also, in November while I was fixing the problem with empty
blocks, Linus himself said about the ptrlist macros:
	"Some of those inlines look large enough that I wonder
	 how much sense they make as inlines any more"
And indeed, having all those levels of looping inline/in macros
is quite questionnable regarding the quality of the code that can
be generated and impact on i-cache.

It was Linus' remark and combined the issue and the complexity/subtility
which motivated me to see what else can be done with these lists.
But well ...

-- Luc
