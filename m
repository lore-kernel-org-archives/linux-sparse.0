From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux kernel warnings/errors (#7)
Date: Tue, 23 Feb 2010 14:40:03 -0800
Message-ID: <4B845943.10507@xenotime.net>
References: <20100223114906.61d4e001.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:34243 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754127Ab0BWWkF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Feb 2010 17:40:05 -0500
Received: from chimera.site ([71.245.98.113]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 23 Feb 2010 14:40:03 -0800
In-Reply-To: <20100223114906.61d4e001.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 02/23/10 11:49, Randy Dunlap wrote:
> Hi,
> 
> You probably know that sparse produces a ton of errors & warnings when
> run on the Linux kernel tree (a little over 1 MB in my latest 'make C=1'
> on x86_64 arch.).
> 
> I'm wondering if all of these are valid.
> 
> Examples:

(one addition)


7.  from drivers/gpu/drm/radeon/atombios.h:

#define VESA_OEM_PRODUCT_REV			            '01.00'
#define VESA_MODE_ATTRIBUTE_MODE_SUPPORT	     0xBB	/* refer to VBE spec p.32, no TTY support */


causes sparse to say:

drivers/gpu/drm/radeon/atombios.h:4091:63: error: Bad character constant
drivers/gpu/drm/radeon/atombios.h:4092:1: error: Bad character constant


That second one is a bit confusing.  It's just a remnant of the first one...

-- 
~Randy
