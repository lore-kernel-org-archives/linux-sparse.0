From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 4/5] test-suite: Add -b option to ignore CR at eol on
 MinGW
Date: Tue, 21 May 2013 23:27:00 +0200
Message-ID: <1369171620.10614.0.camel@jlt4.sipsolutions.net>
References: <519BC87D.5080002@ramsay1.demon.co.uk>
	 <20130521211650.GA11463@jtriplet-mobl1>
	 (sfid-20130521_231704_760753_CB790B00)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:55696 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab3EUV1R (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 17:27:17 -0400
In-Reply-To: <20130521211650.GA11463@jtriplet-mobl1> (sfid-20130521_231704_760753_CB790B00)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, 2013-05-21 at 14:16 -0700, Josh Triplett wrote:
> On Tue, May 21, 2013 at 08:18:21PM +0100, Ramsay Jones wrote:
> > Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> -b doesn't just ignore CR at end of line; it would also ignore changes
> in the amount of whitespace elsewhere on the line.  You might consider
> piping the input that has CRs through sed before storing it, to delete
> the CR at end of line before comparing, instead.

Or just use --strip-trailing-cr, no? Or maybe that's not available?

johannes

