From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 10:33:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610011031280.3952@g5.osdl.org>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk> <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org>
 <Pine.LNX.4.64.0610010934590.3952@g5.osdl.org> <20061001172253.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:23261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932118AbWJAReL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 13:34:11 -0400
In-Reply-To: <20061001172253.GX29920@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org



On Sun, 1 Oct 2006, Al Viro wrote:
> 
> Hrm...  The gut feeling: we mangle expression trees too much to be able
> to do that decently.

Having looked at it a bit now, I think I agree.

We warn about the whole "~" thing too early, so we'd have to remove that 
warning anyway (easy enough to do), but then we'd have to track the ops 
that don't like using a "~" because of its C semantics.

And at that point, your "fouled" bit is actually probably simpler.

Let me think about this a bit more, but I'm starting to think that you're 
right.

As usual.

		Linus
