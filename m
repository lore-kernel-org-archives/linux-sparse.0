From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 8 Mar 2007 09:43:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703080935120.10832@woody.linux-foundation.org>
References: <1173319356.3546.54.camel@johannes.berg>  <1173371608.21465.12.camel@dv>
  <1173372315.3248.19.camel@johannes.berg> <1173374010.15842.13.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:55238 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbXCHRnr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Mar 2007 12:43:47 -0500
In-Reply-To: <1173374010.15842.13.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org



On Thu, 8 Mar 2007, Pavel Roskin wrote:
> 
> Reducing the file may be tricky, since there is no definite way to say
> if the problem exists once the code becomes shorter.  But I'll try.

I would guess at

	static inline __attribute__((always_inline)) void device_rate_entry(..)

because while that function *looks* really simple ("Hey, it's just ten 
lines"), those lines expand to some nested compile-time constant macros 
from hell, and the end result is hundreds and hundreds of lines of really 
dense code because the macros are set up to be able to handle constant 
arguments asa constant.

That thing is a thing from hell.

			Linus
