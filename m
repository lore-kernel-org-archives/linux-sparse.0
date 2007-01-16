From: "Mitesh Shah" <mshah@teja.com>
Subject: RE: How do I get the latest sparse?
Date: Tue, 16 Jan 2007 07:40:33 -0800
Message-ID: <AKEOJDDJLNPHDAKOMMBHKEGMCPAA.mshah@teja.com>
References: <45ACC19D.2080508@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.teja.com ([209.10.202.133]:41668 "EHLO mail.teja.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbXAPPks (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 10:40:48 -0500
In-Reply-To: <45ACC19D.2080508@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>, Dave Jones <davej@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, davej@codemonkey.org.uk

Yes, it is fixed now. The snapshots are now matching the repository.

Thanks,

-Mitesh


> -----Original Message-----
> From: Josh Triplett [mailto:josh@freedesktop.org]
> Sent: Tuesday, January 16, 2007 4:14 AM
> To: Dave Jones
> Cc: Randy Dunlap; Mitesh Shah; Linux-Sparse; davej@codemonkey.org.uk
> Subject: Re: How do I get the latest sparse?
> 
> 
> Dave Jones wrote:
> > On Mon, Jan 15, 2007 at 06:15:15PM -0800, Randy Dunlap wrote:
> >  > On Mon, 15 Jan 2007 17:07:10 -0800 Mitesh Shah wrote:
> >  > 
> >  > > > 
> http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ says:
> >  > > >
> >  > > > [ ]	sparse-2007-01-10.tar.gz	10-Jan-2007 
> 23:01 	169K
> >  > > > [ ]	sparse-2007-01-11.tar.gz	11-Jan-2007 
> 23:01 	169K
> >  > > > [ ]	sparse-2007-01-12.tar.gz	12-Jan-2007 
> 23:01 	169K
> >  > > > [ ]	sparse-2007-01-13.tar.gz	13-Jan-2007 
> 23:00 	169K
> >  > > > [ ]	sparse-2007-01-14.tar.gz	14-Jan-2007 
> 23:00 	169K
> >  > > > [ ]	sparse-2007-01-15.tar.gz	15-Jan-2007 
> 23:01 	169K
> >  > > > [ ]	sparse-2007-01-16.tar.gz	16-Jan-2007 
> 00:01 	169K
> >  > > > [ ]	sparse-latest.tar.gz		16-Jan-2007 
> 00:01 	169K
> >  > > >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  > > >
> >  > > > ---
> >  > > > ~Randy
> >  > > >
> >  > > 
> >  > > Yes, but if you unzip and untar that file, you will 
> see that the sources
> >  > > are not updated since Nov 6, 2006. So my guess is that 
> the tar is being
> >  > > built everyday but the checkout is not happening from 
> the correct source
> >  > > repository.
> >  > 
> >  > Oh, OK, thanks.  We'll let the codemonkey know.  :)
> > 
> > Odd. It's doing a clone of 
> git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
> > I'll poke at it some more when I get back from LCA, latency to that
> > box is pretty awful from here.
> 
> I just checked, and the snapshots appear to have current bits 
> from git,
> definitely newer than November 6.
> 
> - Josh Triplett
> 
> 
