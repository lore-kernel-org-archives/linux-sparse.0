From: Dan Carpenter <error27@gmail.com>
Subject: Re: "advancing past deep designator" warnings
Date: Mon, 30 May 2011 09:21:41 +0300
Message-ID: <20110530062141.GH3099@shale.localdomain>
References: <20110529145712.eefa4d52.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64874 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1E3GV7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 May 2011 02:21:59 -0400
Received: by wwa36 with SMTP id 36so3581430wwa.1
        for <linux-sparse@vger.kernel.org>; Sun, 29 May 2011 23:21:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110529145712.eefa4d52.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On Sun, May 29, 2011 at 02:57:12PM -0700, Randy Dunlap wrote:
> Hi,
> 
> Can you give me an idea about what this warning means and what to do about it?
> Thanks.
>

It means that you have an array declared like:
	int x[] = {
		[4] = 5,  <-- designator.
		6         <-- advance one step.
	};

GCC handles these correctly, so I don't think we'd want to change
anything in the kernel because of them.

regards,
dan carpenter
