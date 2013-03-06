From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] sparse: Add cmd line  --version option
Date: Wed, 06 Mar 2013 13:57:23 -0800
Message-ID: <1362607043.2093.19.camel@joe-AO722>
References: <1362590578.1759.48.camel@joe-AO722>
	 <20130306214550.GA8486@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:53018 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754163Ab3CFV5Y (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 16:57:24 -0500
In-Reply-To: <20130306214550.GA8486@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

On Wed, 2013-03-06 at 13:45 -0800, Josh Triplett wrote:
> On Wed, Mar 06, 2013 at 09:22:58AM -0800, Joe Perches wrote:
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1,5 +1,12 @@
> >  VERSION=0.4.4
> >  
> > +HAVE_GIT:=$(shell git describe >/dev/null 2>&1 && echo 'yes')
> > +ifeq ($(HAVE_GIT),yes)
> > +SPARSE_VERSION=$(shell git describe)
> > +else
> > +SPARSE_VERSION=$(VERSION)
> > +endif
> > +
> 
> The "dist" target already has a call to "git describe"; could you unify
> the two?  (And, ideally, avoid calling git describe twice, once for
> HAVE_GIT and once for SPARSE_VERSION?)

I think the overhead is low and not worth the bother.

Go for it if it bothers you.

