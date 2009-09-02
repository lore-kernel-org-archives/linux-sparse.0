From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 14:43:52 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909021419500.28290@iabervon.org>
References: <20090830153202.4dc5c58c@s6510> <20090901172708.286657ec@nehalam> <alpine.LNX.2.00.0909021313190.28290@iabervon.org> <200909022004.42548.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from iabervon.org ([66.92.72.58]:47714 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbZIBSnu (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 14:43:50 -0400
In-Reply-To: <200909022004.42548.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Wed, 2 Sep 2009, Kamil Dudka wrote:

> On Wednesday 02 of September 2009 19:56:47 Daniel Barkalow wrote:
> > It feels to me like the explicit numeric values are what make these
> > constants sensible to use directly as ints, and that it's only sensible to
> > use a non-constant value of an enum type as an int (without an explicit
> > cast) if all of the enum values have explicit numeric values.
> >
> > I think:
> >
> >   enum {
> >     my_register_zero
> >     ...
> >     my_register_twdr
> >     my_register_twcr
> >     ...
> >   };
> >
> >   void () {
> >     write_register(my_register_twdr, SETUP_TWDR);
> >   }
> >
> > is asking for trouble in a way that this warning is about.
> 
> Both examples are too abstract for me -- missing declaration
> of write_register(), etc. Please attach a minimal example as a file which I 
> can compile and test. I'll check if the "trouble" is covered by the warnings 
> or not, and perhaps implement what's missing. Thanks in advance!

enum {
  foo,
  bar
};

enum {
  baz = 1,
  qux = 2
};

void test(void) {
  int i = bar; // warn on this
  int j = qux; // okay
}

(Leaving aside the issue of whether the enum is anonymous)

In the "bar" case, an additional value added somewhere in the list 
(particularly if the list were long) might change "i" in a way that 
wouldn't necessarily be obvious to users of "i". In the "qux" case, "j" 
would only change if the "qux = 2" line were changed.

	-Daniel
*This .sig left intentionally blank*
