From: terra@gnome.org (Morten Welinder)
Subject: Re: [PATCH] Fix warnings from gcc 4.1.1
Date: Mon, 10 Jul 2006 15:13:59 -0400 (EDT)
Message-ID: <20060710191359.27AACC000E4@dunnock.rentec.com>
References: <20060708060004.20321.50429.stgit@dv.roinet.com>
	 <Pine.LNX.4.64.0607081053560.3869@g5.osdl.org> <1152426703.6603.2.camel@dv>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from unicorn.rentec.com ([216.223.240.10]:49400 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S1422787AbWGJTOC
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 10 Jul 2006 15:14:02 -0400
In-reply-to: <1152426703.6603.2.camel@dv> (message from Pavel Roskin on Sun,
	09 Jul 2006 02:31:43 -0400)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: proski@gnu.org
Cc: linux-sparse@vger.kernel.org


> Indeed, that's a bug number 26632:
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=26632
> Nobody is arguing that it's a feature.

That's a bit too optimistic in my reading.  As I read it, they
want to keep the warning for explicit casts, but drop it for
casts that the gcc front end decides to insert itself.

I'm sure they mean well, but this warning is getting in the way
of lots of people doing stuff with macros.

M.
