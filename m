From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Lots of "error: multiple storage classes" warnings on the
	Linux kernel
Date: Thu, 19 Aug 2010 21:26:56 +0200
Message-ID: <20100819192656.GA19303@merkur.ravnborg.org>
References: <1282222392.10440.60.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:38316 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0HST05 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Aug 2010 15:26:57 -0400
Content-Disposition: inline
In-Reply-To: <1282222392.10440.60.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-sparse@vger.kernel.org

On Thu, Aug 19, 2010 at 02:53:12PM +0200, Bernd Petrovitsch wrote:
> Hi all!
> 
> While investigating something completely different, I noticed lots of 
> "error: multiple storage classes" warnings, e.g.
> ----  snip  ----
>   CHECK   security/keys/keyring.c
> include/linux/sched.h:831:12: error: multiple storage classes: extern weak
> security/keys/keyring.c:75:1: error: multiple storage classes: extern weak
> security/keys/keyring.c:471:1: error: multiple storage classes: extern weak
> security/keys/keyring.c:899:1: error: multiple storage classes: extern weak
> security/keys/keyring.c:974:1: error: multiple storage classes: extern weak
> security/keys/keyring.c:1033:1: error: multiple storage classes: extern weak
> ----  snip  ---- 
> [ The ": extern weak" is from me to see which are actually set. ]
> 
> Is this warning correct that way (and the source should be fixed) or is
> the warning in that wrong?

Can you cook up a small code snippet that
exhibit this without all the kernel macros etc?
This would make it easier for the sparse folks to understand.

	Sam
