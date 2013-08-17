From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 14:14:45 -0700
Message-ID: <CA+55aFyB9C9iT1vH+Gbhn+cVPCN7AA+r3wuQBc31NJBvt19d3w@mail.gmail.com>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
	<CA+55aFxeSzQuF7RR5jDcwwGeL0XFTRsLWe+X0=ybVPAsAkggBA@mail.gmail.com>
	<20130817205554.GH30769@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:52486 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab3HQVOq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 17:14:46 -0400
In-Reply-To: <20130817205554.GH30769@thunk.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 17, 2013 at 1:55 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>
> I may be missing something, but it looks like the ACL code isn't
> following the RCU rules at _all_.  Even with the missing
> rcu_derference() macro invocations which you added in your
> proof-of-concept patch, we're still missing the rcu_read_lock() calls
> around the use of the rcu pointers.
>
> If so, I'm kind of wondering why we haven't noticed massive problems
> here before.

Yeah, the ACL caches aren't really using RCU, although they should
probably be made to use it more widely.

The ACL cache is this mixture of an unlocked "ACCESS_ONCE()" to check
for the very special case of NULL (which is a "negative ACL cache" -
no ACL's at all), and an atomic reference count that is gotten under
i_lock. See get_cached_acl() for details.

The "unlocked ACCESS_ONCE()" case is basically an optimization for the
"no ACL's case" - it isn't actually racy despite the lack of locking,
because if you see a NULL ACL pointer, that *was* true at some time,
so if it "races" with somebody setting it to anything else, you might
as well just choose to pick that simpler state.

So anybody using "get_cached_acl()" is safe. It gets either a locked
ref-counted ACL pointer, or an unlocked optimistic NULL pointer.

There is *one* special case that is actually truly using RCU, namely
"get_cached_acl_rcu()".  And that one *is* used under the RCU read
lock (it's the RCU lock for lookup). That is all safe because the
ACL's are free'd by kfree_rcu() (see posix_acl_release()).

So the ACL accesses are this somewhat strange mix of RCU and non-RCU
use. We probably could make *more* of them use the RCU model, but
apart from the RCU pathname lookup nothing else has ever been critical
enough to care.

                   Linus
