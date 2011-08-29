From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Mon, 29 Aug 2011 09:58:36 -0700
Message-ID: <CA+55aFwmtOQgksqdWH=PrsPcDaG44kKBu+3knz9h4zJLGD4X8g@mail.gmail.com>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>
 <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
 <CAOJsxLEMvZMX9x0s4VGx9KMPdPbcHqtg0Q=o6ivSCamC3aHUrg@mail.gmail.com> <4E5BACEB.7020502@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34699 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754361Ab1H2Q73 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 12:59:29 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7TGwupo000691
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 09:58:57 -0700
Received: by wyg24 with SMTP id 24so4231766wyg.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 09:58:56 -0700 (PDT)
In-Reply-To: <4E5BACEB.7020502@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Aug 29, 2011 at 8:14 AM, Derek M Jones <derek@knosof.co.uk> wrote:
>
> Can people allay my concern that this work is not on the slippery
> slope leading to sparse becoming the recommended compiler for
> building the kernel?

That was never really a goal.

What *was* a goal for me a long time ago was to make sparse be a
"preprocessor" in front of gcc, because the standard C pre-processor
has always been weak and we've always abused it in nasty ways (look at
all the games we play with "sizeof" and "typeof" to make our
"kernel-C" have a kind of generic programming).

Having a semantically aware preprocessor would allow kernel-specific
type extensions (like the "__user" attribute we already use purely for
checking runs), and allow debug facilities like "trace accesses to
this variable" without having to have ugly and unreadable wrappers
etc.

But even that got put on the back-burner when gcc improved the
pre-processor performance. It used to be a separate phase, and quite
slow, and having a quick semantic analysis in front of cc1 that
replaced the gcc preprocessor wouldn't have been a big slow-down. But
with the new (well, no longer new) built-in pre-processor, a sparse
front-end would slow down kernel compiles noticeably.

The main reason I used to want to have a back-end was that without a
back-end you cannot really verify the front-end. You can read
"test-linearize" output all day long, you'll never really get very
far. Once you generate code, and can use the thing to actually compile
real programs, that gives you *way* more confidence that you're doing
things right.

                          Linus
