From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: A smatch warning I dont understand in drivers/hwmon/max16065.c
Date: Tue, 6 Aug 2013 10:31:05 +0300
Message-ID: <20130806073105.GP5102@mwanda>
References: <52002080.1070701@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27315 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab3HFHbR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Aug 2013 03:31:17 -0400
Content-Disposition: inline
In-Reply-To: <52002080.1070701@roeck-us.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: smatch@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Aug 05, 2013 at 03:00:32PM -0700, Guenter Roeck wrote:
> Hi all,
> 
> I get the following warning while scanning drivers/hwmon/max16065.c.
> 
> drivers/hwmon/max16065.c:67:10: warning: Initializer entry defined twice
> drivers/hwmon/max16065.c:68:10:   also defined here
> drivers/hwmon/max16065.c:76:10: warning: Initializer entry defined twice
> drivers/hwmon/max16065.c:77:10:   also defined here
> 
> I must have looked at the code half a dozen times, but I just
> don't see what might be wrong.
> 
> Any idea, anyone ?

This is actually a Sparse warning not a Smatch warning.  To get the
Smatch warnings (there aren't any) do:
~/path/to/smatch/smatch_scripts/kchecker --spammy drivers/hwmon/max16065.c

This problem is here is a bug in Sparse handling arrays of _Bool.
Let me add the Sparse people to the CC list and a small test case.

static _Bool array_name[] = {
	[0] = 0,
	[1] = 0,
	[2] = 0,
	[3] = 0,
};

Sparse complains that element 1 was already initialized.

regards,
dan carpenter

