From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Re: error, types differ in signedness
Date: Mon, 05 Feb 2007 17:27:11 -0500
Message-ID: <1170714431.1453.10.camel@dv>
References: <20070205105420.6f19a57d.rdunlap@xenotime.net>
	 <20070205200617.GA14964@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:47020 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996AbXBEW1P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 5 Feb 2007 17:27:15 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HECHm-0002H2-HR
	for linux-sparse@vger.kernel.org; Mon, 05 Feb 2007 17:26:06 -0500
In-Reply-To: <20070205200617.GA14964@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

Chris,

On Mon, 2007-02-05 at 12:06 -0800, Christopher Li wrote:
> On Mon, Feb 05, 2007 at 10:54:20AM -0800, Randy Dunlap wrote:
> > The skbuff.[hc] difference is in *getfrag vs. getfrag.
> > The mpage.[hc] difference is in  *get_block vs. getblock.

I remember having this problem in MadWifi, and it was hard to understand
what was going on.  I had to put the declarations back-to-back and look
at them very carefully.

> > Questions:
> > 1.  Is the warning valid?
> 
> I don't think so.

I think any difference between declarations other than missing argument
names is an example of sloppy coding and should be avoided.

> > 2.  Isn't the '*' unnecessary?
> 
> It is valid in C without '*'. Sparse already know the function
> is going to degenerated into function pointers. It wrongly inherent
> the signedness. You get a signed pointer.
> 
> Can you please try this patch?

I would prefer that sparse emits a specific warning about function vs
function pointer mismatch.  Even if it doesn't matter, it makes the code
easier to read and safer to modify.

-- 
Regards,
Pavel Roskin
