From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 07/13] evaluate: check static storage duration
 objects' intializers' constness
Date: Tue, 26 Jan 2016 21:18:31 +0100
Message-ID: <20160126201830.GA2099@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87zivtemfq.fsf@gmail.com>
 <20160126014227.GE46188@macpro.local>
 <87h9i0b9xr.fsf@gmail.com>
 <20160126175637.GB989@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34525 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcAZUSe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jan 2016 15:18:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id p63so380130wmp.1
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2016 12:18:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160126175637.GB989@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Jan 26, 2016 at 06:56:39PM +0100, Luc Van Oostenryck wrote:
> On Tue, Jan 26, 2016 at 05:08:16PM +0100, Nicolai Stange wrote:
> 
> > The -Wstatic-initializer-not-const choice made in the current series is
> > simply a workaround, any better suggestions welcome!
> > 
> > I'm also fine with -Wstatic-initializer.
> > 
> > Comments?
> 
> I dunno.
> Better to leave it so for now, I think.

I see that clang has -Wconstexpr-not-const, which is not too long
and still quite explicit and can be used for others things than
initializers.


Luc
