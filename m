From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Trying to understand linearized output
Date: Sun, 12 Mar 2017 18:10:22 +0100
Message-ID: <20170312171021.ivhh2fjyyj3xcgb5@macpro.local>
References: <CACXZuxfTBH2hr8kOXepJ7VGCrfvjMU3h8GhDfZhtPEA6Ynw6jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37186 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933837AbdCLRKl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 13:10:41 -0400
Received: by mail-wm0-f48.google.com with SMTP id n11so25348047wma.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 10:10:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfTBH2hr8kOXepJ7VGCrfvjMU3h8GhDfZhtPEA6Ynw6jA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 02:11:37PM +0000, Dibyendu Majumdar wrote:
> ...
>
> My question is:
> 
> phisrc.64   %phi98(current) <- %r333
> 
> The phi98 above is presumably referencing a pseudo which has number
> 98. But this is not part of this function, so I am confused. Does this
> look right?

I didn't checked all the details by it looks right.

The %phi98 is not referencing a pseudo which has the number 98.
It is a pseudo numbered 98 and which is of type PSEUDO_PHI.
Those kind of pseudos are exclusively created by 'phisrc' instructions
and used by 'phi' instructions.
Here this %phi98 is used by the phi instructions at block .L127

These 'phi' instructions are the core of the SSA representation of
intermediate code. If needed Wikipedia gives a good introduction:
	 https://en.wikipedia.org/wiki/Static_single_assignment_form

-- Luc Van Oostenryck
