From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Tue, 12 Oct 2010 08:39:14 +0200
Message-ID: <201010120839.15257.arnd@arndb.de>
References: <20101010173352.GB5851@bicker> <201010112242.19246.arnd@arndb.de> <20101011222307.GA10570@feather>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55093 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab0JLGjd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Oct 2010 02:39:33 -0400
In-Reply-To: <20101011222307.GA10570@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org

On Tuesday 12 October 2010 00:23:08 Josh Triplett wrote:
> Assuming that the underlying function only returns zero/non-zero and
> that the actual return value doesn't matter, then you can use the
> __cond_lock macro from compiler.h for this:
> 
> # define __cond_lock(x,c)       ((c) ? ({ __acquire(x); 1; }) : 0)
> 

The return from mutex_lock_{killable,interruptible} is an error
value, not true/false, so it actually matters. We know that the only
possible error that is currently returned is -EINTR though, so we
could do a similar trick and define another

#define __cond_mutex(x, c)	((!c) ? ({ __acquire(x); 0; }) : -EINTR)

My fear was that this would impact code generation.

	Arnd
