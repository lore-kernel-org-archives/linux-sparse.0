From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 12:46:16 -0700
Message-ID: <CA+55aFwcfL16REFvFe7MLsnr73_24x86biPGu2XD+ZmocZR_mA@mail.gmail.com>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com>
 <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com>
 <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com>
 <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com>
 <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
 <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
 <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6>
 <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org>
 <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6>
 <4E5A129F.1090801@garzik.org> <CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
 <4E5A97A1.4010504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49861 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752452Ab1H1TrK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 15:47:10 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7SJka4K022622
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 12:46:37 -0700
Received: by wyg24 with SMTP id 24so3594730wyg.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 12:46:36 -0700 (PDT)
In-Reply-To: <4E5A97A1.4010504@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pekka Enberg <penberg@kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, josh@joshtriplett.org

On Sun, Aug 28, 2011 at 12:31 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
> But that comment was thinking more medium term, supporting multiple
> platforms means properly handling struct layout in memory, which gets=
 into
> the realm of platform-specific ABIs.
>
> It didn't seem like we would want to encode a ton of ABI detail into =
the
> sparse C front-end. =A0But it sounds like there will be a lot of ABI =
detail
> found, if sparse is doing all the memory layout and such.

But you *have* to encode it into the front end.

Things like size and alignment of types is exactly what sparse was all
about from the beginning. And if the front-end doesn't know the
offsets into structures, it cannot do any of the load/store
optimizations, which all very much depend on alias information, and
which are how sparse does a lot of the semantic analysis.

A number of the things sparse already does (ie the lock analysis etc)
very much depends on being able to do CSE over accesses to local
variables etc, which originally were memory operations - turning those
memops into registers etc is how sparse can follow things like
branches to branches and optimize them away, which it needs to handle
things like "if (trylock()) -> unlock" sequences.

Now, admittedly we could do much of that without necessarily handling
the *generic* case of loading/storing to structure members etc,
because the case we tend to care about in the sparse code analysis
phase tends to be about the trivial "local variable" case, so in that
sense sparse does a lot more than strictly necessary for just
following the code. But it's much nicer (I think) to have a tool that
really understands the code, than just apply patterns to it.

Of course, "just applying patterns to it" is actually what coccinelle
does, and it has been very successful. So ..

                      Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
