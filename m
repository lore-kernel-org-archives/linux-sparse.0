From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 08 Jun 2012 16:08:18 -0400
Message-ID: <4FD25BB2.2030300@garzik.org>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com> <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37641 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669Ab2FHUIW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 16:08:22 -0400
Received: by yhmm54 with SMTP id m54so1577158yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 13:08:21 -0700 (PDT)
In-Reply-To: <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On 06/08/2012 03:10 PM, Pekka Enberg wrote:
> So it seems that LLVM really wants to use the "getelementptr" thingy
> for these. I have no idea what makes the most sense from sparse IR
> point of view.


IMO it's a major backend design choice, GEP or not.

Either choice requires a bit of ugly work, in different places.  sparse 
already calculates sufficient information to create low-level 
address/offset load/store generated code.  LLVM API seems to "prefer" 
that one use GEP code and associated type information, and was written 
with this preference in mind.  HOWEVER it is not a hard requirement, and 
addr/ofs load/store lowlevel code can be generated.  You wind up 
abandoning LLVM's type-related APIs, with all that entails.

Using GEP with sparse, OTOH, enables smarter warnings, optimizations, 
aliasing behaviors etc. during code generation, by virtue of providing 
more type information throughout the LLVM compile process.  The hard 
work of GEP+sparse is that sparse in places prefers to linearize to a 
lower level, and you may wind up having to re-create (or store early) 
some advanced type information sparse deems unimportant in later 
linearization phases.

I am biased in favor of GEP (more information) but sparse at present is 
biased in favor of addr/ofs load/store.  Each has benefits and costs.

	Jeff


