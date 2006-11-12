From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: sparse as a compiler front-end
Date: Sat, 11 Nov 2006 21:04:53 -0600
Message-ID: <20061112030453.GA20415@humbolt.us.dell.com>
References: <45564680.8090806@garzik.org> <20061111235002.GA15184@humbolt.us.dell.com> <45567CC5.4030806@garzik.org>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:37907 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1754926AbWKLDEz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Nov 2006 22:04:55 -0500
Content-Disposition: inline
In-Reply-To: <45567CC5.4030806@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Sat, Nov 11, 2006 at 08:45:41PM -0500, Jeff Garzik wrote:
> Matt Domsch wrote:
> >On Sat, Nov 11, 2006 at 04:54:08PM -0500, Jeff Garzik wrote:
> >>I see that sparse made it into Fedora Extras, so that 'yum install' 
> >>automatically pulls it down for me.  Yay!  Thanks, Matt.
> >>
> >>Can libsparse.a and necessary includes be packaged as well?
> >
> >.a or .so?  The .so just got dropped from the standard sparse 'make
> 
> Doesn't matter to me...  Something is better than nothing.  With 
> sparse's license, .a is no big deal.

Fedora Extras strongly discourages shipping and using .a if only to
ensure that any security issue uncovered can be addressed without
always rebuilding all downstream dependent apps.  Not too likely a
problem with a tool like sparse, but always a concern.

The .so would need to start being versioned, and care paid to bump the
version as the ABIs change.

That's one thing the opensuse build system does differently - tracking
the full dependency tree, and automatically rebuilding all downstream
dependent apps when an upstream app changes.


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
