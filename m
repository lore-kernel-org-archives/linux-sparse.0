From: Chris Wedgwood <cw@f00f.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 8 Mar 2007 09:31:06 -0800
Message-ID: <20070308173106.GA17698@tuatara.stupidest.org>
References: <1173319356.3546.54.camel@johannes.berg> <1173371608.21465.12.camel@dv> <1173372315.3248.19.camel@johannes.berg> <1173374010.15842.13.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:32252 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752601AbXCHRhs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Mar 2007 12:37:48 -0500
Content-Disposition: inline
In-Reply-To: <1173374010.15842.13.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

On Thu, Mar 08, 2007 at 12:13:30PM -0500, Pavel Roskin wrote:

> Reducing the file may be tricky, since there is no definite way to
> say if the problem exists once the code becomes shorter.  But I'll
> try.

Some lines are thousands of characters long, probably the result of
cpp macro expansion?  I see many lines over 10,000 characters long,
some as much as 81,000 characters long.

I'm not saying that is the cause of this, but i'd certainly be
suspicious of those.

I have to wonder about code that expands *that* much, more a case of
macro abuse than use perhaps?
