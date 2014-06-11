From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised by
 sparse
Date: Thu, 12 Jun 2014 00:24:25 +0300
Message-ID: <20140611212425.GW5015@mwanda>
References: <53965E53.5080504@gmail.com>
 <20140610054741.GE5500@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
 <20140611065612.GQ5015@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44886 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbaFKVYu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Jun 2014 17:24:50 -0400
Content-Disposition: inline
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hartley Sweeten <HartleyS@visionengravers.com>
Cc: "Marcos A. Di Pietro" <marcosadp@gmail.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, linux-sparse@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Let's forward this to the Sparse mailing list.

We're seeing a Sparse false positive testing
drivers/staging/comedi/drivers/ni_pcimio.c.

  CHECK   drivers/staging/comedi/drivers/ni_pcimio.c
drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int

I have created some test code to demonstrate the problem (attached).

The check_shift_count() warning is only supposed to be printed for
number literals but because of the way inline functions are expanded it
still complains even though channel is a variable.

regards,
dan carpenter


--pWyiEgJYm5f9v55/
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test_shift.c"

#include <stdio.h>
#include <limits.h>
#include <string.h>

static inline unsigned ni_stc_dma_channel_select_bitfield(unsigned channel)
{
	if (channel < 4)
		return 1 << channel;
	return 0;
}

static inline void filter(int channel)
{
	if (channel < 0)
		return;
	ni_stc_dma_channel_select_bitfield(channel);
}

int main(void)
{
	filter(-1);

	return 0;
}

--pWyiEgJYm5f9v55/--
