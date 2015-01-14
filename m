From: Bastien Nocera <hadess@hadess.net>
Subject: Re: False positives unlock warning
Date: Wed, 14 Jan 2015 18:42:40 +0100
Message-ID: <1421257360.2075.1.camel@hadess.net>
References: <1421243218.2542.45.camel@hadess.net>
	 <20150114141143.GH5571@mwanda> <1421245172.2542.50.camel@hadess.net>
	 <20150114164127.GD5520@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36947 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbbANRnp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Jan 2015 12:43:45 -0500
In-Reply-To: <20150114164127.GD5520@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-sparse@vger.kernel.org

On Wed, 2015-01-14 at 19:41 +0300, Dan Carpenter wrote:
> Sparse gets confused because of the unused "_success_exit:" label.  If
> you delete that it should go away.  In "real" kernel code GCC will warn
> about unused labels.

Unfortunately, the problem in core/rtw_xmit.c is the same warning, but
this time the label is used.

Cheers

