From: Christopher Li <sparse@chrisli.org>
Subject: Re: exposing __attribute__ portability macros in lib.h; any objections?
Date: Mon, 26 Feb 2007 02:43:48 -0800
Message-ID: <20070226104348.GA27482@chrisli.org>
References: <1172251518.6229.6.camel@dv> <1172260766.14431.3.camel@dv> <20070223223027.GA5671@chrisli.org> <45E21189.1060202@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:48176 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbXBZLQS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Feb 2007 06:16:18 -0500
Content-Disposition: inline
In-Reply-To: <45E21189.1060202@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Sun, Feb 25, 2007 at 02:45:29PM -0800, Josh Triplett wrote:
> Applied.

Thanks!

> 
> I'd also like to apply a patch to use __attribute__((__sentinel__)) on
> match_idents, which would have caught this problem.  In order to do so
> portably, I plan to add a portability macro SENTINEL_ATTR, like the
> FORMAT_ATTR macro currently in lib.h.  However, lib.h currently defines
> FORMAT_ATTR, uses it for a few prototypes, and then undefines it.  Any
> objections to defining SENTINEL_ATTR and leaving it defined (and probably
> doing the same for FORMAT_ATTR)?  I don't think those would pollute the
> namespace any more than lib.h already does with position, verbose, info, and
> similar.

No objection for __sentinel__ per se. In the long run, I would like to
get ride of match_idents completely. I want to define more parser
operation function for pre-defined keywords. So it is driven by the
symbol table rather than comparing the keyword one by one. It is a
big change though.

Chris
