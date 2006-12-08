From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: sparse as a compiler front-end
Date: Fri, 8 Dec 2006 13:34:18 -0600
Message-ID: <20061208193418.GA17790@lists.us.dell.com>
References: <45564680.8090806@garzik.org> <455679B0.8030106@freedesktop.org> <4575A3F0.2090502@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:20133 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426157AbWLHTeQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Dec 2006 14:34:16 -0500
Content-Disposition: inline
In-Reply-To: <4575A3F0.2090502@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Tue, Dec 05, 2006 at 08:53:04AM -0800, Josh Triplett wrote:
> Josh Triplett wrote:
> > Jeff Garzik wrote:
> >> Can libsparse.a and necessary includes be packaged as well?
> > 
> > Sure, assuming you don't mind coding against something potentially fluid.  The
> > next release will install the library and headers.  (At the moment, "necessary
> > headers" seems to mean "all of them".)
> 
> The Sparse 0.2 release installs the library and headers, as well as a
> pkg-config file.

I've got a test build of sparse-0.2 posted at
http://domsch.com/linux/fedora/extras/sparse/0.2/ which I intend to
put into Fedora Extras for FC5,6,devel.  This puts the libsparse.a and
headers into a -devel package.

Jeff, does this suit your needs?

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
