From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Mon, 11 Oct 2010 23:43:26 -0700
Message-ID: <20101012064326.GB1702@feather>
References: <20101010173352.GB5851@bicker>
 <201010112242.19246.arnd@arndb.de>
 <20101011222307.GA10570@feather>
 <201010120839.15257.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:41447 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab0JLGnh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Oct 2010 02:43:37 -0400
Content-Disposition: inline
In-Reply-To: <201010120839.15257.arnd@arndb.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org

On Tue, Oct 12, 2010 at 08:39:14AM +0200, Arnd Bergmann wrote:
> On Tuesday 12 October 2010 00:23:08 Josh Triplett wrote:
> > Assuming that the underlying function only returns zero/non-zero and
> > that the actual return value doesn't matter, then you can use the
> > __cond_lock macro from compiler.h for this:
> > 
> > # define __cond_lock(x,c)       ((c) ? ({ __acquire(x); 1; }) : 0)
> > 
> 
> The return from mutex_lock_{killable,interruptible} is an error
> value, not true/false, so it actually matters. We know that the only
> possible error that is currently returned is -EINTR though, so we
> could do a similar trick and define another
> 
> #define __cond_mutex(x, c)	((!c) ? ({ __acquire(x); 0; }) : -EINTR)
> 
> My fear was that this would impact code generation.

If __cond_lock doesn't fit, then you could just define a generic wrapper
to capture the pattern of preserving a function's return value, and use
that for all the mutex calls.  And if you just preserve the return
value, and __acquire compiles to nothing for GCC, then GCC should just
optimize away the extra copy into a local variable.

- Josh Triplett
