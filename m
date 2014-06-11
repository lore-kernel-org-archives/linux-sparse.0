From: josh@joshtriplett.org
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised
 by sparse
Date: Wed, 11 Jun 2014 14:45:29 -0700
Message-ID: <20140611214529.GB16940@cloud>
References: <53965E53.5080504@gmail.com>
 <20140610054741.GE5500@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
 <20140611065612.GQ5015@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
 <20140611212425.GW5015@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37335 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbaFKVpf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Jun 2014 17:45:35 -0400
Content-Disposition: inline
In-Reply-To: <20140611212425.GW5015@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Hartley Sweeten <HartleyS@visionengravers.com>, "Marcos A. Di Pietro" <marcosadp@gmail.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, linux-sparse@vger.kernel.org

On Thu, Jun 12, 2014 at 12:24:25AM +0300, Dan Carpenter wrote:
> Let's forward this to the Sparse mailing list.
> 
> We're seeing a Sparse false positive testing
> drivers/staging/comedi/drivers/ni_pcimio.c.
> 
>   CHECK   drivers/staging/comedi/drivers/ni_pcimio.c
> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> 
> I have created some test code to demonstrate the problem (attached).
> 
> The check_shift_count() warning is only supposed to be printed for
> number literals but because of the way inline functions are expanded it
> still complains even though channel is a variable.

Thanks for the test case; this definitely makes no sense.  I don't think
Sparse will suddenly develop enough range analysis or reachability
analysis to handle this case; I think the right answer is to avoid
giving such warnings for shifts with a non-constant RHS.

> #include <stdio.h>
> #include <limits.h>
> #include <string.h>
> 
> static inline unsigned ni_stc_dma_channel_select_bitfield(unsigned channel)
> {
> 	if (channel < 4)
> 		return 1 << channel;
> 	return 0;
> }
> 
> static inline void filter(int channel)
> {
> 	if (channel < 0)
> 		return;
> 	ni_stc_dma_channel_select_bitfield(channel);
> }
> 
> int main(void)
> {
> 	filter(-1);
> 
> 	return 0;
> }

