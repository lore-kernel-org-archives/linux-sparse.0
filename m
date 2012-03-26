From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Killing off __cond_lock()
Date: Mon, 26 Mar 2012 02:29:35 -0700
Message-ID: <20120326092935.GB21202@leaf>
References: <1332606216.16159.48.camel@twins>
 <1332665310.3840.8.camel@jlt3.sipsolutions.net>
 <1332749494.16159.74.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41379 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933Ab2CZJ3n (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2012 05:29:43 -0400
Content-Disposition: inline
In-Reply-To: <1332749494.16159.74.camel@twins>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>

On Mon, Mar 26, 2012 at 10:11:34AM +0200, Peter Zijlstra wrote:
> On Sun, 2012-03-25 at 10:48 +0200, Johannes Berg wrote:
> > But I was also trying to make sparse actually evaluate the first
> > argument so it could tell the difference between two locks, which you
> > might not even care about ... (it would be nice though I think)
> 
> Right, so what I thought we could maybe do is inject code in the
> callsites of these functions.
> 
> So after the OP_CALL emit a piece of code that works like the
> __context__ stmt and can reference the return value that exists at that
> point.
> 
> This also makes the conditional thing quite simple to do.

For the general case, this seems like roughly the right solution.  That
will also handle slightly more complex conditionals, though
significantly more complex ones will just get sparse complaining that
you can reach later code with multiple contexts.

Similarly, require_context might work better as an expression executed
beforehand, which would ideally have access to the arguments.

I don't know if it makes sense to put an __attribute__((__after_expr__,
arbitrary_expression)) into sparse just to avoid doing the same thing
with a macro or static inline, though.  A macro or static inline
trivially has access to the arguments and return value, and can run
arbitrary statements/expressions either before or after the underlying
function call, including conditionals.

(Even better if sparse could just always do whole-program analysis, so
that you could include the __context__ call inline in the normal
function and have the caller see it, but that won't happen anytime
soon.)

- Josh Triplett
