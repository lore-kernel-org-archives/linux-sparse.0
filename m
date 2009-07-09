From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [PATCH] kmemcheck: fix sparse warning
Date: Thu, 09 Jul 2009 11:48:10 +0200
Message-ID: <1247132890.25570.3.camel@spike.firmix.at>
References: <1246873983.20908.0.camel@johannes.local>
	 <19f34abd0907081228p541d1cdao85f37aaa479fcfc5@mail.gmail.com>
	 <20090709062906.GA14804@feather>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:1612 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758225AbZGIJyu (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 9 Jul 2009 05:54:50 -0400
Received: from buffy.firmix.at (gate.firmix.at [80.109.18.208])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id n699mCOh015749
	for <linux-sparse@vger.kernel.org>; Thu, 9 Jul 2009 11:48:12 +0200
Received: from [10.0.0.138] (spike.firmix.at [10.0.0.138])
	(authenticated bits=0)
	by buffy.firmix.at (8.13.8/8.13.8) with ESMTP id n699mBrc006061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 9 Jul 2009 11:48:11 +0200
In-Reply-To: <20090709062906.GA14804@feather>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

[ stripped people from To: and Cc: - far too trivial and well-known
answer ]

On Wed, 2009-07-08 at 23:29 -0700, Josh Triplett wrote:
> [Adding Linus and Chris Li to CC; Linus for further background on
> -Wdo-while, and Chris Li for Sparse.]
[....]
> Much discussion has occurred previously suggesting that Sparse's -Wall
> should match GCC's "all useful warnings" rather than "all possible
this is usually phrased as "all useful warnings in RMS opinion". I'm not
sure how far RMS influence is today on that.

> warnings", and some other option should exist for "all possible
> warnings" (for instance, -Weverything).  This seems very reasonable.
gcc's has "-Wextra" since ages which enables lots of other (IMHO) useful
warnings.
But it's just a name ....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


