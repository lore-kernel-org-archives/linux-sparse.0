From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 12:03:41 -0700
Message-ID: <20090902190337.GB5148@josh-work.beaverton.ibm.com>
References: <20090830153202.4dc5c58c@s6510>
 <200909021353.17091.kdudka@redhat.com>
 <20090902152146.GA7881@feather>
 <200909021823.36662.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:38760 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbZIBTDM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 15:03:12 -0400
Content-Disposition: inline
In-Reply-To: <200909021823.36662.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org

On Wed, Sep 02, 2009 at 06:23:36PM +0200, Kamil Dudka wrote:
> On Wednesday 02 of September 2009 17:21:46 Josh Triplett wrote:
> > Typo.  I meant ENUM_TYPE_A:
> >
> >     var_a = (enum ENUM_TYPE_A) 0;
> >
> > Hopefully that makes more sense as an "always OK" test. :)
> >
> > Another crazy test for the "always OK" section:
> >
> >     anon_enum_var = (__typeof__(anon_enum_var)) 0;
> >     anon_enum_var = (__typeof__(anon_enum_var)) VALUE_A;
> 
> All three cases pass for me, even with -Wenum-to-int. No problem here.

Great.  I didn't expect any of them to fail with your patch; I primarily
suggested them to cover strange corner cases that might occur in future
regressions.

> > > -	warn_for_different_enum_types (old->pos, old->ctype, type);
> > > +	warn_for_different_enum_types (old->pos, old->ctype, type,
> > > +				       old->enum_type);
> >
> > At this point, it might make more sense to just pass old, rather than
> > three of its fields.  Would that work for the other callers of this
> > function?  In any case, that change can wait until after this patch.
> 
> At first glance the only change would be in usual_conversions() in reporting 
> slightly different location in some rear cases -- no big deal I think.
> 
> But in fact I haven't investigated yet how to trigger all the particular 
> possibilities of warn_for_different_enum_types() invocation to test this 
> properly. I'll give it a try later today.

Don't worry about this change.  I only suggested it as a potential
simplification, but it doesn't need to happen as part of this patch.
I'd rather see the patch get merged in its current form (plus the test
suite additions), rather than poking at simplifications like this that
don't immediately prove trivial.  Those can always happen later. :)

> > > +	warn_for_enum_to_int_cast (old, type);
> > > +	warn_for_int_to_enum_cast (old, type);
> >
> > I just realized that both of these functions need renaming as well:
> > s/cast/conversion/ or similar.  As with the manpage changes before,
> > "cast" describes the case it *doesn't* warn about.
> 
> My line of thinking was "implied vs. explicit cast" ... but I am fine with
> the rename. It'll be more obvious.

To me, "cast" always suggests "explicit cast".

> > You could include this test case in the patch, as an addition to the
> > test suite.
> 
> No problem I think. We have generally two choices:
> 
>     1) The whole current test-enum.c as a test-case running with all three
>        warnings enabled.
> 
>     2) Split the test to three parts, each for one separate -W option, and
>        then run it as three separate test-cases.
> 
> I think the second choice has better coverage. What's your opinion?

Either one seems fine; I don't think splitting the test case helps
coverage, and keeping it together lets you use the same declarations for
the entire test case as you did in the previously attached version.
However, I wonder if it would make sense to have the same test case run
multiple times with different warning options and correspondingly
different output, to make sure the warnings stay associated with the
right flag?  Given the current test framework, that would unfortunately
involve some duplication, but it still seems worth doing.

- Josh Triplett
