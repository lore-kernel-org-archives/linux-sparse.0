From: Pavel Roskin <proski@gnu.org>
Subject: Re: idio{,ma}tic typos (was Re: +
	fix-vm_can_nonlinear-check-in-sys_remap_file_pages.patch added to -mm tree)
Date: Wed, 10 Oct 2007 15:02:27 -0400
Message-ID: <1192042947.29176.2.camel@dv>
References: <20071010104540.GA6366@localhost.sw.ru>
	 <118833cc0710100635x205503a2peb73d24384538afa@mail.gmail.com>
	 <470D1535.6030708@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:58630 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbXJJTCg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Oct 2007 15:02:36 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IfgoJ-0006bB-RT
	for linux-sparse@vger.kernel.org; Wed, 10 Oct 2007 15:01:35 -0400
In-Reply-To: <470D1535.6030708@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Morten Welinder <mwelinder@gmail.com>, Alexey Dobriyan <adobriyan@sw.ru>, Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, Pierre Ossman <drzeus@drzeus.cx>, akpm@osdl.org, linux-sparse@vger.kernel.org

On Wed, 2007-10-10 at 11:08 -0700, Josh Triplett wrote:

> Sparse has a notion of "integer constant expression" already, which it
> uses to validate expressions used for things like bitfield widths or
> array sizes.  I could easily have Sparse warn on any use of an integer
> constant expression as an operand of || or &&.  However, I can imagine
> that that might lead to some false positives when intentionally using
> an integer constant expression in a condition and expecting the
> compiler to optimize it out at compile time.

I can imagine 0 or 1 being used, maybe -1, but hardly anything else.
Maybe you could add the code printing the value and then get some
statics on the actual Linux kernel to see which values are common and
which are not?

-- 
Regards,
Pavel Roskin
