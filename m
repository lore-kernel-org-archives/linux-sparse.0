From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results
	into test files
Date: Thu, 28 Jun 2007 17:21:53 -0400
Message-ID: <1183065713.5368.10.camel@dv>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
	 <20070628054019.30704.64375.stgit@dv.roinet.com>
	 <46836129.7050407@freedesktop.org>
	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:40361 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761058AbXF1VV6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 17:21:58 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I41R7-0006zV-29
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 17:21:57 -0400
In-Reply-To: <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Hello Damien,

On Thu, 2007-06-28 at 20:59 +0200, Damien Lespiau wrote:

> I happen to have 3 patches in my tree that look like this one. I
> thought you might
> want to have a look as they appear to handle the points you were wanting to fix.
> Patch 3 is a "documentation patch" that explains what I wanted to do.

I see your testsuite is much more sophisticated, since it can handle:

- known bad tests
- return codes other than 0
- stdout (combined with stderr)
- test-specific sparse flags

More verbose keywords also look better.  And having the documentation is
another advantage.

I don't think I'll be able to match what you have done (unless you see a
patch from me within the next hour).  Maybe your testsuite could be
applied instead?

-- 
Regards,
Pavel Roskin
