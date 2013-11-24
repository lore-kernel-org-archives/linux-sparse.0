From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] sparse warning EXPORT_SYMBOL()'d symbol non-static
Date: Sun, 24 Nov 2013 12:28:51 -0800
Message-ID: <20131124202851.GF19762@tassilo.jf.intel.com>
References: <CAPgLHd9hwKRQMr1dnzJon-nVkkgKxcL5M2jEY8AF6Sv8OZ+aOg@mail.gmail.com>
 <1385322581.23961.5.camel@jlt4.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36898 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab3KXU2w (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Nov 2013 15:28:52 -0500
Content-Disposition: inline
In-Reply-To: <1385322581.23961.5.camel@jlt4.sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-sparse@vger.kernel.org

> Well, sparse is clearly "right", for all it cares it might very well be
> static, but it seems this is necessary for something in the kernel and
> we clearly can't forward-declare it in a header file. Perhaps we can add
> some annotation to say
> "__attribute__((yes_I_know_but_really_dont_want_this_to_be_static))" to
> suppress this warning? This is getting annoying to me as well :-)

We could do something like

typeof(foo); 

in the macro. Not sure if that would make sparse happy.

Also this is really working around a problem upto gcc 4.8. that was fixed
in gcc 4.9 (adding numerical postfixes to all symbols)  If it's ok to let LTO only support 4.9+ the patches could be reverted.

-Andi
