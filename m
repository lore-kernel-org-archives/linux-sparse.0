From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Nasal demons in preprocessor use (Re: [PATCH] test-suite: new
	preprocessor test case)
Date: Fri, 20 Mar 2009 23:44:12 +0000
Message-ID: <20090320234412.GK28946@ZenIV.linux.org.uk>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net> <20090319182628.GB28946@ZenIV.linux.org.uk> <154e089b0903191151q37ab7b20o43838845af12966f@mail.gmail.com> <20090319190730.GC28946@ZenIV.linux.org.uk> <20090319192758.GB24318@elte.hu> <19f34abd0903191320qdd73530ud85081d23e17b266@mail.gmail.com> <20090320180853.GA24154@elte.hu> <20090320190409.GH28946@ZenIV.linux.org.uk> <20090320191407.GI28946@ZenIV.linux.org.uk> <19f34abd0903201616v4175b5afn5630fcae02d7ff4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45295 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbZCTXo1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Mar 2009 19:44:27 -0400
Content-Disposition: inline
In-Reply-To: <19f34abd0903201616v4175b5afn5630fcae02d7ff4f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Hannes Eder <hannes@hanneseder.net>, linux-kernel@vger.kernel.org

On Sat, Mar 21, 2009 at 12:16:17AM +0100, Vegard Nossum wrote:

> (The solution you sketched is still quite an uglification of the
> original code, something we tried to minimize using the construct you
> saw.)

Frankly, I'd suggest expanding that sucker and being done with that.
However, more interesting question is whether you really need the
named field to be a struct.  If not, something like
bitfields_start(name)
....
bitfields_end
would work just fine, without all that fun.
