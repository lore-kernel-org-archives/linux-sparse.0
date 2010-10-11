From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Mon, 11 Oct 2010 11:54:56 -0700
Message-ID: <20101011185455.GB8537@feather>
References: <20101010173352.GB5851@bicker>
 <201010111013.28952.arnd@arndb.de>
 <1286787000.3634.1.camel@jlt3.sipsolutions.net>
 <201010111250.16299.arnd@arndb.de>
 <1286794326.3634.13.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:44342 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab0JKSzN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 14:55:13 -0400
Content-Disposition: inline
In-Reply-To: <1286794326.3634.13.camel@jlt3.sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Oct 11, 2010 at 12:52:06PM +0200, Johannes Berg wrote:
> On Mon, 2010-10-11 at 12:50 +0200, Arnd Bergmann wrote:
> > On Monday 11 October 2010, Johannes Berg wrote:
> > > On Mon, 2010-10-11 at 10:13 +0200, Arnd Bergmann wrote:
> > > 
> > > > Hmm, actually sparse does not warn about sound_ioctl returning in
> > > > different lock contexts. Sparse developers: is there a known limitation
> > > > in sparse for this? I expected to see context warnings because
> > > > sound_ioctl normally releases soundcard_mutex (previously lock_kernel)
> > > > in some cases returns while holding the lock.
> > > 
> > > Arnd, mutexes aren't annotated in the kernel source to make use of
> > > sparse's context checking.
> > 
> > D'oh. I never realized this was only done for some types of locks.
> > Is there a reason why we don't want mutexes to be annotated or do
> > we just need someone to do it?
> 
> I don't know. Could be related to trylock issues, could be just historic
> since semaphores can't really be annotated, or could be something else
> entirely... I would expect a huge amount of warnings from sparse though
> if you "just" annotate them since there are things like rtnl_lock()
> which would have to propagate context.

As far as I know, no reason exists to not just annotate mutexes; I think
mutexes just came along later and nobody happened to add the appropriate
annotations.  (Also, sparse does handle trylock.)

But yes, annotating mutexes will then introduce a giant pile of lock
warnings that need further annotation propagation.  It will also
introduce lock warnings that represent actual bugs, making it important
to not just blindly propagate annotations to make warnings go away.

- Josh Triplett
