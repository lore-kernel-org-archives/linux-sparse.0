From: Dan Carpenter <error27@gmail.com>
Subject: Re: relicensing Sparse
Date: Thu, 11 Aug 2011 13:39:08 +0300
Message-ID: <20110811103908.GI3777@shale.localdomain>
References: <20110810220806.GD3777@shale.localdomain>
 <20110810230939.GA9423@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:42660 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab1HKKlZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Aug 2011 06:41:25 -0400
Received: by pzk37 with SMTP id 37so3463912pzk.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 Aug 2011 03:41:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110810230939.GA9423@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

On Wed, Aug 10, 2011 at 04:09:39PM -0700, Josh Triplett wrote:
> On Thu, Aug 11, 2011 at 01:08:06AM +0300, Dan Carpenter wrote:
> > All of you probably know that I've been contacting people to try get
> > permission to relicense Sparse to the MIT license.  The Transmeta
> > code was relicensed some years ago but we needed to collect all
> > the copyright holders to do a full relicense.  I basically did a git
> > blame and if you have over 10 lines of Sparse code, then I sent you
> > an email.
> 
> Thank you very much for your continued effort on this.  I'd wondered
> what still blocked that effort.
> 
> Checking "git blame" doesn't seem sufficient; I think you really want to
> contact anyone who has a commit in the git log. Try "git shortlog -se".
> Who appears on the latter list and not your list from "git blame"?

Most of the people who I missed would have been filtered out anyway
by my ten lines of code minimum contribution requirement.  Perhaps I
should just contact everyone.

I looked at how Mozilla did the relicensing and they pretty much went
by who had their name in a copyright notice at the top of the file.
For files without a copyright notice they looked at the history.  So
it seems like tiny contributions were ignored.

I'm obviously not a lawyer.  Contacting everyone is probably doable
if that's what you think is best.

regards,
dan carpenter

