From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Re: error, types differ in signedness
Date: Tue, 6 Feb 2007 10:36:14 -0800
Message-ID: <20070206183614.GA26248@chrisli.org>
References: <20070205105420.6f19a57d.rdunlap@xenotime.net> <20070205200617.GA14964@chrisli.org> <1170714431.1453.10.camel@dv> <20070206001622.GB14964@chrisli.org> <20070205201255.j8kk0w80gsggo4oo@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.200.82]:43707 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965299AbXBFTEL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Feb 2007 14:04:11 -0500
Content-Disposition: inline
In-Reply-To: <20070205201255.j8kk0w80gsggo4oo@webmail.spamcop.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Mon, Feb 05, 2007 at 08:12:55PM -0500, Pavel Roskin wrote:
> 
> I see.  I thought it was easy.  Then your patch is fine for me.  It's better to
> have no warning than a misleading warning about a stylistic issue.

Sparse care about type difference. What you are asking is not difference
in type. It is the difference in which path it took to reach that type.
E.g. using default degenerating rules or typedefs. Sparse does not
store that information.

Chris
