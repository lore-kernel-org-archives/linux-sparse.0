From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Mon, 29 Aug 2011 13:32:33 -0700
Message-ID: <CA+55aFw1rzBG42oDz8PajG78CeuKyRBZW+vFwmE5e2XEtcFDfw@mail.gmail.com>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com>
 <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com>
 <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com>
 <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com>
 <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
 <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
 <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <alpine.DEB.2.00.1108252310490.22479@localhost6.localdomain6>
 <CA+55aFy3TUT=BFD+Nb9H6uDBhz427kC4tBc+ehQDs6JBggTuHQ@mail.gmail.com>
 <4E573A3E.6060104@kernel.org> <CA+55aFzbV0OvrtkzbjxvL1tkfF=+6xbBsyWb8XtAcK-YNeKjZw@mail.gmail.com>
 <alpine.DEB.2.00.1108271214410.14365@localhost6.localdomain6>
 <CA+55aFzbfD4RDe52HCL9mfSYMzFdvP96OiK5ifkfUKNkzjJNrg@mail.gmail.com> <alpine.DEB.2.00.1108292242110.24020@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40011 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754954Ab1H2UdZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 16:33:25 -0400
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7TKWsoP019834
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 13:32:55 -0700
Received: by wwe5 with SMTP id 5so2789325wwe.1
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 13:32:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108292242110.24020@localhost6.localdomain6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org

On Mon, Aug 29, 2011 at 12:45 PM, Pekka Enberg <penberg@kernel.org> wrote:
>
> However, i'm not 100% sure that's sufficient. Is OP_CAST always zero-extend
> or do we need to check for something specific here?

OP_CAST is always a zero-extend, OP_SCAST is a sign-extending one.

(Of course, they may be *truncating* casts too, which don't need to
generate any code on most architectures).

OP_PTRCAST should act as OP_CAST.

NOTE! The casting is dubious. We only have a single OP_FPCAST, for
example, and that's just broken. Right now "OP_FPCAST" means that the
*source* was a FP value. But if we cast *to* a FP value, it ends up
showing up as OP_[S]CAST, which is just bogus. The FPCAST should be
for any FP operation (to or from or both), and then the FPCAST logic
would have to decide how it handles it.

The FP support in general is pretty weak. The kernel doesn't do FP, I
never really cared about it.

                            Linus
