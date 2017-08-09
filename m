From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Interaction between bitfields and casts
Date: Wed, 9 Aug 2017 14:27:32 -0700
Message-ID: <CA+55aFw6PfWeEFcRPQg5DQOU_8Xzc48N-5Hr2F_e4=BYgqzdDg@mail.gmail.com>
References: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33195 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdHIV1d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 17:27:33 -0400
Received: by mail-oi0-f53.google.com with SMTP id f11so58541682oic.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 14:27:33 -0700 (PDT)
In-Reply-To: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 1:41 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> When assigning values to bitfields I have noticed that some times
> Sparse generates a CAST instruction with an odd bit size - i.e. not a
> standard integer size. I was wondering if there are specific scenarios
> that lead to this. While LLVM handles the odd cast - I am working with
> another backend (Nanojit) that doesn't.

The cast instructions are a bit odd, I agree.

The basic rule is that each pseudo has a type (signed int, unsigned
int, fp, ptr) and a size (which is whatever, although obviously
pointers and FP values are fairly constrained).

NOTE! By "type" above, I mean "value type". There's another kind of
"type" when it comes to pseudos, ie the "pseudo->type" thing, which is
reg/sym/val/arg/phi. That's a different thing entirely.

Anyway, the size and value type of a pseudo is defined by the size of
the instruction that defines it.

And whenever the type or size changes, there should be a cast instruction.

But honestly, the casts are not very well done.

The size change should always be fairly obvious: you can see the old
size by looking at the size of the defining instruction of the source
pseudo, and you can see the new size by looking at the size of the
cast instruction that defines the new pseudo.

But the "value type" change is pretty garbage. We have four "ops"
(CAST/SCAST/PTRCAST/FPCAST), but they make absolutely no sense. The
problem is that there really are many many different combinations
(unsigned integer to floating point, Fp to ptr, etc etc), and the
opcode is generated from some random combination of source/dst that
really doesn't make sense.

I'm not proud of it. It probably really should be just one cast op,
and then the type should be something that - like the size - is
something you go look up.

And *when* the source and destination are both integers (and arguably
a pointer too), then obviously the cast can just always be turned into
a zero-extension or sign extension.

So the OP_*CAST functions really are a bit confused. Maybe Luc has
cleaned some of it up already, I'm going partly from memory.

To make a long story short: the OP_*CAST stuff is not great, and
doesn't make a ton of sense. It should probably be rewritten.

                     Linus
