From: Dave Jones <davej@redhat.com>
Subject: Re: How do I get the latest sparse?
Date: Mon, 15 Jan 2007 22:16:37 -0500
Message-ID: <20070116031637.GA18993@redhat.com>
References: <20070115165947.f2d4af01.rdunlap@xenotime.net> <AKEOJDDJLNPHDAKOMMBHCEGJCPAA.mshah@teja.com> <20070115181515.a2573235.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54317 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbXAPDQ4 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Jan 2007 22:16:56 -0500
Content-Disposition: inline
In-Reply-To: <20070115181515.a2573235.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Mitesh Shah <mshah@teja.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, davej@codemonkey.org.uk

On Mon, Jan 15, 2007 at 06:15:15PM -0800, Randy Dunlap wrote:
 > On Mon, 15 Jan 2007 17:07:10 -0800 Mitesh Shah wrote:
 > 
 > > > http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ says:
 > > >
 > > > [ ]	sparse-2007-01-10.tar.gz	10-Jan-2007 23:01 	169K
 > > > [ ]	sparse-2007-01-11.tar.gz	11-Jan-2007 23:01 	169K
 > > > [ ]	sparse-2007-01-12.tar.gz	12-Jan-2007 23:01 	169K
 > > > [ ]	sparse-2007-01-13.tar.gz	13-Jan-2007 23:00 	169K
 > > > [ ]	sparse-2007-01-14.tar.gz	14-Jan-2007 23:00 	169K
 > > > [ ]	sparse-2007-01-15.tar.gz	15-Jan-2007 23:01 	169K
 > > > [ ]	sparse-2007-01-16.tar.gz	16-Jan-2007 00:01 	169K
 > > > [ ]	sparse-latest.tar.gz		16-Jan-2007 00:01 	169K
 > > >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 > > >
 > > > ---
 > > > ~Randy
 > > >
 > > 
 > > Yes, but if you unzip and untar that file, you will see that the sources
 > > are not updated since Nov 6, 2006. So my guess is that the tar is being
 > > built everyday but the checkout is not happening from the correct source
 > > repository.
 > 
 > Oh, OK, thanks.  We'll let the codemonkey know.  :)

Odd. It's doing a clone of git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
I'll poke at it some more when I get back from LCA, latency to that
box is pretty awful from here.

		Dave

-- 
http://www.codemonkey.org.uk
