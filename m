From: "Mitesh Shah" <mshah@teja.com>
Subject: RE: How do I get the latest sparse?
Date: Mon, 15 Jan 2007 17:07:10 -0800
Message-ID: <AKEOJDDJLNPHDAKOMMBHCEGJCPAA.mshah@teja.com>
References: <20070115165947.f2d4af01.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.teja.com ([209.10.202.133]:50648 "EHLO mail.teja.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932156AbXAPBG7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Jan 2007 20:06:59 -0500
In-Reply-To: <20070115165947.f2d4af01.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

> http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ says:
>
> [ ]	sparse-2007-01-10.tar.gz	10-Jan-2007 23:01 	169K
> [ ]	sparse-2007-01-11.tar.gz	11-Jan-2007 23:01 	169K
> [ ]	sparse-2007-01-12.tar.gz	12-Jan-2007 23:01 	169K
> [ ]	sparse-2007-01-13.tar.gz	13-Jan-2007 23:00 	169K
> [ ]	sparse-2007-01-14.tar.gz	14-Jan-2007 23:00 	169K
> [ ]	sparse-2007-01-15.tar.gz	15-Jan-2007 23:01 	169K
> [ ]	sparse-2007-01-16.tar.gz	16-Jan-2007 00:01 	169K
> [ ]	sparse-latest.tar.gz		16-Jan-2007 00:01 	169K
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> ---
> ~Randy
>

Yes, but if you unzip and untar that file, you will see that the sources
are not updated since Nov 6, 2006. So my guess is that the tar is being
built everyday but the checkout is not happening from the correct source
repository.

-Mitesh
