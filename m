From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5] Adding the NULL pointer checker.
Date: Mon, 29 Jan 2007 14:48:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291446530.3611@woody.linux-foundation.org>
References: <20070117023918.GF962@chrisli.org>  <45BB0B65.7060403@freedesktop.org>
 <70318cbf0701291430q629a9252r322ee4bb477d48b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:60273 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbXA2WsO (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Jan 2007 17:48:14 -0500
In-Reply-To: <70318cbf0701291430q629a9252r322ee4bb477d48b9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@freedesktop.org>, Linus Torvalds <torvalds@osdl.org>, linux-sparse@vger.kernel.org



On Mon, 29 Jan 2007, Chris Li wrote:

> > > --- sparse.orig/expand.c      2007-01-16 11:13:18.000000000 -0800
> > > +++ sparse/expand.c   2007-01-16 11:13:28.000000000 -0800
> > > -#define SELECT_COST 20               /* Cut-off for turning a conditional
> > into a select */
> > > -#define BRANCH_COST 10               /* Cost of a conditional branch */
> > > +#define SELECT_COST 0                /* Cut-off for turning a conditional
> > into a select */
> > > +#define BRANCH_COST 0                /* Cost of a conditional branch */
> > 
> > OK, I *think* that won't cause any harm.
> 
> Linus, any words here? I have a vague impression that it has some thing to
> do with simplifying phi usage, but I am not sure what is the real side effect.

I just think the old costs are likely more realistic, but they were pulled 
totally out of my *ss. 

If it's more convenient to set them to zero, go wild. No deep meaning.

		Linus
