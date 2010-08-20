From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: Lots of "error: multiple storage classes" warnings on the
 Linux kernel
Date: Fri, 20 Aug 2010 10:37:39 +0200
Message-ID: <1282293459.10440.223.camel@thorin>
References: <1282222392.10440.60.camel@thorin>
	 <20100819192656.GA19303@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:6060 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751620Ab0HTIhr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Aug 2010 04:37:47 -0400
In-Reply-To: <20100819192656.GA19303@merkur.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-sparse@vger.kernel.org

On Don, 2010-08-19 at 21:26 +0200, Sam Ravnborg wrote:
> On Thu, Aug 19, 2010 at 02:53:12PM +0200, Bernd Petrovitsch wrote:
[...]
> > While investigating something completely different, I noticed lots of 
> > "error: multiple storage classes" warnings, e.g.
> > ----  snip  ----
> >   CHECK   security/keys/keyring.c
> > include/linux/sched.h:831:12: error: multiple storage classes: extern weak
> > security/keys/keyring.c:75:1: error: multiple storage classes: extern weak
> > security/keys/keyring.c:471:1: error: multiple storage classes: extern weak
> > security/keys/keyring.c:899:1: error: multiple storage classes: extern weak
> > security/keys/keyring.c:974:1: error: multiple storage classes: extern weak
> > security/keys/keyring.c:1033:1: error: multiple storage classes: extern weak
> > ----  snip  ---- 
> > [ The ": extern weak" is from me to see which are actually set. ]
> > 
> > Is this warning correct that way (and the source should be fixed) or is
> > the warning in that wrong?
> 
> Can you cook up a small code snippet that
> exhibit this without all the kernel macros etc?

Of course.

> This would make it easier for the sparse folks to understand.

----  snip  ----
{341}echo 'extern int __attribute__((weak)) foobar(void);' | sparse -f -
-:1:12: error: multiple storage classes: extern weak
----  snip  ----
is a minimal example shows that.

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

