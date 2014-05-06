From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] staging: rtl8192u: initialize array in C compliant way
Date: Tue, 6 May 2014 12:59:34 -0700
Message-ID: <CANeU7QmZXJ0KqVvkLfqxF6CGx81KQ93S++ViR9smWRTj8_6Dtg@mail.gmail.com>
References: <1399364528-3727-1-git-send-email-martink@posteo.de>
	<20140506084749.GT26890@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:45404 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbaEFT7f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 May 2014 15:59:35 -0400
In-Reply-To: <20140506084749.GT26890@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Martin Kepplinger <martink@posteo.de>, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-kernel <linux-kernel@vger.kernel.org>, burzalodowa@gmail.com, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, May 6, 2014 at 1:47 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> -     bool                            search_dir[4] = {0, 0, 0, 0};
>> +     bool                            search_dir[4] = {0};
>
> That's weird.  The original code is valid but it generates a sparse
> warning.
>
> drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c:244:58: warning: Initializer entry defined twice
> drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c:244:61:   also defined here
>
> It has something to do with "_Bool" types.  Changing it to "int" will
> also make the warning disappear.  I've CC'd the sparse list to see if
> anyone knows what's happening.

This is easy reproducible with a small test case. It is a sparse bug for sure.

Let me take a look.

Chris
