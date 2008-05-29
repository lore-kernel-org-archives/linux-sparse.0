From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Thu, 29 May 2008 19:03:19 -0400
Message-ID: <1212102199.4265.46.camel@dv>
References: <20080529085402.814224000@sipsolutions.net>
	 <1212100516.28403.152.camel@brick>
	 (sfid-20080530_003519_648056_2583259D)  <1212101102.10109.5.camel@johannes.berg>
	 <1212101465.28403.156.camel@brick>
	 (sfid-20080530_005109_203270_E4619B0E)  <1212101645.10109.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:30821 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275AbYE2XDV (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 19:03:21 -0400
In-Reply-To: <1212101645.10109.7.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

On Fri, 2008-05-30 at 00:54 +0200, Johannes Berg wrote:
> > > What sort? Right now, it seems to go into a dead loop on
> > > fs/minix/itree_v1.c for me?!
> > > 
> > 
> > It's a problem introduced with 9/9 explicitly checking inlines.
> 
> Cool, thanks, I'm just looking at it.

You may want to look at this:
http://marc.info/?t=120287346100007&r=1&w=2
http://marc.info/?l=linux-sparse&m=120370800715845&w=2

It was happening in ndiswrapper because a typedef was forcing an inline
function to be linearized twice.

-- 
Regards,
Pavel Roskin
