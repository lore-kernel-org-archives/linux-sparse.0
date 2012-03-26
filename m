From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Killing off __cond_lock()
Date: Mon, 26 Mar 2012 11:00:37 +0200
Message-ID: <1332752437.7081.5.camel@jlt3.sipsolutions.net>
References: <1332606216.16159.48.camel@twins>
	 <1332665310.3840.8.camel@jlt3.sipsolutions.net>
	 <1332749494.16159.74.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:53013 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab2CZJAq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2012 05:00:46 -0400
In-Reply-To: <1332749494.16159.74.camel@twins>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>

On Mon, 2012-03-26 at 10:11 +0200, Peter Zijlstra wrote:

> > However, note that today sparse doesn't evaluate anything in the
> > context, it doesn't even look at the first argument. So another thing
> > you can't really annotate well is things like this:
> > 
> > struct foo_object *get_locked_object(...);
> > 
> > This is why I used RETURN to give the return value a name, so you could
> > write
> > 	__acquires(&RETURN->lock)
> 
> 
> Right, but if it doesn't actually evaluate the expression used in the
> context this is going to be problematic.

It probably could -- but the question is what context to evaluate it in.

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

Indeed, but you'd need some sort of expression rewriting. Consider

void lock_obj(obj_t *o) __acquires(&o->lock);

void lock_obj(obj_t *obj)
{
	__acquire(&obj->lock);

	...
}


void foo(void)
{
	...
	lock_obj(&f);
	...
	unlock_obj(&f);
	...
}


Now you suddenly need to replace "&o->lock" with "&(&f)->lock", when
checking the function itself it really is called "obj", not "o". Not
that sparse actually checks that the function behaviour matches the
declaration today though.

johannes


PS: Something else I had wanted to remind you of: the cond_lock thing
only works due to some sort of optimiser pass (is there such a thing?)
in sparse, sometimes it fails mysteriously because the condition isn't
the exact same condition or something.


