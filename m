From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 16:55:54 -0400
Message-ID: <20130817205554.GH30769@thunk.org>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
 <CA+55aFxeSzQuF7RR5jDcwwGeL0XFTRsLWe+X0=ybVPAsAkggBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:45130 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab3HQUz6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 16:55:58 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxeSzQuF7RR5jDcwwGeL0XFTRsLWe+X0=ybVPAsAkggBA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 17, 2013 at 09:16:54AM -0700, Linus Torvalds wrote:
> On Sat, Aug 17, 2013 at 7:28 AM, Theodore Ts'o <tytso@thunk.org> wrote:
> >
> > It apparently has something to do with rcu and "address spaces" but I'm
> > not completely sure what sparse is complaining about --- and whether it
> > is a false positive or a bug in the posix_acl.h.
> 
> I guess we should mark i_acl and i_defauly_acl to be RCU-accessed, and
> then annotate all the accesses properly.

I may be missing something, but it looks like the ACL code isn't
following the RCU rules at _all_.  Even with the missing
rcu_derference() macro invocations which you added in your
proof-of-concept patch, we're still missing the rcu_read_lock() calls
around the use of the rcu pointers.

If so, I'm kind of wondering why we haven't noticed massive problems
here before.

						- Ted
