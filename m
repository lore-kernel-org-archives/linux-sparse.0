From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: False positives unlock warning
Date: Wed, 14 Jan 2015 23:54:42 +0300
Message-ID: <20150114205442.GA6201@mwanda>
References: <1421243218.2542.45.camel@hadess.net>
 <20150114141143.GH5571@mwanda>
 <1421245172.2542.50.camel@hadess.net>
 <20150114164127.GD5520@mwanda>
 <1421257360.2075.1.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32231 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbANUy7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Jan 2015 15:54:59 -0500
Content-Disposition: inline
In-Reply-To: <1421257360.2075.1.camel@hadess.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-sparse@vger.kernel.org

On Wed, Jan 14, 2015 at 06:42:40PM +0100, Bastien Nocera wrote:
> On Wed, 2015-01-14 at 19:41 +0300, Dan Carpenter wrote:
> > Sparse gets confused because of the unused "_success_exit:" label.  If
> > you delete that it should go away.  In "real" kernel code GCC will warn
> > about unused labels.
> 
> Unfortunately, the problem in core/rtw_xmit.c is the same warning, but
> this time the label is used.

The goto has been ifdeffed out.  Try deleting the "exit:" label.  It
still compiles fine for me and the warning is gone.

regards,
dan carpenter

