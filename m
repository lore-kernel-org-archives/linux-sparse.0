From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [BUG] sparse warning EXPORT_SYMBOL()'d symbol non-static
Date: Sun, 24 Nov 2013 21:36:51 +0100
Message-ID: <1385325411.23961.7.camel@jlt4.sipsolutions.net>
References: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com>
	 <1385322581.23961.5.camel@jlt4.sipsolutions.net>
	 <20131124202851.GF19762@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35151 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3KXUgy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Nov 2013 15:36:54 -0500
In-Reply-To: <20131124202851.GF19762@tassilo.jf.intel.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-sparse@vger.kernel.org

On Sun, 2013-11-24 at 12:28 -0800, Andi Kleen wrote:
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

I wouldn't think so, after all that's just using the symbol, not
declaring it, and using it clearly happens all the time. I only see an
annotation as a solution, which is ugly but this crops up everywhere and
makes sparse output pretty much unreadable.

> Also this is really working around a problem upto gcc 4.8. that was fixed
> in gcc 4.9 (adding numerical postfixes to all symbols)  If it's ok to
> let LTO only support 4.9+ the patches could be reverted.

That I can't comment on. :)

johannes

