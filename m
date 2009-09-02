From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 21:58:14 +0200
Message-ID: <200909022158.14425.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <20090902185644.GA5148@josh-work.beaverton.ibm.com> <alpine.LNX.2.00.0909021458180.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40269 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbZIBT71 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 15:59:27 -0400
In-Reply-To: <alpine.LNX.2.00.0909021458180.28290@iabervon.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org

On Wednesday 02 of September 2009 21:19:46 Daniel Barkalow wrote:
> On Wed, 2 Sep 2009, Josh Triplett wrote:
> > On Wed, Sep 02, 2009 at 02:43:52PM -0400, Daniel Barkalow wrote:
> > > On Wed, 2 Sep 2009, Kamil Dudka wrote:
> > > > On Wednesday 02 of September 2009 19:56:47 Daniel Barkalow wrote:
> > > > > It feels to me like the explicit numeric values are what make these
> > > > > constants sensible to use directly as ints, and that it's only
> > > > > sensible to use a non-constant value of an enum type as an int
> > > > > (without an explicit cast) if all of the enum values have explicit
> > > > > numeric values.
> > > > >
> > > > > I think:
> > > > >
> > > > >   enum {
> > > > >     my_register_zero
> > > > >     ...
> > > > >     my_register_twdr
> > > > >     my_register_twcr
> > > > >     ...
> > > > >   };
> > > > >
> > > > >   void () {
> > > > >     write_register(my_register_twdr, SETUP_TWDR);
> > > > >   }
> > > > >
> > > > > is asking for trouble in a way that this warning is about.
> > > >
> > > > Both examples are too abstract for me -- missing declaration
> > > > of write_register(), etc. Please attach a minimal example as a file
> > > > which I can compile and test. I'll check if the "trouble" is covered
> > > > by the warnings or not, and perhaps implement what's missing. Thanks
> > > > in advance!
> > >
> > > enum {
> > >   foo,
> > >   bar
> > > };
> > >
> > > enum {
> > >   baz = 1,
> > >   qux = 2
> > > };
> > >
> > > void test(void) {
> > >   int i = bar; // warn on this
> > >   int j = qux; // okay
> > > }
> > >
> > > (Leaving aside the issue of whether the enum is anonymous)
> > >
> > > In the "bar" case, an additional value added somewhere in the list
> > > (particularly if the list were long) might change "i" in a way that
> > > wouldn't necessarily be obvious to users of "i". In the "qux" case, "j"
> > > would only change if the "qux = 2" line were changed.
> >
> > I disagree with this.  In both cases, you've declared an anonymous enum,
> > and then used its values as constants.  In the former case, you might
> > just not care about the values except to compare against each other;
> > granted, you ought to use a named enum rather than an int in that case,
> > but nevertheless much code exists that uses int instead of enum types.
>
> I think anonymous vs named enums are one thing that should affect whether
> you get a warning, and explicit values vs implicit values are another
> factor, but I don't have an opinion on which way they should combine.
> Probably either using an explicit value or an anonymous enum should be
> okay by default, and the test above should use named enums.

I think type-checking is the way to go, not values checking... Once you start 
to count with "explicit" vs. "implicit" enum values, you will sooner or later 
run in troubles like this:

enum { A, B = 3, C, D = A + 7 };
enum { Z = (C < D) ? A : B };

Kamil
