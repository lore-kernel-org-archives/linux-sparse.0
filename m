From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: sparse as a compiler front-end
Date: Sat, 11 Nov 2006 17:50:04 -0600
Message-ID: <20061111235002.GA15184@humbolt.us.dell.com>
References: <45564680.8090806@garzik.org>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:563 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1754909AbWKKXuF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Nov 2006 18:50:05 -0500
Content-Disposition: inline
In-Reply-To: <45564680.8090806@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Sat, Nov 11, 2006 at 04:54:08PM -0500, Jeff Garzik wrote:
> I see that sparse made it into Fedora Extras, so that 'yum install' 
> automatically pulls it down for me.  Yay!  Thanks, Matt.
> 
> Can libsparse.a and necessary includes be packaged as well?

.a or .so?  The .so just got dropped from the standard sparse 'make
install' with the 0.1 release.  If it comes back, I can put it into
the sparse package and the appropriate headers (please specify in the Makefile) into a
sparse-devel subpackage.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
