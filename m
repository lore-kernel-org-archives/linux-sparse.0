From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: relicensing Sparse
Date: Wed, 10 Aug 2011 16:09:39 -0700
Message-ID: <20110810230939.GA9423@leaf>
References: <20110810220806.GD3777@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40455 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab1HJXJq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Aug 2011 19:09:46 -0400
Content-Disposition: inline
In-Reply-To: <20110810220806.GD3777@shale.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Aug 11, 2011 at 01:08:06AM +0300, Dan Carpenter wrote:
> All of you probably know that I've been contacting people to try get
> permission to relicense Sparse to the MIT license.  The Transmeta
> code was relicensed some years ago but we needed to collect all
> the copyright holders to do a full relicense.  I basically did a git
> blame and if you have over 10 lines of Sparse code, then I sent you
> an email.

Thank you very much for your continued effort on this.  I'd wondered
what still blocked that effort.

Checking "git blame" doesn't seem sufficient; I think you really want to
contact anyone who has a commit in the git log.  Try "git shortlog -se".
Who appears on the latter list and not your list from "git blame"?

> I havent' been able to reach these two people:
> Luc Van Oostenryck <luc.vanoostenryck@looxix.net> (279 lines)
> Richard Knutsson <ricknu-0@student.ltu.se>        (21 lines)
> 
> Does anyone know how I can reach them?  Are they on this list?

Richard Knutsson worked on Sparse for Google Summer of Code in 2007.
Thus, the SoC admins might still have full contact information for him,
not just an email address.  You could ask the SoC admins if they'd be
willing to contact Richard privately on your behalf.  (I think they'd
want to avoid sharing the non-email contact information directly for
privacy reasons, but they might consider making the contact for you.)

For Luc Van Oostenryck, a quick check shows that looxix.net existed from
2005 until it expired just a couple of months ago; odd timing.

- Josh Triplett
