From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] sparse: Add CLOG option for saving warning
Date: Fri, 4 Jul 2014 14:20:25 -0700
Message-ID: <20140704212025.GA3052@thin>
References: <CANeU7Q=a82YmUE49uZ1sOxZn0KGLuktSXuj7YsmUb=wXQEpPXA@mail.gmail.com>
 <CANeU7QmT=vzOGd6bBdkr-kNkt7yfzCWQF5QujiwV7Q8Q9hZw=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44855 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759909AbaGDVUe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 Jul 2014 17:20:34 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QmT=vzOGd6bBdkr-kNkt7yfzCWQF5QujiwV7Q8Q9hZw=w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Jul 04, 2014 at 12:48:00AM -0700, Christopher Li wrote:
> On Mon, Jun 30, 2014 at 1:57 AM, Christopher Li <sparse@chrisli.org> wrote:
> >
> > Add the CLOG=<logname> option in command line to
> > save the sparse warning into individual log file.
> >
> > Typical usage:
> >
> > make -j8 C=2 CLOG=<logname>
> 
> Any feed back for this change? I want to clarify that this patch
> is for the Linux kernel kbuild system, not sparse.

Seems reasonable to me.

- Josh Triplett
