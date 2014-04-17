From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] parse: support c99 [static ...] in abstract array
 declarators
Date: Wed, 16 Apr 2014 22:09:14 -0700
Message-ID: <20140417050914.GA21150@leaf>
References: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com>
 <20140417001234.GA18426@leaf>
 <534F4F7F.5020506@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43235 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaDQFJV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Apr 2014 01:09:21 -0400
Content-Disposition: inline
In-Reply-To: <534F4F7F.5020506@linux.vnet.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Apr 16, 2014 at 08:50:23PM -0700, Cody P Schafer wrote:
> On 04/16/2014 05:12 PM, Josh Triplett wrote:
> >On Tue, Apr 15, 2014 at 04:08:57PM -0700, Cody P Schafer wrote:
> >>Makes sparse a little more accepting than the standard: we accept any
> >>number of ["static", "restrict"] repeated in any order, while the n1570
> >>specifies (in 6.7.6.2.3) that either type-qualifiers (ie: "restrict")
> >>come first and are followed by "static" or the opposite ("static" then
> >>type-qualifiers).
> >>
> >>Also add a test.
> >>
> >>Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> >
> >What's the rationale for this?  Why should sparse accept more than the
> >standard allows?  What real-world code do you have that requires this?
> >
> >And would it be worth adding a warning for this non-standards-compliant
> >code, even if that warning isn't on by default?
> 
> I could have sparse be just as strict as the standard, it just was just
> (much) simpler to make it liberal in what it accepts. If you're fine with
> some more verbose code, I'll put together something that is stricter.

I'd suggest trying to match the standard in this case, or failing that
match what GCC does.

- Josh Triplett
