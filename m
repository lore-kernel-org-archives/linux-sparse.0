From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Mon, 11 Oct 2010 10:13:27 +0200
Message-ID: <201010111013.28952.arnd@arndb.de>
References: <20101010173352.GB5851@bicker> <201010102039.34858.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61485 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab0JKIOl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 04:14:41 -0400
In-Reply-To: <201010102039.34858.arnd@arndb.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Sunday 10 October 2010 20:39:34 Arnd Bergmann wrote:
> On Sunday 10 October 2010 19:33:52 Dan Carpenter wrote:
> > We shouldn't return directly here because we're still holding the
> > &soundcard_mutex.
> > 
> > This bug goes all the way back to the start of git.  It's strange that
> > no one has complained about it as a runtime bug.
> > 
> > CC: stable@kernel.org
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> It was only recently converted to a mutex from the BKL, which is much
> more friendly to misusage because it is automatically released when
> the kernel sleeps or when the program exits.
> 
> The behavior was already broken with the BKL but the problem was far
> less visible. I fear we might be seeing more of these as fallout from
> the BKL removal. Sparse should be able to detect most of these cases
> though, so maybe we can look more carefully for them.
 
Hmm, actually sparse does *not* warn about sound_ioctl returning in
different lock contexts. Sparse developers: is there a known limitation
in sparse for this? I expected to see context warnings because
sound_ioctl normally releases soundcard_mutex (previously lock_kernel)
in some cases returns while holding the lock.

	Arnd
