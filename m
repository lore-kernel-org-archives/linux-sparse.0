From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sparse as a compiler front-end
Date: Sat, 09 Dec 2006 05:15:48 -0500
Message-ID: <457A8CD4.8020008@garzik.org>
References: <45564680.8090806@garzik.org> <455679B0.8030106@freedesktop.org> <4575A3F0.2090502@freedesktop.org> <20061208193418.GA17790@lists.us.dell.com> <457A854F.5010602@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59534 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936780AbWLIKPy (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Dec 2006 05:15:54 -0500
In-Reply-To: <457A854F.5010602@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-sparse@vger.kernel.org

Josh Triplett wrote:
> From the spec file, I notice that you install the pkg-config file to
> /usr/lib/pkgconfig (or equivalent), rather than /usr/share/pkgconfig (or
> equivalent) as the Makefile does; any particular reason for that?

The pkgconfig file describes an architecture-specific library, so it 
goes into /usr/lib/pkgconfig/$pkg.pc if its 32-bit (or the rare 64-bit 
arch that uses /usr/lib), and it goes into /usr/lib64/pkgconfig/$pkg.pc 
if the library is 64-bit.

/usr/share is not appropriate for architecture-specific data.

	Jeff
