From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Why sparse does not support context tracking?
Date: Mon, 04 May 2015 15:38:57 +0200
Message-ID: <1430746737.2013.22.camel@sipsolutions.net>
References: <55475272.90705@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:46056 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbbEDNjB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 May 2015 09:39:01 -0400
In-Reply-To: <55475272.90705@cetitec.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexander Riesen <alexander.riesen@cetitec.com>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@freedesktop.org>, Christopher Li <sparse@chrisli.org>

On Mon, 2015-05-04 at 13:05 +0200, Alexander Riesen wrote:
> Hi,
> 
> I tried to instrument my code (a kernel driver) with __must_hold hints
> and noticed that they don't really work: a definitely broken code caused
> no errors from sparse.

>      Revert the context tracking code

> So it seems that the code has problems with different contexts. Still, it seems
> a bit heavy-handed to remove it completely (assuming it worked, of course).

It didn't really work. It had a lot of issues that were too big for my
little wireless-focused brain :)

johannes

