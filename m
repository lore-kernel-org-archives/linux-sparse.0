From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 18:22:53 +0100
Message-ID: <20061001172253.GX29920@ftp.linux.org.uk>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk> <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org> <Pine.LNX.4.64.0610010934590.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:14215 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932073AbWJARWx
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 13:22:53 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610010934590.3952@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Oct 01, 2006 at 09:52:31AM -0700, Linus Torvalds wrote:
> (Now, it's entirely possible that we warn so early that we can't 
> reasonably do this optimization until after we've already warned, but I've 
> been able to remove these kinds of warnings before, so I think it should 
> be possible to do it here too).
> 
> I much prefer (if possible) the "make sparse so much smarter that it sees 
> that it's ok" approach over "let's add a magic special case". For example, 
> a lot of the work I did to make the lock acquire/release logic useful was 
> very much about teaching sparse to simplify code-flow rather than anything 
> else.
> 
> But hey, maybe this case is too hard or nasty..

Hrm...  The gut feeling: we mangle expression trees too much to be able
to do that decently.

We would have to carry "this might be le16"/"this might be be16"/"this
might be foo_t" up *anyway*.  Because what we see several nodes up is
be16 | int.  And even if we guess that it might be expanded 16bit,
we _still_ need to know which 16bit it was.  So you have to propagate
that up and that's exactly what I'm doing.

"Find how much we could narrow it" is a separate question; _that_ is
best done by moving the casts down.  But I would not mix that with
type warnings.  We _do_ mangle the tree a lot, so by the time we
start walking down, we might have large chunks in a very inconvenient
shape.

The bottom line: your variant either requires to carry "which 16bit
it might have been" along with the expression type (in which case it's
exactly what I've done, modulo data representation), _OR_ it requires
3 passes - normal type evaluation + walking down trying to narrow the
things down + walking up *again* trying to generate those postponed
warnings.  Because you won't be able to do them on the second pass -
not enough information.

I'd rather handle them on the first pass when we can easily do that
and then do exact equivalent of the second pass (top to bottom) of
your approach.  Endianness type checks can be easily combined with
the first pass, but not with the second...
