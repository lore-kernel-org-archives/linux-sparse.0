From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 2/8] clean up evaluate_sign()
Date: Fri, 13 Jul 2007 19:06:40 +0100
Message-ID: <20070713180640.GB21668@ftp.linux.org.uk>
References: <E1I9PC1-0000E0-4q@ZenIV.linux.org.uk> <1184349781.2616.39.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48187 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759161AbXGMSGl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 14:06:41 -0400
Content-Disposition: inline
In-Reply-To: <1184349781.2616.39.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Jul 13, 2007 at 11:03:01AM -0700, Josh Triplett wrote:
> > +	if (!(class & (TYPE_FLOAT|TYPE_RESTRICT))) {
> > +		struct symbol *rtype = integer_promotion(ctype);
> >  		expr->unop = cast_to(expr->unop, rtype);
> >  		ctype = rtype;

> Most of this seems quite reasonable and obvious.  I noticed, though,
> that this drops the handling for fouled types; did you do that
> intentionally, and if so could you elaborate on why?

They get folded with handling of restricted - classify_type() gets
TYPE_NUM|TYPE_RESTRICT|TYPE_FOULED for those.
