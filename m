From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 14:23:43 -0700
Message-ID: <CA+55aFwYv4EKRD0diPWE-7jC6-djmKEpUUfspDJZg_3iEi1-Gw@mail.gmail.com>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
	<CA+55aFxeSzQuF7RR5jDcwwGeL0XFTRsLWe+X0=ybVPAsAkggBA@mail.gmail.com>
	<20130817205554.GH30769@thunk.org>
	<CA+55aFyB9C9iT1vH+Gbhn+cVPCN7AA+r3wuQBc31NJBvt19d3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:55724 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab3HQVXo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 17:23:44 -0400
In-Reply-To: <CA+55aFyB9C9iT1vH+Gbhn+cVPCN7AA+r3wuQBc31NJBvt19d3w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 17, 2013 at 2:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the ACL accesses are this somewhat strange mix of RCU and non-RCU
> use. We probably could make *more* of them use the RCU model, but
> apart from the RCU pathname lookup nothing else has ever been critical
> enough to care.

Side note: the whole concept of mixing locking *and* RCU is a bit odd,
but it has turned out to be a very successful model for pathname
lookup. Doing everything under RCU is basically impossible, so having
the ability to looking things up under RCU for the simple case, but
then falling back on locking for complex cases is very very powerful.

So arguably that "somewhat strange mix of RCU and non-RCU use"
shouldn't really be strange. It's just that it is complicated enough
that we only use it for pathnames right now. Everything else tends to
be more black-and-white and do one or the other, not both.

                Linus
