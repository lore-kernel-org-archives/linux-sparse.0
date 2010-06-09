From: Dan Carpenter <error27@gmail.com>
Subject: Re: help for using sparse
Date: Wed, 9 Jun 2010 18:59:44 +0200
Message-ID: <20100609165944.GH5483@bicker>
References: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr> <20100609161058.GA4204@feather> <6d9debf589b058363c8b89ea9248a811@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:59593 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab0FIRAH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Jun 2010 13:00:07 -0400
Received: by ey-out-2122.google.com with SMTP id 9so226334eyd.5
        for <linux-sparse@vger.kernel.org>; Wed, 09 Jun 2010 10:00:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6d9debf589b058363c8b89ea9248a811@ensimag.fr>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: bonneta <bonneta@ensimag.fr>
Cc: linux-sparse@vger.kernel.org

On Wed, Jun 09, 2010 at 06:35:31PM +0200, bonneta wrote:
> Thank you all, it works fine.
> Does sparse look for all the errors with this method?

Don't know the defaults.

> 
> I saw in the sparse man page that a "Wsparse-all" option exists. 
> Is it used by default? Otherwise how to use it in the "make" command line?
> 

CHECK="~/path/to/sparse --params" make CC=~/path/to/cgcc

regards,
dan carpenter

