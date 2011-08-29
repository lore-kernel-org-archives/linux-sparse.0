From: Pekka Enberg <penberg@kernel.org>
Subject: Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Mon, 29 Aug 2011 23:42:37 +0300
Message-ID: <CAOJsxLFciLwdu1cBd9LO77U-9P+3e7agYYd8tV1qCf_4HeWGVg@mail.gmail.com>
References: <4E5495C9.6050207@kernel.org>
	<CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com>
	<4E55F33C.50203@kernel.org>
	<CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com>
	<CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com>
	<CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com>
	<alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
	<CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
	<alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
	<alpine.DEB.2.00.1108252310490.22479@localhost6.localdomain6>
	<CA+55aFy3TUT=BFD+Nb9H6uDBhz427kC4tBc+ehQDs6JBggTuHQ@mail.gmail.com>
	<4E573A3E.6060104@kernel.org>
	<CA+55aFzbV0OvrtkzbjxvL1tkfF=+6xbBsyWb8XtAcK-YNeKjZw@mail.gmail.com>
	<alpine.DEB.2.00.1108271214410.14365@localhost6.localdomain6>
	<CA+55aFzbfD4RDe52HCL9mfSYMzFdvP96OiK5ifkfUKNkzjJNrg@mail.gmail.com>
	<alpine.DEB.2.00.1108292242110.24020@localhost6.localdomain6>
	<CA+55aFw1rzBG42oDz8PajG78CeuKyRBZW+vFwmE5e2XEtcFDfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37783 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab1H2Umi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 16:42:38 -0400
Received: by iabu26 with SMTP id u26so820848iab.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 13:42:38 -0700 (PDT)
In-Reply-To: <CA+55aFw1rzBG42oDz8PajG78CeuKyRBZW+vFwmE5e2XEtcFDfw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org

On Mon, Aug 29, 2011 at 12:45 PM, Pekka Enberg <penberg@kernel.org> wrote:
>> However, i'm not 100% sure that's sufficient. Is OP_CAST always zero-extend
>> or do we need to check for something specific here?

On Mon, Aug 29, 2011 at 11:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> OP_CAST is always a zero-extend, OP_SCAST is a sign-extending one.
>
> (Of course, they may be *truncating* casts too, which don't need to
> generate any code on most architectures).
>
> OP_PTRCAST should act as OP_CAST.

OK, makes perfect sense. We don't support OP_SCAST or OP_PTRCAST yet
so those should be fine. I fixed OP_CAST like this:

https://github.com/penberg/sparse-llvm/commit/2dea6f7fb07cd18255cf1d73079638dc96bdd08b

So comparison operators should be OK now.

On Mon, Aug 29, 2011 at 11:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> NOTE! The casting is dubious. We only have a single OP_FPCAST, for
> example, and that's just broken. Right now "OP_FPCAST" means that the
> *source* was a FP value. But if we cast *to* a FP value, it ends up
> showing up as OP_[S]CAST, which is just bogus. The FPCAST should be
> for any FP operation (to or from or both), and then the FPCAST logic
> would have to decide how it handles it.
>
> The FP support in general is pretty weak. The kernel doesn't do FP, I
> never really cared about it.

Good to know. I've added support for simple FP ops though and they
seem to be fine.

                        Pekka
