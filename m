From: Bastien Nocera <hadess@hadess.net>
Subject: Re: False positives unlock warning
Date: Wed, 14 Jan 2015 15:19:32 +0100
Message-ID: <1421245172.2542.50.camel@hadess.net>
References: <1421243218.2542.45.camel@hadess.net>
	 <20150114141143.GH5571@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40422 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbbANOUY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Jan 2015 09:20:24 -0500
In-Reply-To: <20150114141143.GH5571@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-sparse@vger.kernel.org

On Wed, 2015-01-14 at 17:11 +0300, Dan Carpenter wrote:
> On Wed, Jan 14, 2015 at 02:46:58PM +0100, Bastien Nocera wrote:
> > Hey,
> > 
> > The following project (a device driver which should compile with kernel
> > 3.17 and above) throws a few false positives with "make C=1":
> > core/rtw_recv.c:3406:26: warning: context imbalance in 'recv_indicatepkt_reorder' - unexpected unlock
> > core/rtw_xmit.c:4300:6: warning: context imbalance in 'xmit_delivery_enabled_frames' - wrong count at exit
> 
> This could be either of:
> 
> 	drivers/staging/rtl8723au/core/rtw_recv.c
> 	drivers/staging/rtl8188eu/core/rtw_recv.c
> 
> Neither one of these give me that warning.  I'm using the latest Sparse
> from git and today's linux-next.  Can you give us some more hints what
> you're talking about?

Duh. I forgot the link to my repository (which isn't upstream yet, as it
needs cleaning up before submission, including fixing sparse warnings).

This is the code in question:
https://github.com/hadess/rtl8723bs/blob/master/core/rtw_recv.c#L3238
and:
https://github.com/hadess/rtl8723bs/blob/master/core/rtw_xmit.c#L4300

Sorry about that.

