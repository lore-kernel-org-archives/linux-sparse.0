From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 09:52:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610010934590.3952@g5.osdl.org>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk> <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:21971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751280AbWJAQwq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 12:52:46 -0400
In-Reply-To: <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org



On Sun, 1 Oct 2006, Linus Torvalds wrote:
>
> See? Even from a purely optimization angle, we're actually better off just 
> noticing that the whole comparison can be done in the narrower type.

So here's a test-case:

	typedef unsigned short le16;

	int cmp(le16 a, le16 b)
	{
		return a == (a & ~b);
	}

and doing a "./test-linearize" on this gets us:

	cmp:
	.L0xf7fa500c:
	        <entry-point>
	        dead        %arg1
	        scast.32    %r2 <- (16) %arg1
	        dead        %arg2
	        scast.32    %r6 <- (16) %arg2
	        dead        %r6
	        not.32      %r7 <- %r6
	        dead        %r7
	        and.32      %r8 <- %r2, %r7
	        dead        %r8
	        dead        %r2
	        seteq.32    %r9 <- %r2, %r8
	        dead        %r9
	        scast.32    %r10 <- (1) %r9
	        dead        %r10
	        ret.32      %r10

which is just horrible code anyway.

I think it _should_ be

	cmp:
	.L0xf7fa500c:
	        <entry-point>
	        dead        %arg2
	        not         %r4 <- %arg2
	        dead        %r4
	        and         %r5 <- %arg1, %r4
	        dead        %r5
	        dead        %arg1
	        seteq.16    %r6 <- %arg1, %r5
	        dead        %r6
	        scast.32    %r7 <- (1) %r6
	        dead        %r7
	        ret.32      %r7

instead, which is obviously smaller and avoids the two unnecessary casts.

(Now, it's entirely possible that we warn so early that we can't 
reasonably do this optimization until after we've already warned, but I've 
been able to remove these kinds of warnings before, so I think it should 
be possible to do it here too).

I much prefer (if possible) the "make sparse so much smarter that it sees 
that it's ok" approach over "let's add a magic special case". For example, 
a lot of the work I did to make the lock acquire/release logic useful was 
very much about teaching sparse to simplify code-flow rather than anything 
else.

But hey, maybe this case is too hard or nasty..

		Linus
