From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: A sparse warning I dont understand in drivers/hwmon/max16065.c
 [was: smatch warning]
Date: Tue, 06 Aug 2013 07:53:37 -0700
Message-ID: <52010DF1.6050301@roeck-us.net>
References: <52002080.1070701@roeck-us.net> <20130806073105.GP5102@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53540 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab3HFOxe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Aug 2013 10:53:34 -0400
In-Reply-To: <20130806073105.GP5102@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: smatch@vger.kernel.org, linux-sparse@vger.kernel.org

On 08/06/2013 12:31 AM, Dan Carpenter wrote:
> On Mon, Aug 05, 2013 at 03:00:32PM -0700, Guenter Roeck wrote:
>> Hi all,
>>
>> I get the following warning while scanning drivers/hwmon/max16065.c.
>>
>> drivers/hwmon/max16065.c:67:10: warning: Initializer entry defined twice
>> drivers/hwmon/max16065.c:68:10:   also defined here
>> drivers/hwmon/max16065.c:76:10: warning: Initializer entry defined twice
>> drivers/hwmon/max16065.c:77:10:   also defined here
>>
>> I must have looked at the code half a dozen times, but I just
>> don't see what might be wrong.
>>
>> Any idea, anyone ?
>
> This is actually a Sparse warning not a Smatch warning.  To get the
> Smatch warnings (there aren't any) do:

Thanks for the clarification. I updated the subject.

Guenter

> ~/path/to/smatch/smatch_scripts/kchecker --spammy drivers/hwmon/max16065.c
>
> This problem is here is a bug in Sparse handling arrays of _Bool.
> Let me add the Sparse people to the CC list and a small test case.
>
> static _Bool array_name[] = {
> 	[0] = 0,
> 	[1] = 0,
> 	[2] = 0,
> 	[3] = 0,
> };
>
> Sparse complains that element 1 was already initialized.
>
> regards,
> dan carpenter
>
>
>

