From: josh@joshtriplett.org
Subject: Re: Designated initializers for fields in anonymous structs and
 unions
Date: Thu, 31 Jul 2014 13:55:01 -0700
Message-ID: <20140731205501.GA13837@cloud>
References: <20140731181006.GA13180@cloud>
 <CA+55aFxptOTqCR9b0o8sEKwzyQOU0rfKTptRY5s=j5R_X=UdUg@mail.gmail.com>
 <CA+55aFwg=yuR6Ro1O3g50Y1QR-hPeW5y_BLQ18go_DoX9SZe6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41188 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaGaUzG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Jul 2014 16:55:06 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwg=yuR6Ro1O3g50Y1QR-hPeW5y_BLQ18go_DoX9SZe6Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, John Keeping <john@keeping.me.uk>

On Thu, Jul 31, 2014 at 11:50:30AM -0700, Linus Torvalds wrote:
> On Thu, Jul 31, 2014 at 11:39 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > but not in the "official" sparse tree, which hasn't seen any work
> > since January afaik.
> 
> Ugh, I looked at the old "sparse/sparse.git" tree (and badly at that,
> it stopped updating in April, not January). It's
> "sparse/chrisl/sparse.git" these days. No wonder I didn't see any
> recent work.
> 
> The sparse.wiki.kernel.org main page is the first google hit for
> "sparse git tree" and mentions that old git repo, not Chris' new one.
> 
> That leaves just my last patch ("Fix scoping of extern") as being not
> in the sparse tree, and that's irrelevant for the union initializer
> thing.
> 
> Chris, any particular reason why the url changed?

I think Chris has been trying to use chrisl as a staging tree to let
things cook a while, and then moving them over to the sparse tree.
However, I think it'd make more sense to do that as a branch rather than
a separate repo.

- Josh Triplett
