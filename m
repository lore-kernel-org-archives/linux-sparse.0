From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sparse as a compiler front-end
Date: Sat, 09 Dec 2006 05:17:46 -0500
Message-ID: <457A8D4A.5060007@garzik.org>
References: <45564680.8090806@garzik.org> <455679B0.8030106@freedesktop.org> <4575A3F0.2090502@freedesktop.org> <20061208193418.GA17790@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59550 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759156AbWLIKRt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Dec 2006 05:17:49 -0500
In-Reply-To: <20061208193418.GA17790@lists.us.dell.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Matt Domsch wrote:
> On Tue, Dec 05, 2006 at 08:53:04AM -0800, Josh Triplett wrote:
>> Josh Triplett wrote:
>>> Jeff Garzik wrote:
>>>> Can libsparse.a and necessary includes be packaged as well?
>>> Sure, assuming you don't mind coding against something potentially fluid.  The
>>> next release will install the library and headers.  (At the moment, "necessary
>>> headers" seems to mean "all of them".)
>> The Sparse 0.2 release installs the library and headers, as well as a
>> pkg-config file.
> 
> I've got a test build of sparse-0.2 posted at
> http://domsch.com/linux/fedora/extras/sparse/0.2/ which I intend to
> put into Fedora Extras for FC5,6,devel.  This puts the libsparse.a and
> headers into a -devel package.
> 
> Jeff, does this suit your needs?

Yep, both sparse and sparse-devel look great, here on FC6!

Thanks,

	Jeff
