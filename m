From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [BUG] sparse warning EXPORT_SYMBOL()'d symbol non-static
Date: Sun, 24 Nov 2013 21:48:57 +0100
Message-ID: <1385326137.23961.8.camel@jlt4.sipsolutions.net>
References: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com>
	 <1385322581.23961.5.camel@jlt4.sipsolutions.net>
	 <20131124202851.GF19762@tassilo.jf.intel.com> <20131124204555.GA13012@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35203 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab3KXUtC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Nov 2013 15:49:02 -0500
In-Reply-To: <20131124204555.GA13012@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andi Kleen <ak@linux.intel.com>, Wei Yongjun <weiyj.lk@gmail.com>, linux-sparse@vger.kernel.org

On Sun, 2013-11-24 at 12:45 -0800, Josh Triplett wrote:
> On Sun, Nov 24, 2013 at 12:28:51PM -0800, Andi Kleen wrote:
> > > Well, sparse is clearly "right", for all it cares it might very well be
> > > static, but it seems this is necessary for something in the kernel and
> > > we clearly can't forward-declare it in a header file. Perhaps we can add
> > > some annotation to say
> > > "__attribute__((yes_I_know_but_really_dont_want_this_to_be_static))" to
> > > suppress this warning? This is getting annoying to me as well :-)
> > 
> > We could do something like
> > 
> > typeof(foo); 
> > 
> > in the macro. Not sure if that would make sparse happy.
> 
> If you're just looking to mollify sparse,

I am, pretty much, since now I get a ton of output and have to either
grep it or dig through it... :)

> the easiest way is to
> put a prototype of the symbol right before the symbol itself.

Oh, right, good point, thanks Josh. Andi, do you want to do that?
Otherwise I can post a patch.

johannes

