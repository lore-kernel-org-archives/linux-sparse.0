From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Mon, 11 Oct 2010 12:50:16 +0200
Message-ID: <201010111250.16299.arnd@arndb.de>
References: <20101010173352.GB5851@bicker> <201010111013.28952.arnd@arndb.de> <1286787000.3634.1.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56274 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0JKKtm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 06:49:42 -0400
In-Reply-To: <1286787000.3634.1.camel@jlt3.sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Monday 11 October 2010, Johannes Berg wrote:
> On Mon, 2010-10-11 at 10:13 +0200, Arnd Bergmann wrote:
> 
> > Hmm, actually sparse does not warn about sound_ioctl returning in
> > different lock contexts. Sparse developers: is there a known limitation
> > in sparse for this? I expected to see context warnings because
> > sound_ioctl normally releases soundcard_mutex (previously lock_kernel)
> > in some cases returns while holding the lock.
> 
> Arnd, mutexes aren't annotated in the kernel source to make use of
> sparse's context checking.

D'oh. I never realized this was only done for some types of locks.
Is there a reason why we don't want mutexes to be annotated or do
we just need someone to do it?

	Arnd
