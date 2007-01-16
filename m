From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: How do I get the latest sparse?
Date: Mon, 15 Jan 2007 18:15:15 -0800
Message-ID: <20070115181515.a2573235.rdunlap@xenotime.net>
References: <20070115165947.f2d4af01.rdunlap@xenotime.net>
	<AKEOJDDJLNPHDAKOMMBHCEGJCPAA.mshah@teja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:54426 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932229AbXAPCPB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Jan 2007 21:15:01 -0500
Received: from midway.site ([71.245.99.70]) by xenotime.net for <linux-sparse@vger.kernel.org>; Mon, 15 Jan 2007 18:14:53 -0800
In-Reply-To: <AKEOJDDJLNPHDAKOMMBHCEGJCPAA.mshah@teja.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mitesh Shah <mshah@teja.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, davej@codemonkey.org.uk

On Mon, 15 Jan 2007 17:07:10 -0800 Mitesh Shah wrote:

> > http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ says:
> >
> > [ ]	sparse-2007-01-10.tar.gz	10-Jan-2007 23:01 	169K
> > [ ]	sparse-2007-01-11.tar.gz	11-Jan-2007 23:01 	169K
> > [ ]	sparse-2007-01-12.tar.gz	12-Jan-2007 23:01 	169K
> > [ ]	sparse-2007-01-13.tar.gz	13-Jan-2007 23:00 	169K
> > [ ]	sparse-2007-01-14.tar.gz	14-Jan-2007 23:00 	169K
> > [ ]	sparse-2007-01-15.tar.gz	15-Jan-2007 23:01 	169K
> > [ ]	sparse-2007-01-16.tar.gz	16-Jan-2007 00:01 	169K
> > [ ]	sparse-latest.tar.gz		16-Jan-2007 00:01 	169K
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > ---
> > ~Randy
> >
> 
> Yes, but if you unzip and untar that file, you will see that the sources
> are not updated since Nov 6, 2006. So my guess is that the tar is being
> built everyday but the checkout is not happening from the correct source
> repository.

Oh, OK, thanks.  We'll let the codemonkey know.  :)

---
~Randy
