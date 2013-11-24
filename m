From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [BUG] sparse warning EXPORT_SYMBOL()'d symbol non-static
Date: Sun, 24 Nov 2013 12:45:56 -0800
Message-ID: <20131124204555.GA13012@leaf>
References: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com>
 <1385322581.23961.5.camel@jlt4.sipsolutions.net>
 <20131124202851.GF19762@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45139 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab3KXUqF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Nov 2013 15:46:05 -0500
Content-Disposition: inline
In-Reply-To: <20131124202851.GF19762@tassilo.jf.intel.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Wei Yongjun <weiyj.lk@gmail.com>, linux-sparse@vger.kernel.org

On Sun, Nov 24, 2013 at 12:28:51PM -0800, Andi Kleen wrote:
> > Well, sparse is clearly "right", for all it cares it might very well be
> > static, but it seems this is necessary for something in the kernel and
> > we clearly can't forward-declare it in a header file. Perhaps we can add
> > some annotation to say
> > "__attribute__((yes_I_know_but_really_dont_want_this_to_be_static))" to
> > suppress this warning? This is getting annoying to me as well :-)
> 
> We could do something like
> 
> typeof(foo); 
> 
> in the macro. Not sure if that would make sparse happy.

If you're just looking to mollify sparse, the easiest way is to
put a prototype of the symbol right before the symbol itself.

> Also this is really working around a problem upto gcc 4.8. that was fixed
> in gcc 4.9 (adding numerical postfixes to all symbols)  If it's ok to let LTO only support 4.9+ the patches could be reverted.

That seems like the best solution, assuming the later scripts can't be
fixed to cope with the numeric suffixes from 4.8.

- Josh Triplett
