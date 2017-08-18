From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 23:56:05 +0200
Message-ID: <CAExDi1S_qwRktQU2gtXtNpyXpuTji=czsyKVDii6qpximi1SNA@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local> <CA+55aFxMcfPU4yVY6dNL0xiMQ8_hC7UrM0EgwggvxnhAq_ZXdA@mail.gmail.com>
 <CAExDi1Sn4q67_WcN6jSWKDSyxSSR2UPseTYm9Or9uopcQNn81w@mail.gmail.com> <CA+55aFzFYgEPAREZCWLNTxY3HdamETBvjP-uQafnqwGxReoD+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33749 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdHRV4G (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:56:06 -0400
Received: by mail-oi0-f41.google.com with SMTP id f11so109388357oic.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:56:05 -0700 (PDT)
In-Reply-To: <CA+55aFzFYgEPAREZCWLNTxY3HdamETBvjP-uQafnqwGxReoD+w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 11:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Aug 18, 2017 at 1:59 PM, Luc Van Oostenryck wrote:
>>
>> Yes, I see potential too, but nothing very specific. Have you something in mind?
>
> No, to a first approximation I'd just continue to add and subtract
> constant values.
>
> But it might allow us to do conditional contexts, which the kernel
> actually needs. Right now the kernel does tricks like this:
>
>      # define __cond_lock(x,c)      ((c) ? ({ __acquire(x); 1; }) : 0)
>
> (see include/linux/compiler.h) exactly because we want to not really
> add a constant 1 to the context, but add it only if the condition "c"
> was non-zero.

Yes, it could be like __context_{set,clr}(x, <boolean>)
or even                   __context_{or, xor, and, clr}(x, <somebitmask>)

> We then depend on sparse just doing the flow simplification etc. But
> it *could* have been done by just instead allowing the context to be
> updated with a boolean variable..
>
> But sparse might prefer that flow-based approach anyway - I'm just
> saying that sometimes a more flexible model could be a good thing at
> least in theory.

Absolutetly.

-- Luc
