From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 14:10:26 -0700
Message-ID: <CA+55aFzFYgEPAREZCWLNTxY3HdamETBvjP-uQafnqwGxReoD+w@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local> <CA+55aFxMcfPU4yVY6dNL0xiMQ8_hC7UrM0EgwggvxnhAq_ZXdA@mail.gmail.com>
 <CAExDi1Sn4q67_WcN6jSWKDSyxSSR2UPseTYm9Or9uopcQNn81w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33187 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdHRVK1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:10:27 -0400
Received: by mail-oi0-f50.google.com with SMTP id f11so108518229oic.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:10:27 -0700 (PDT)
In-Reply-To: <CAExDi1Sn4q67_WcN6jSWKDSyxSSR2UPseTYm9Or9uopcQNn81w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 1:59 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>> We do all the flow stuff for variables
>> anyway, and using a hidden variable would make it potentially a lot
>> more flexible. You could make the context op do much more than just a
>> fixed inc/dec.
>
> Yes, I see potential too, but nothing very specific. Have you something in mind?

No, to a first approximation I'd just continue to add and subtract
constant values.

But it might allow us to do conditional contexts, which the kernel
actually needs. Right now the kernel does tricks like this:

     # define __cond_lock(x,c)      ((c) ? ({ __acquire(x); 1; }) : 0)

(see include/linux/compiler.h) exactly because we want to not really
add a constant 1 to the context, but add it only if the condition "c"
was non-zero.

We then depend on sparse just doing the flow simplification etc. But
it *could* have been done by just instead allowing the context to be
updated with a boolean variable..

But sparse might prefer that flow-based approach anyway - I'm just
saying that sometimes a more flexible model could be a good thing at
least in theory.

               Linus
