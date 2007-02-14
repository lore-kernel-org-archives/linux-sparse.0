From: Daniel Drake <ddrake@brontes3d.com>
Subject: Re: [PATCH] Re: __attribute__ annotations and struct types
Date: Wed, 14 Feb 2007 16:02:07 -0500
Message-ID: <1171486927.8554.0.camel@systems03.mmm.com>
References: <1171483314.14504.9.camel@systems03.mmm.com>
	 <20070214201549.GB18753@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp136.iad.emailsrvr.com ([207.97.245.136]:43129 "EHLO
	smtp136.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586AbXBNVCI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 16:02:08 -0500
In-Reply-To: <20070214201549.GB18753@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Wed, 2007-02-14 at 12:15 -0800, Christopher Li wrote:
> On Wed, Feb 14, 2007 at 03:01:54PM -0500, Daniel Drake wrote:
> > sparse doesn't like it:
> > 
> > 	test.c:7:8: error: Trying to use reserved word '__attribute__' 
> > 	as identifier
> 
> Can you please try this:
> 
> Chris
> 
> Handle structure attribute.

Thanks for the quick response, works nicely!

-- 
Daniel Drake
Brontes Technologies, A 3M Company
