From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 1/4] Compile sparse executable under it's own name, not
	as "check"
Date: Mon, 06 Nov 2006 18:58:25 -0500
Message-ID: <1162857505.24303.6.camel@dv>
References: <20061103221659.7811.73832.stgit@dv.roinet.com>
	 <454F83D8.9030204@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:18869 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1753843AbWKFX62
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Nov 2006 18:58:28 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GhEMF-0004Mb-Ot
	for linux-sparse@vger.kernel.org; Mon, 06 Nov 2006 18:58:27 -0500
In-Reply-To: <454F83D8.9030204@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Hi Josh,

On Mon, 2006-11-06 at 10:50 -0800, Josh Triplett wrote:
> Regarding your comment about using "make check" for something more useful, I
> would greatly welcome a patch which actually checked sparse against all the
> files in validation/ and tested what those files intended to test.  As far as
> I can tell, it looks like some of them may not work as intended right now; for
> example, it looks like validation/builtin_safe1.c expects
> __attribute__((pure)) and __attribute__((const)) to work and mark a function
> as side-effect-free, which doesn't currently happen in sparse.

I've just mailed a very primitive testsuite.

I would prefer to have a test list and lists for "should be bad" and
"known to fail", but it would have to use double loops or some shell
tricks (e.g. using environment variables as a hash), so I opted for the
simplest approach for now.

By the way, I'm not sure how to distinguish sparse errors from sparse
warnings short of grepping stderr.  For now, any stderr output is an
error.

-- 
Regards,
Pavel Roskin
