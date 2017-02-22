From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: traps: Mark __le16, __le32, __user variables
 properly
Date: Wed, 22 Feb 2017 14:00:21 +0100
Message-ID: <20170222130020.vuk6wc2jwibtpc2h@macpro.local>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
 <20170219015808.2vc2kvpde7nlrey4@macbook.local>
 <148758047729.2988.16966413648865610904@sboyd-linaro>
 <20170220104947.GE9003@leverpostej>
 <20170220213344.dqp4pzxr2dj6vbd3@macpro.local>
 <20170221110355.GD300@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34632 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbdBVNAZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 08:00:25 -0500
Content-Disposition: inline
In-Reply-To: <20170221110355.GD300@arm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, linux-sparse@vger.kernel.org

On Tue, Feb 21, 2017 at 11:03:56AM +0000, Will Deacon wrote:
> On Mon, Feb 20, 2017 at 10:33:45PM +0100, Luc Van Oostenryck wrote:
> > It's easy enough to patch sparse to not issue a warning when the
> > override concerns a range (which would be perfect for the situation here),
> > Controlled or not by a new warning flag. But I'm far from convinced
> > that all uses of such "ranged-initialization" is used for default values
> > that may be later overridden.
> 
> How about not warning only when the overridden range covers the entire
> length of the array? The only broken case I can think of that slips
> through the cracks then is if somebody typoed the range so that it
> accidentally covered the whole array and therefore suppressed the override
> warning.
> 
> Will

I like it. Patch is coming.

Luc
