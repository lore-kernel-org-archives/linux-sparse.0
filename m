From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Mon, 11 Oct 2010 10:50:00 +0200
Message-ID: <1286787000.3634.1.camel@jlt3.sipsolutions.net>
References: <20101010173352.GB5851@bicker>
	 <201010102039.34858.arnd@arndb.de>  <201010111013.28952.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:57521 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab0JKIuK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 04:50:10 -0400
In-Reply-To: <201010111013.28952.arnd@arndb.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Mon, 2010-10-11 at 10:13 +0200, Arnd Bergmann wrote:

> Hmm, actually sparse does *not* warn about sound_ioctl returning in
> different lock contexts. Sparse developers: is there a known limitation
> in sparse for this? I expected to see context warnings because
> sound_ioctl normally releases soundcard_mutex (previously lock_kernel)
> in some cases returns while holding the lock.

Arnd, mutexes aren't annotated in the kernel source to make use of
sparse's context checking.

johannes

