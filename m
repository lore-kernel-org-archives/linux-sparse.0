From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 18:23:36 +0200
Message-ID: <200909021823.36662.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200909021353.17091.kdudka@redhat.com> <20090902152146.GA7881@feather>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12404 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbZIBQYk (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 12:24:40 -0400
In-Reply-To: <20090902152146.GA7881@feather>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org

On Wednesday 02 of September 2009 17:21:46 Josh Triplett wrote:
> Typo.  I meant ENUM_TYPE_A:
>
>     var_a = (enum ENUM_TYPE_A) 0;
>
> Hopefully that makes more sense as an "always OK" test. :)
>
> Another crazy test for the "always OK" section:
>
>     anon_enum_var = (__typeof__(anon_enum_var)) 0;
>     anon_enum_var = (__typeof__(anon_enum_var)) VALUE_A;

All three cases pass for me, even with -Wenum-to-int. No problem here.

> > -	warn_for_different_enum_types (old->pos, old->ctype, type);
> > +	warn_for_different_enum_types (old->pos, old->ctype, type,
> > +				       old->enum_type);
>
> At this point, it might make more sense to just pass old, rather than
> three of its fields.  Would that work for the other callers of this
> function?  In any case, that change can wait until after this patch.

At first glance the only change would be in usual_conversions() in reporting 
slightly different location in some rear cases -- no big deal I think.

But in fact I haven't investigated yet how to trigger all the particular 
possibilities of warn_for_different_enum_types() invocation to test this 
properly. I'll give it a try later today.

> > +	warn_for_enum_to_int_cast (old, type);
> > +	warn_for_int_to_enum_cast (old, type);
>
> I just realized that both of these functions need renaming as well:
> s/cast/conversion/ or similar.  As with the manpage changes before,
> "cast" describes the case it *doesn't* warn about.

My line of thinking was "implied vs. explicit cast" ... but I am fine with
the rename. It'll be more obvious.

> > --- a/sparse.1
> > +++ b/sparse.1
> > @@ -149,6 +149,19 @@ Sparse issues these warnings by default.  To turn
> > them off, use \fB\-Wno\-enum\-mismatch\fR.
> >  .
> >  .TP
> > +.B \-Wenum\-to\-int
> > +Warn about converting an \fBenum\fR type to int. An explicit cast to int
> > will +suppress this warning.
> > +.
> > +.TP
> > +.B \-Wint\-to\-enum
> > +Warn about converting int to \fBenum\fR type. An explicit cast to the
> > right +\fBenum\fR type will suppress this warning.
> > +
> > +Sparse issues these warnings by default.  To turn them off, use
> > +\fB\-Wno\-int\-to\-enum\fR.
>
> This manpage text looks good to me.

Thanks for review!

> You could include this test case in the patch, as an addition to the
> test suite.

No problem I think. We have generally two choices:

    1) The whole current test-enum.c as a test-case running with all three
       warnings enabled.

    2) Split the test to three parts, each for one separate -W option, and
       then run it as three separate test-cases.

I think the second choice has better coverage. What's your opinion?

Kamil
