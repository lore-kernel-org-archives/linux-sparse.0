From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Sat, 27 Aug 2011 19:50:10 -0700
Message-ID: <20110828025010.GB20823@leaf>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56652 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1H1CuQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 22:50:16 -0400
Content-Disposition: inline
In-Reply-To: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 28, 2011 at 10:26:53AM +1200, Chris Forbes wrote:
> Adds a warning when identical expressions are found on both sides of the '&&' operator. This is a common error resulting from copy & paste.
> 
> Excludes identical expressions found while preprocessing, so we don't get upset about #if defined(FOO) && defined(BAR), which happens all the time, and is perfectly valid.
> 
> Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>

Very nice patch series!  I replied to patch 3 about a bit of patch cleanup, but otherwise this looks fine, and I've wanted to see this check for a while.

Would you consider also checking for identical expresions on both sides
of an &, |, or ^?  The former two seem like likely cases when composing
flags, and the latter seems like a likely error as well.

Also, how does your patch handle expressions like this: *x++ && *x++
Or this: f() && f()

- Josh Triplett
