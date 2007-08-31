From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: what's with "symbol blah was not declared"
Date: Fri, 31 Aug 2007 06:16:27 +0200
Message-ID: <20070831041627.GA22695@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0708302100090.26586@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:34934 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbXHaEPG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 31 Aug 2007 00:15:06 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708302100090.26586@shark.he.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On Thu, Aug 30, 2007 at 09:05:34PM -0700, Randy.Dunlap wrote:
> 
> e.g., linux kernel source code: init/do_mounts.c, line 23 is:
> 
> int __initdata rd_doload;
> 
> 
> and sparse (snapshot of 2007-08-31) says:
> 
> init/do_mounts.c:23:16: warning: symbol 'rd_doload' was not declared. 
> Should it be static?

IIRC this is because sparse did not see a "extern int rd_doload; in a .h file so
the symbol is most probarly not used outside do_mounts.c.
So it give a hint that this symbol could be made static.

	Sam
