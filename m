From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Using smatch on Chrome OS kernel, cannot process "__restrict__"
Date: Thu, 20 Dec 2012 10:22:13 +0300
Message-ID: <20121220072212.GO5032@mwanda>
References: <CANV8Hs2xfNo3cZ1Cp5T_F2U2vPr0ybGDrP4c=fMsNXDED7vj=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29938 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2LTHWL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 20 Dec 2012 02:22:11 -0500
Content-Disposition: inline
In-Reply-To: <CANV8Hs2xfNo3cZ1Cp5T_F2U2vPr0ybGDrP4c=fMsNXDED7vj=g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Simon Que <sque@google.com>
Cc: smatch@vger.kernel.org, linux-sparse@vger.kernel.org

On Wed, Dec 19, 2012 at 06:06:43PM -0800, Simon Que wrote:
> Hi,
> 
> I am trying to apply smatch to the Chrome OS kernel, which is a
> modified Linux Kernel 3.4.  There is one "error" that smatch is having
> trouble processing.  It is in drivers/md/dm-bht.c:
> 
>     sprintf((char *__restrict__)hex, "%02hhx", (int)*binary);
> 
> The word "__restrict__" is throwing off smatch somehow and it causes
> the build to fail.
> 
> When I run make without smatch, the build passes.
> When remove the "__restrict__" and make CHECK=smatch, the build passes.
> 

Thanks for the report.  That's a Sparse thing.

I'll commit this patch with a:
Reported-by: Simon Que <sque@google.com>

regards,
dan carpenter

diff --git a/parse.c b/parse.c
index 5dd9a06..bf5894d 100644
--- a/parse.c
+++ b/parse.c
@@ -419,6 +419,7 @@ static struct init_keyword {
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
