From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sun, 16 Aug 2009 13:00:30 -0700
Message-ID: <20090816200030.GB9586@feather>
References: <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
 <1250367991.14751.1.camel@penberg-laptop>
 <20090815223602.GA4516@feather>
 <1250406233.32343.9.camel@penberg-laptop>
 <20090816105114.GA6489@feather>
 <1250420733.9535.1.camel@penberg-laptop>
 <20090816124157.GA6936@feather>
 <70318cbf0908161050w4b95c04cme5f30157cba684df@mail.gmail.com>
 <20090816185608.GA7806@feather>
 <1250451271.11216.0.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:39406 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZHPUAh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 16 Aug 2009 16:00:37 -0400
Content-Disposition: inline
In-Reply-To: <1250451271.11216.0.camel@johannes.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-sparse@vger.kernel.org

On Sun, Aug 16, 2009 at 09:34:31PM +0200, Johannes Berg wrote:
> On Sun, 2009-08-16 at 11:56 -0700, Josh Triplett wrote:
> 
> > > The linux kernel has a STRING macro. I will rename to match
> > > that if nobody objects.
> > 
> > Matching Linux seems sensible, but I don't see that macro in any general
> > code, just a bunch of local defines with various names.  A few quick
> > greps on current git master turned up at least:
> 
> > So, I don't see any particular consistency here that we can follow, other than
> > that the macro should probably have "str" in it somewhere. :)  And if we have
> > to choose, I think STRINGIFY seems more descriptive than just STRING.
> 
> There's include/linux/stringify.h that all those instances you found
> could use.

Interesting.  I don't know why my search missed that one.  Unfortunate
that it settled on __stringify, though.

Thanks fo the pointer.

- Josh Triplett
