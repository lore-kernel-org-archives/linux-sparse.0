From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2] Add -ftabstop=WIDTH
Date: Sun, 04 Jan 2009 01:05:54 -0800
Message-ID: <7v1vvj1lvx.fsf@gitster.siamese.dyndns.org>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
 <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
 <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
 <7v7i5c7g5b.fsf@gitster.siamese.dyndns.org>
 <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbZADJGF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 4 Jan 2009 04:06:05 -0500
In-Reply-To: <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
 (Christopher Li's message of "Sat, 3 Jan 2009 15:19:31 -0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>

"Christopher Li" <sparse@chrisli.org> writes:

> While you are here. I have a question regarding how to publish patch series
> with git.
>
> Take this patch as example. I want to have some repository to allow
> others to pull the early version of the patch for testing. I also want
> to incorporate
> changes into the patch itself.

A short answer is that git itself does not offer an official, integrated
way to manage the life cycle of a patch series natively.  People seem to
use additional Porcelains such as StGIT and guilt for these things, and
they are good way to privately manage the evolution of a patch series, but
I do not know how good they are about publishing and working with others.

I however personally haven't felt much need for anything outside of what
is natively supported by git.

> If I am using patch series. That is easy, just republish a new series.

How?

> With git, I can:
> 1) always submit incremental changes to master branch. Then the patch will
>     be fragmented. I want the clean up version of the history.
> 2) Use rebase or cherry-pick to update the master branch. That will change
>     the history of the commit. it causes trouble for people who pull the earlier
>    version of the patch.
> 3) Always use a new branch to publish a new patch series. Then people who
>    pull it need to know which branch to pull. It seems that I want an alias for
>    the branch. On the client side it can use the same alias to pull different
>    branch. I haven't figure out how to do that with git yet.
>
> Any suggestions?

I won't claim to have the magic bullet, but I'll try to describe how I
have been managing the patches submitted to git.git tree for the last
three years.

First thing to realize is that a typical non-trivial patch series has
three distinct phases in its lifecycle:

 (1) A patch series is floated as "how about this" but it is still very
     rough.  Its design may be suboptimal, and/or its implementation may
     be too buggy even to be tried by somebody who is not very dedicated.

     After such initial showing, people will suggest improvements, pick
     nits, and even a total re-design.

 (2) After iterations, the series will start to solidify.  Its design
     becomes something that people can agree on, and the initial trivial
     mistakes in the implementation are corrected, even if neither the
     design nor the implementation is perfect.  In short, the series
     turns into a testable shape, and it becomes viable to have other
     people on board to further polish it.

     People will continue improve, pick nits but a total re-design and
     re-implementation becomes less likely at this point.

 (3) After further iterations, the series becomes worthy to be in the
     official release.  It would be feature complete and without an
     obvious cosmetic issues.

     There may still be further enhancements, but at this point, they are
     just that: further enhancements and improvements, not fixes to a
     showstopper.

I personally consider that keeping track of the history of the patch
series in its infancy (i.e. phase #1) is not worth the trouble.  Early
mistakes that need a total redoing from scratch are not something worthy
of being kept in the history in the longer term.  On the other hand, once
the series becomes more solid (i.e. phase #2), it becomes more worthwhile
to keep track of the incremental evolution of the series.  A series that
passed these phases (i.e. in phase #3) of course are worth keeping track
of the incremental evolution, too.

For this reason, git.git has two development integration branches, 'next' and 'pu'.

A new series is always applied to its own topic branch, that is forked
from the oldest applicable release branch (not to be confused with the
development integration branches), which is one of:

 - 'maint', which is forked from the last major release --- as of this
   writing, it was forked from v1.6.1;

 - 'maint-X.Y.Z', which is forked from the stable release that is worthy
   of maintaining for the long term, and that is older than what 'maint'
   was forked from --- as of this writing, I have such branches for v1.5.4,
   v1.5.5, v1.5.6 and v1.6.0 release.

 - 'master', which builds on top of the last stable release to prepare for
   the next majore release --- as of this writing, it is preparing for
   v1.6.2;

When the series is still in phase #1, it is not worth keeping track of its
incremental development.  You _could_ do it, but when the series is so
slushy that it can get a total rewriting any time, it is not really worth
the trouble, as the history will not be incremental anyway at that point.

I merge such a topic branch to the integration branch called 'pu' (stands
for 'proposed updates'), and let the development community aware of the
fact that 'pu' itself, and any topic branch that is only in 'pu', are
subject to be rewound and rebuilt from scratch.  In other words, nobody is
supposed to build on it.  'pu' is for highly motivated and interested
parties to check new topics out and take a look at it.

When an update appears on the list for a topic that is only in 'pu', it is
submitter's choice to make it incremental (in which case I'll simply apply
them on top of the existing topic branch), or a complete replacement.
However, the submitters are encouraged to send in a replacement patch for
such a topic if the earlier mistakes their follow-up patch fixes are of
trivial and stupid kind that is not worth keeping in the history.  I may
even use an incremental patch to amend the existing commit (i.e. squash
the fix in to erase early mistakes).

A topic that was only in 'pu', with enough effort and luck, eventually may
become solid enough and move to phase #2.  When that happens, the topic is
merged to another integration branch called 'next' (it does *NOT* stand
for 'will be in the next major release').  The promise between I and the
development community is that topics that are merged to 'next' will get
only incremental updates and never rewound.  From then on, the topic is
refined incrementally until perfection.

When the topic moves to phase #3, it is merged to the 'master' branch.
It may further be merged down to older maintenance branches after it
proves useful/correct in the field.

Many trivially correct patches do not fully go through the above process
and are applied directly to the oldest, relevant release branch, such as
'maint' or 'master'.  To integrate these changes upward, periodically, the
tip of 'maint' is merged to 'master', and the tip of 'master' is merged to
'next'.

In other words, 'next' is where the real incremental development happens.
It merges updates to topic branches that have passed phase #1 (iow, worthy
of developing incrementally) and also updates to more stable release
branches.

Each time 'next' is updated, 'pu' is first reset to the tip of it.  The
topics that are still slushy and kept out of 'next' are updated by
replacing the commits by replacement patches.  Then these topiocs are
merged to 'pu', essentially rebuilding 'pu' branch from scratch.

My suggestion, if you think keeping track of early mistakes is worth
doing, is to use a variant of the way 'pu' is managed.  Instead of
declaring the topics in it subject to rewinding and rebuilding, you keep
track of the changes to them incrementally.  My gut feeling is that this
will probably make the development history unmanageably messy when a topic
leaves phase #1 and becomes worthy of bing in phase #2, and you may choose
to tidy up the history with "rebase -i", making sure that the end result
stays the same, immediately before merging the topic to 'next'.

Although, as I said, I do not personally think it is worth the trouble.
