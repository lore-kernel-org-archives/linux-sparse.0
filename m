From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 17:23:26 -0400
Message-ID: <20130817212326.GI30769@thunk.org>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
 <CA+55aFxeSzQuF7RR5jDcwwGeL0XFTRsLWe+X0=ybVPAsAkggBA@mail.gmail.com>
 <20130817205554.GH30769@thunk.org>
 <CA+55aFyB9C9iT1vH+Gbhn+cVPCN7AA+r3wuQBc31NJBvt19d3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:45140 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab3HQVXb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 17:23:31 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyB9C9iT1vH+Gbhn+cVPCN7AA+r3wuQBc31NJBvt19d3w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 17, 2013 at 02:14:45PM -0700, Linus Torvalds wrote:
> 
> So anybody using "get_cached_acl()" is safe. It gets either a locked
> ref-counted ACL pointer, or an unlocked optimistic NULL pointer.

Ah, I see.  But as we start adding the RCU annotations and the calls
to rcu_derference(), then I imagine we'll start triggering warnings
from various other static analysis tools, even if it makes sparse happy.

> So the ACL accesses are this somewhat strange mix of RCU and non-RCU
> use. We probably could make *more* of them use the RCU model, but
> apart from the RCU pathname lookup nothing else has ever been critical
> enough to care.

Ugh.  OK, I care mostly because it's adding noise to my make C=1 runs,
but I'm not sure I care enough to fix it up right away.  I'll put it
on my todo list, and hope someone beats me to it.  :-)

         	   	     	  	  - Ted
