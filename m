From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 14:31:58 -0700
Message-ID: <CA+55aFxxNJ_wKO+2qDxP_o398jkoyL9PqdcHe4zzzKKcjh+pZw@mail.gmail.com>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
	<CA+55aFxeSzQuF7RR5jDcwwGeL0XFTRsLWe+X0=ybVPAsAkggBA@mail.gmail.com>
	<20130817205554.GH30769@thunk.org>
	<CA+55aFyB9C9iT1vH+Gbhn+cVPCN7AA+r3wuQBc31NJBvt19d3w@mail.gmail.com>
	<20130817212326.GI30769@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:52614 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab3HQVb7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 17:31:59 -0400
In-Reply-To: <20130817212326.GI30769@thunk.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 17, 2013 at 2:23 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Ah, I see.  But as we start adding the RCU annotations and the calls
> to rcu_derference(), then I imagine we'll start triggering warnings
> from various other static analysis tools, even if it makes sparse happy.

Yes. I suspect the patch I sent out might need some tweaking to make
the dynamic RCU accessor checkers happy.

That said, it's probably fairly simple. I think my patch was *almost*
correct, and the only required change would be to change the two
occurrences of

    rcu_dereference(*p);

in "get_cached_acl()" into a "rcu_dereference_protected(*p, true)" in
order to avoid the RCU read-lock sanity checking.

The second access is actually under the i_lock (so the "protected"
part is clearly correct), and as mentioned, the first one is special
and we only use the value if it is NULL, so the "protected" is not
technically true, but it's a special case, and together with a comment
about why NULL is fine and doesn't need rcu locking it should all be
good.

The alternative is to basically say that the ACL pointers aren't
really RCU at all, and just use ACCESS_ONCE() like we do. And then
just cast things in get_cached_acl_rcu() to shut things up.

                  Linus
