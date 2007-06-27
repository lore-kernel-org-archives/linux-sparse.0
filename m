From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Thu, 28 Jun 2007 07:50:41 +0900
Message-ID: <20070627225041.GF16758@daikokuya.co.uk>
References: <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org> <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk> <467F531A.3030702@freedesktop.org> <20070626221040.GI21478@ftp.linux.org.uk> <20070626221134.GA21350@ftp.linux.org.uk> <20070627121021.GQ7590@daikokuya.co.uk> <alpine.LFD.0.98.0706270910000.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7486 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1761267AbXF0Wuo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 18:50:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706270910000.8675@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Josh Triplett <josh@freedesktop.org>, Segher Boessenkool <segher@kernel.crashing.org>, linux-sparse@vger.kernel.org

Linus Torvalds wrote:-

> > extern int f(void);
> > enum { cast_to_ptr = (int) (void *) 0 };
> > enum { cast_to_float = (int) (double) 1 };
> 
> Those two *really* shouldn't fail. I don't care if the C standard says so, 
> that is *fine*.
> 
> In particular, "offsetof()" should be portably able to basically be the 
> standard #define, which involves an integer cast from a constant pointer. 
> That had *better* be a valid constant integer expression, because it's 
> very useful.
> 
> And I think standards can go screw themselves, and you can make it an 
> error with some "--standard-pedantic" switch or similar.
> 
> Standards are just random pieces of paper, for crying out loud! They have 
> zero relevance in the end. 
> 
> > enum { fncall = 0 ? f(): 3 };
> 
> Again, I think that's a deficiency of a standard that tries to be 
> acceptable to everybody rather than about a "really good language".

Yes, I think what you're saying is widely understood.  However I think
Al's original goal was to do strictly what the standard said, and then
maybe loosen up parts than arguably make sense much like you describe.

My examples were just to help him get semantics matching a strict
reading of the standard, not suggest what the default handling might
be or what is actually a good idea in practice.  I think if you don't
follow the "strictly correct then loosen up" approach it's easy to
get an ill-defined end result, much like current GCC.

Neil.
