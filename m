From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: Re: Why sparse does not support context tracking?
Date: Mon, 04 May 2015 16:05:59 +0200
Message-ID: <55477CC7.4020807@cetitec.com>
References: <55475272.90705@cetitec.com> <1430746737.2013.22.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54271 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbEDOGM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 May 2015 10:06:12 -0400
In-Reply-To: <1430746737.2013.22.camel@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@freedesktop.org>, Christopher Li <sparse@chrisli.org>

On 05/04/2015 03:38 PM, Johannes Berg wrote:
> On Mon, 2015-05-04 at 13:05  +0200, Alexander Riesen wrote:
 >>
 >>      Revert the context tracking code
 >>
 >> So it seems that the code has problems with different contexts. Still, it seems
 >> a bit heavy-handed to remove it completely (assuming it worked, of course).
 >
 > It didn't really work. It had a lot of issues that were too big for my
 > little wireless-focused brain :)

Ah, pity. Wasn't there any hope for it?


