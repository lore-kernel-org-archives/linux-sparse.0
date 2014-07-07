From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] sparse: Add CLOG option for saving warning
Date: Mon, 7 Jul 2014 13:22:57 +0200
Message-ID: <20140707112257.GA12549@ravnborg.org>
References: <CANeU7Q=a82YmUE49uZ1sOxZn0KGLuktSXuj7YsmUb=wXQEpPXA@mail.gmail.com>
 <CANeU7QmT=vzOGd6bBdkr-kNkt7yfzCWQF5QujiwV7Q8Q9hZw=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:51817 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbaGGLXE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2014 07:23:04 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QmT=vzOGd6bBdkr-kNkt7yfzCWQF5QujiwV7Q8Q9hZw=w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

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
We do not need this kind of special handling of outputs from gcc.
For sparse you just do a run with C=2 then you have it.

In other words - this looks like overkill for somethign thas is achievable
with simpler means.

	Sam

