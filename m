From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] parse: support c99 [static ...] in abstract array
 declarators
Date: Wed, 16 Apr 2014 17:12:34 -0700
Message-ID: <20140417001234.GA18426@leaf>
References: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53448 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbaDQAMl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Apr 2014 20:12:41 -0400
Content-Disposition: inline
In-Reply-To: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Apr 15, 2014 at 04:08:57PM -0700, Cody P Schafer wrote:
> Makes sparse a little more accepting than the standard: we accept any
> number of ["static", "restrict"] repeated in any order, while the n1570
> specifies (in 6.7.6.2.3) that either type-qualifiers (ie: "restrict")
> come first and are followed by "static" or the opposite ("static" then
> type-qualifiers).
> 
> Also add a test.
> 
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>

What's the rationale for this?  Why should sparse accept more than the
standard allows?  What real-world code do you have that requires this?

And would it be worth adding a warning for this non-standards-compliant
code, even if that warning isn't on by default?

- Josh Triplett
