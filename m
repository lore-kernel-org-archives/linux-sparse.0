From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 10:04:54 -0700
Message-ID: <CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com>
 <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com>
 <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com>
 <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com>
 <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
 <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
 <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6>
 <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org>
 <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6> <4E5A129F.1090801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36607 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075Ab1H1RFr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 13:05:47 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7SH5Gwe014025
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 10:05:18 -0700
Received: by wyg24 with SMTP id 24so3543388wyg.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 10:05:15 -0700 (PDT)
In-Reply-To: <4E5A129F.1090801@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pekka Enberg <penberg@kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Aug 28, 2011 at 3:04 AM, Jeff Garzik <jeff@garzik.org> wrote:
>
> * need to start integrating struct support. =A0LLVM has a type system=
 where
> one defines data structures in the IR, then uses 'getelementptr' LLVM
> instruction to build addresses for complex load/store operations. The=
 Linux
> kernel uses a lot of function calls (indirect branches) from values b=
uried
> deep within a struct.

You really shouldn't need to do that.

You should consider all types to be just "blocks of memory", and
sparse has already calculated all offsets etc for you. As far as LLVM
is concerned, the memory has no structure, it's just a blob.

Sometimes you cannot even get the "element" name. Look at
=2E/test-linearize output of something like this:

  struct hello {
    int a,b,c;
  };

  int bar(struct hello *arg)
  {
	return ((char *)&arg->b)[1] + arg->c;
  }

and realize that that byte access isn't accessing an element at all -
it's just accessing a *part* of an element. The more complicated cases
is actually when you access multiple elements in one go.

And sparse has figured all that out for you already, done the alias
analysis (ok, just stupid overlap analysis) etc.

Btw, if you look at test-linearize output for that, you'll see the
"ptrcast" thing. We don't simplify that away, so you will see
something like

	add.32      %r2 <- %arg1, $4
	ptrcast.32  %r3 <- (32) %r2
	load.8      %r4 <- 1[%r3]

instead of just

	load.8      %r4 <- 5[%arg1]

but that's just a small "I left all pointer casts around, even if they
don't do anything" detail.

                           Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
