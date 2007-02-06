From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Re: error, types differ in signedness
Date: Mon, 5 Feb 2007 16:16:22 -0800
Message-ID: <20070206001622.GB14964@chrisli.org>
References: <20070205105420.6f19a57d.rdunlap@xenotime.net> <20070205200617.GA14964@chrisli.org> <1170714431.1453.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:53990 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965393AbXBFAoD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 5 Feb 2007 19:44:03 -0500
Content-Disposition: inline
In-Reply-To: <1170714431.1453.10.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Mon, Feb 05, 2007 at 05:27:11PM -0500, Pavel Roskin wrote:
> I think any difference between declarations other than missing argument
> names is an example of sloppy coding and should be avoided.

The original warning about pointer signedness difference is simply wrong.

There might be value to have warning about function vs function pointer. 
On the other hand, some attribute can be only specified in function prototype
declares but not the function body.

> I would prefer that sparse emits a specific warning about function vs
> function pointer mismatch.  Even if it doesn't matter, it makes the code
> easier to read and safer to modify.

I did not find a easy way to do it yet.

Chris
