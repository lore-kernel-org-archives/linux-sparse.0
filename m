From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] Re: __attribute__ annotations and struct types
Date: Wed, 14 Feb 2007 13:05:29 -0800
Message-ID: <20070214130529.08546166.rdunlap@xenotime.net>
References: <1171483314.14504.9.camel@systems03.mmm.com>
	<20070214201549.GB18753@chrisli.org>
	<1171486927.8554.0.camel@systems03.mmm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:39225 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932590AbXBNVIm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 16:08:42 -0500
Received: from midway.site ([71.245.99.70]) by xenotime.net for <linux-sparse@vger.kernel.org>; Wed, 14 Feb 2007 13:08:38 -0800
In-Reply-To: <1171486927.8554.0.camel@systems03.mmm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel Drake <ddrake@brontes3d.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Wed, 14 Feb 2007 16:02:07 -0500 Daniel Drake wrote:

> On Wed, 2007-02-14 at 12:15 -0800, Christopher Li wrote:
> > On Wed, Feb 14, 2007 at 03:01:54PM -0500, Daniel Drake wrote:
> > > sparse doesn't like it:
> > > 
> > > 	test.c:7:8: error: Trying to use reserved word '__attribute__' 
> > > 	as identifier
> > 
> > Can you please try this:
> > 
> > Chris
> > 
> > Handle structure attribute.
> 
> Thanks for the quick response, works nicely!

so now drivers/kvm/* should be less nasty  ;)

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
