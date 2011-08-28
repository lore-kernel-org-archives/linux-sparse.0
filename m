From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Sat, 27 Aug 2011 20:33:14 -0700
Message-ID: <20110828033314.GC20823@leaf>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
 <20110828025010.GB20823@leaf>
 <CAH3ygc0xmh+w=dRhfHmD5wQ+GbZRcECFf0=GkdAEZ+ZGNeWPhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34100 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1H1DdZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 23:33:25 -0400
Content-Disposition: inline
In-Reply-To: <CAH3ygc0xmh+w=dRhfHmD5wQ+GbZRcECFf0=GkdAEZ+ZGNeWPhg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 28, 2011 at 02:53:52PM +1200, Chris Forbes wrote:
> I'm concerned about the potential for false-positives [after
> preprocessing is done] when combining a bunch of flags.
> 
> I'll throw together another patch to add &|^ support, run it against a
> bunch of real codebases, and see how crazy it is.

Fair enough.  I'd hope that doesn't happen, but I can imagine some
scenarios based on preprocessor macros that could cause that.  However,
if you find that it mostly works and occasionally produces false
positives, you might consider providing an off-by-default warning option
to enable it.

Ideally, we'd try to take textual equality into account from before the
preprocessing step, but that seems anywhere from difficult to impossible
depending on the degree of macro insanity.

- Josh Triplett
