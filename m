From: Pavel Roskin <proski@gnu.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp
	symbols
Date: Fri, 20 Apr 2007 18:42:32 -0400
Message-ID: <1177108952.8787.6.camel@dv>
References: <1170437836.2272.22.camel@dv>
	 <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
	 <46288FA2.4040700@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:56383 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767299AbXDTWmg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Apr 2007 18:42:36 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1Hf1lm-000329-L5
	for linux-sparse@vger.kernel.org; Fri, 20 Apr 2007 18:39:58 -0400
In-Reply-To: <46288FA2.4040700@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-04-20 at 03:02 -0700, Josh Triplett wrote:

> This states that we must substitute 0 for any undefined preprocessor symbol
> in a #if or #elif condition, no matter what kind of expression they show up
> in.

My point was that it's more likely to be a user error in case of
non-trivial expressions.  But arguing with Linus about probabilities of
user errors and other fuzzy matters is not something I'm prepared to.

> However, Pavel, if you feel you could make part of -Wundef suitable to join
> the default set of warnings, feel free.

I really don't care about this part.  I actually think that sparse
should augment gcc capabilities rather than duplicate them.  If we
cannot do better than gcc, we can just stop bothering.

-- 
Regards,
Pavel Roskin
