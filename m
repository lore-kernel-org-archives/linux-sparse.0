From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Warn for extern prototypes
Date: Wed, 30 Apr 2014 23:30:57 +0300
Message-ID: <20140430203056.GJ26890@mwanda>
References: <20140430200730.GA11100@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36918 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759296AbaD3UbH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Apr 2014 16:31:07 -0400
Content-Disposition: inline
In-Reply-To: <20140430200730.GA11100@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 30, 2014 at 10:07:30PM +0200, Sam Ravnborg wrote:
> The rationale behind this is that at least in some areas of the kernel,
> the use of "extern" for prototypes are no longer accepted.
> A sparse warnings would be good to tell me all the cases I missed
> in the conversion.

Doesn't checkpatch.pl already check for this?

regards,
dan carpenter

