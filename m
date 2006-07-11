From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Fix warnings from gcc 4.1.1
Date: Tue, 11 Jul 2006 03:03:36 -0400
Message-ID: <1152601416.29932.63.camel@dv>
References: <20060708060004.20321.50429.stgit@dv.roinet.com>
	 <Pine.LNX.4.64.0607081053560.3869@g5.osdl.org> <1152426703.6603.2.camel@dv>
	 <20060710191359.27AACC000E4@dunnock.rentec.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:27337 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030211AbWGKHDj
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Jul 2006 03:03:39 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G0CHS-0000cV-NN
	for linux-sparse@vger.kernel.org; Tue, 11 Jul 2006 03:03:38 -0400
In-Reply-To: <20060710191359.27AACC000E4@dunnock.rentec.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <terra@gnome.org>
Cc: linux-sparse@vger.kernel.org

On Mon, 2006-07-10 at 15:13 -0400, Morten Welinder wrote:
> > Indeed, that's a bug number 26632:
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=26632
> > Nobody is arguing that it's a feature.
> 
> That's a bit too optimistic in my reading.  As I read it, they
> want to keep the warning for explicit casts, but drop it for
> casts that the gcc front end decides to insert itself.

Now I understand why 27825 is a duplicate of 26632!

> I'm sure they mean well, but this warning is getting in the way
> of lots of people doing stuff with macros.

OK, I didn't search well enough.  This issue is bug 24900, which is
marked "WONTFIX".  It's interesting that the statement expression is
proposed as a workaround - exactly what Linus did!

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=24900

The argument that statement expressions are not portable has been
ignored so far.

-- 
Regards,
Pavel Roskin
