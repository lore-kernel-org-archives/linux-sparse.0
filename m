From: Dan Carpenter <error27@gmail.com>
Subject: Re: improper sparse warnings in linux kernel build?
Date: Fri, 9 Sep 2011 22:27:19 -0700
Message-ID: <20110910052719.GC4807@mwanda>
References: <201109091541.28395.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46073 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1IJF14 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 Sep 2011 01:27:56 -0400
Content-Disposition: inline
In-Reply-To: <201109091541.28395.hartleys@visionengravers.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-sparse@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Fri, Sep 09, 2011 at 03:41:28PM -0700, H Hartley Sweeten wrote:
> I'm not really sure what the DEFINE_PER_CPU macro expands to so I'm not
> sure if the 'static' in front is actually getting used or if sparse is just
> confused.
> 
> Is this an actual problem in the linux kernel or is sparse just getting
> tripped up by the DEFINE_PER_CPU macro?
> 

I don't have a kernel git archive handy, but probably sparse is
correct.  Do a "make arch/x86/kernel/cpu/mcheck/mce_intel.i" and run
sparse on the .i file to find the line number that complains.

regards,
dan carpenter

