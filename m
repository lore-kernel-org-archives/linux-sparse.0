From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH v2] Add -ftabstop=WIDTH
Date: Tue, 6 Jan 2009 16:37:12 -0800
Message-ID: <70318cbf0901061637l29837d14nfaa8a3106652b7e5@mail.gmail.com>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
	 <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
	 <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
	 <7v7i5c7g5b.fsf@gitster.siamese.dyndns.org>
	 <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
	 <7v1vvj1lvx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:34171 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbZAGAhN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Jan 2009 19:37:13 -0500
Received: by rv-out-0506.google.com with SMTP id f9so7178261rvb.7
        for <linux-sparse@vger.kernel.org>; Tue, 06 Jan 2009 16:37:12 -0800 (PST)
In-Reply-To: <7v1vvj1lvx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>

Thank you very much for the detail explain of how you manage the git
release with
different branches. That is very helpful to me.

On Sun, Jan 4, 2009 at 1:05 AM, Junio C Hamano <junio@pobox.com> wrote:
>
>> If I am using patch series. That is easy, just republish a new series.
>
> How?

This is how Andrew Morton manage his -mm series. The heavy lifting
is done out side of git. As my understand,  Andrew using his own patch-series
script to manage changes in a series of patches. There is a series
file descriptor
what patch files are going to apply in to the tree. The patches can be
easily modify
(using push/pop/refresh) or drop out from the series completely. When Andrew
release a new "-mm" series. He just import the series into a git
branch and publish
that. The git repository is just a handy ftp replacement.

So my question can be simplify as, can I do what Andrew Morton do with his "-mm"
series using pure git?

> I won't claim to have the magic bullet, but I'll try to describe how I
> have been managing the patches submitted to git.git tree for the last
> three years.
>
> First thing to realize is that a typical non-trivial patch series has
> three distinct phases in its lifecycle:
>
>  (1) A patch series is floated as "how about this" but it is still very
>     rough.  Its design may be suboptimal, and/or its implementation may
>     be too buggy even to be tried by somebody who is not very dedicated.
>
>     After such initial showing, people will suggest improvements, pick
>     nits, and even a total re-design.
>
>  (2) After iterations, the series will start to solidify.  Its design
>     becomes something that people can agree on, and the initial trivial
>     mistakes in the implementation are corrected, even if neither the
>     design nor the implementation is perfect.  In short, the series
>     turns into a testable shape, and it becomes viable to have other
>     people on board to further polish it.
>
>     People will continue improve, pick nits but a total re-design and
>     re-implementation becomes less likely at this point.
>
>  (3) After further iterations, the series becomes worthy to be in the
>     official release.  It would be feature complete and without an
>     obvious cosmetic issues.
>
>     There may still be further enhancements, but at this point, they are
>     just that: further enhancements and improvements, not fixes to a
>     showstopper.

I totally agree with the 3 stage of the patch life cycle.

>
> I personally consider that keeping track of the history of the patch
> series in its infancy (i.e. phase #1) is not worth the trouble.  Early

I agree it is not worth while to keep the too early history. That is not
the problem. This problem is if I publish those early changes, others might
have pull from it. Then it come troublesome to modify the patch itself.

I can have clean patch history and it cause conflict when others sync to it.
Or I can have fragmented patch history(using incremental commit) but
others can sync to it smoothly. I can't have both.

> mistakes that need a total redoing from scratch are not something worthy
> of being kept in the history in the longer term.  On the other hand, once
> the series becomes more solid (i.e. phase #2), it becomes more worthwhile
> to keep track of the incremental evolution of the series.  A series that
> passed these phases (i.e. in phase #3) of course are worth keeping track
> of the incremental evolution, too.
>
> For this reason, git.git has two development integration branches, 'next' and 'pu'.

So here is my understanding of what you described. The 'pu' branch is for
highly experiment changes. The 'pu' branch can rewind and rewrite the
history. Once the patch merge to 'next', the history will not change any more.
All update will stay as incremental changes.

One question, does user suffer from conflict when then pull from the 'pu'
branch?

> My suggestion, if you think keeping track of early mistakes is worth
> doing, is to use a variant of the way 'pu' is managed.  Instead of

I don't care that much about keeping track of early mistakes. I just want to:
1) publish early.
2) able to fix the early mistake and maintain the history clean.

I think I will just adopt the 'pu' branch approach and declare that
'pu' branch might need rewind.

> declaring the topics in it subject to rewinding and rebuilding, you keep
> track of the changes to them incrementally.  My gut feeling is that this
> will probably make the development history unmanageably messy when a topic
> leaves phase #1 and becomes worthy of bing in phase #2, and you may choose
> to tidy up the history with "rebase -i", making sure that the end result
> stays the same, immediately before merging the topic to 'next'.
>
> Although, as I said, I do not personally think it is worth the trouble.

Thanks again for the suggestion. A 'pu' branch make sense.

I have some thought about cleaning the history without using a different branch.
When a patch come in, we often have pretty good idea how ready this patches
is. However, it is kind of arbitrate which stage it is in as well. Because once
it to to 'next' branch, there is no coming back. I might regret I
merge a patch to
'next' too early.

Here is an idea, I am just thinking it out loud.

Given 'pu' branch like this, (each [ ] is a commit, A1 is a follow up change for
A0).

'pu' branch: [A0] - [B0] - [A1] - [C0] -[B1] -[A2]

We can have a temporary clean up branch fork from 'pu' looks like this:

'tmp_clean' branch: [A0 + A1 + A2] - [B0 + B1] - [C0]

 'tmp_clean' and 'pu' will generate exactly the same tree. The
only different is the history path it take to get there.

Then we can have 'pu' merge from 'tmp_clean', with zero text
changes. The only change is the change log and we tell git
that the merge is for history clean up. So when we launch
"git log", by default it will follow the "tmp_clean" path rather
than the original "pu" path.

So it just provide "alternative" view of the history without introduce
real changes. When user pull from 'pu', it can automatically get the
cleanup version of the history without introduce conflicts.

It seems it can have the best of both worlds. I am not sure weather
it is doable or worth while to do though.

Chris
