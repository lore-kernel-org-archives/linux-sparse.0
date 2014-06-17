From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] lib.c: skip --param parameters
Date: Mon, 16 Jun 2014 19:36:48 -0700
Message-ID: <20140617023648.GA5961@thin>
References: <1402915386-28210-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20140616160238.GA2746@jtriplet-mobl1>
 <alpine.DEB.2.02.1406161647510.21018@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35043 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbaFQCg4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 16 Jun 2014 22:36:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1406161647510.21018@chino.kir.corp.google.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Jun 16, 2014 at 04:48:51PM -0700, David Rientjes wrote:
> On Mon, 16 Jun 2014, Josh Triplett wrote:
> 
> > On Mon, Jun 16, 2014 at 01:43:06PM +0300, Andy Shevchenko wrote:
> > > Very dumb patch to just skip --param allow-store-data-races=0 introduced in
> > > newest Linux kernel buildsystem.
> > > 
> > > Actually the option is present in few GCC versions and probably should be
> > > handled properly.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > As far as I can tell, this seems to only handle "--param arg"; however,
> > according to the thread on LKML, GCC handles --param=arg as well.  Could
> > you please handle that variant too?
> > 
> 
> This is only from linux-next and not Linus's tree, correct?
> 
> Is this still necessary since the "./Makefile: tell gcc optimizer to never 
> introduce new data races" patch has been removed from -mm due to failures?
> 
> See http://marc.info/?l=linux-mm-commits&m=140295825623471

I'd still like to see Sparse not choke on the option, in either form,
whether the kernel ends up using it or not.

- Josh Triplett
