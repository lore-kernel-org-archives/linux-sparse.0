From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 0/2] check for identical exprs on LHS and RHS of '&&'
Date: Wed, 10 Aug 2011 10:44:23 -0700
Message-ID: <20110810174423.GA6677@leaf>
References: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:54469 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab1HJRpD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Aug 2011 13:45:03 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 031ED3AA80
	for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2011 19:44:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Wed, Aug 10, 2011 at 09:07:13PM +1200, Chris Forbes wrote:
> Hi, I've started working on a new check for sparse to pick up a common 
> error -- identical expressions appearing on both sides of some binary
> operators.
> 
> This initially supports '&&', and incompletely -- but the plan is to
> check instances of '!=', '==' and '||' the same way.
> 
> The check relies on recursively walking the ->left and ->right expressions, 
> looking for differences. The implementation is a little verbose, but can 
> be shared between all the operators.
> 
> What I'd like to know is:
> 
> * Do people consider this a worthwhile check to make?

I'd definitely love to see this check.  I saw an example of the kinds of
bugs it can find in a recent article
(http://software.intel.com/en-us/blogs/2011/08/08/pvs-studio-vs-clang/),
and immediately wished Sparse and/or GCC would include that check.

> * Am I "doing it right" with the expression walking?

Seems OK at first glance, with one exception: you need to handle
expressions with side-effects specially, since you could legitimately
write something like (x == func() && x == func()), or (x == *p++ && x ==
*p++).

> * Are there other cases which people would be interested in?

How about checking for the same expression multiple times in a single
block of | or & expressions?  (flag1 | flag2 | flag2) seems like a
likely copy/paste error.

- Josh Triplett
