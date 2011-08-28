From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Sat, 27 Aug 2011 20:36:32 -0700
Message-ID: <20110828033632.GD20823@leaf>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
 <20110828025010.GB20823@leaf>
 <CAH3ygc01LpeDEY3tmy+ntGH_EC=S7f9AOackWo8dL=5YP6GKkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36130 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1H1Dgr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 23:36:47 -0400
Content-Disposition: inline
In-Reply-To: <CAH3ygc01LpeDEY3tmy+ntGH_EC=S7f9AOackWo8dL=5YP6GKkg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 28, 2011 at 02:57:36PM +1200, Chris Forbes wrote:
> > Also, how does your patch handle expressions like this: *x++ && *x++
> > Or this: f() && f()
> 
> Those cases will both warn. Do I need to be looking for potential side
> effects, and considering these expressions "probably correct" in those
> cases?

Those expressions can certainly make sense in correct code, unlike cases
with identical side-effect-free expressions; that doesn't make such
expressions a good idea, though.  You might want to check for
side-effect-free code (I think Sparse already has a mechanism to test
for that), and split that into a separate warning option.  Whether that
option should stay on by default or not, I don't know; that will take
running it over some real codebases and evaluating the benefit.

- Josh Triplett
