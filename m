From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: False positives unlock warning
Date: Wed, 14 Jan 2015 17:11:43 +0300
Message-ID: <20150114141143.GH5571@mwanda>
References: <1421243218.2542.45.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:18607 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbANOLx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Jan 2015 09:11:53 -0500
Content-Disposition: inline
In-Reply-To: <1421243218.2542.45.camel@hadess.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-sparse@vger.kernel.org

On Wed, Jan 14, 2015 at 02:46:58PM +0100, Bastien Nocera wrote:
> Hey,
> 
> The following project (a device driver which should compile with kernel
> 3.17 and above) throws a few false positives with "make C=1":
> core/rtw_recv.c:3406:26: warning: context imbalance in 'recv_indicatepkt_reorder' - unexpected unlock
> core/rtw_xmit.c:4300:6: warning: context imbalance in 'xmit_delivery_enabled_frames' - wrong count at exit

This could be either of:

	drivers/staging/rtl8723au/core/rtw_recv.c
	drivers/staging/rtl8188eu/core/rtw_recv.c

Neither one of these give me that warning.  I'm using the latest Sparse
from git and today's linux-next.  Can you give us some more hints what
you're talking about?

regards,
dan carpenter

