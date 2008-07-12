From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: sparse licensing query
Date: Fri, 11 Jul 2008 17:00:14 -0700
Message-ID: <1215820814.4584.23.camel@josh-work.beaverton.ibm.com>
References: <4877E67B.9040106@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:51721 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876AbYGLAAS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Jul 2008 20:00:18 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6C00FK6011441
	for <linux-sparse@vger.kernel.org>; Fri, 11 Jul 2008 20:00:15 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6C00FqL210742
	for <linux-sparse@vger.kernel.org>; Fri, 11 Jul 2008 20:00:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m6C00FgG012815
	for <linux-sparse@vger.kernel.org>; Fri, 11 Jul 2008 20:00:15 -0400
In-Reply-To: <4877E67B.9040106@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Sat, 2008-07-12 at 00:02 +0100, David Given wrote:
> I'm just putting together some documentation in preparation for a proper
> release of Clue, and have been doing some license paperwork (I want to
> properly attribute sparse). I notice that the LICENSE documentation
> refers to the OSL v1.1 (and provides a dead link to www.opensource.com).
> 
> Given that the OSL is now at v3.0, does sparse use OSL v1.1 on purpose
> or simply that nobody got round to updating it?

For the same reason that most of Linux uses GPLv2 without the "or any
later version" clause: because developers didn't want automatic upgrades
to new licenses without the chance to read them or approve of them.

> (I also note, purely for informational value, that no version of the OSL
> is DSFG compatible.)

And for that matter, all versions of the OSL have incompatibilities with
the GPL.  The sparse FAQ notes that that occurred intentionally, and
motivated the original choice of license.

TTBOMK, newer versions of the OSL seem sufficiently less egregious that
Debian has accepted them.  I think Debian primarily objects to clause
10, which newer versions revise.


Sparse's license has come up on the list several times.  At least one of
those times, the question of relicensing it came up; it seems that none
of the developers object to it.  However, quoting Linus from one of
those discussions:
> Yeah, the OSL wasn't the best choice. I tried to change it (look in the 
> sparse email archives) a few years ago, but I never got in contact with 
> anybody at Transmeta back then who could have the power to relicense, and 
> while my work with Linux has always been unquestionably mine (ie my work 
> contract explicitly stated such), with sparse it isn't as obvious..
> 
> So back then, I couldn't get anybody to look at it (not that I tried all 
> that hard), and I don't think I even have any contacts left to people I 
> know at Transmeta any more.

If anyone wants to try to find the right people to talk to, and for that
matter to get explicit assent from each of the developers, I would
greatly appreciate it.

Sparse's license has in at least one case made it difficult for a
potential user of Sparse, namely the gobject-introspection work.

- Josh Triplett


