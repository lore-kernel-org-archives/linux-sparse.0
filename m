From: Christopher Li <sparse@chrisli.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp symbols
Date: Fri, 2 Feb 2007 14:10:09 -0800
Message-ID: <20070202221009.GC27667@chrisli.org>
References: <1170437836.2272.22.camel@dv> <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org> <20070202215603.GA27667@chrisli.org> <1170455437.4698.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([63.240.77.82]:34231 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946132AbXBBWhK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:37:10 -0500
Content-Disposition: inline
In-Reply-To: <1170455437.4698.2.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On Fri, Feb 02, 2007 at 05:30:37PM -0500, Pavel Roskin wrote:
> 
> You need -Wundef or -Wall to check for undefined preprocessor symbols.
> 
> $ sparse -Wundef test.c 
> test.c:1:5: warning: undefined preprocessor identifier
> 'SYMBOL_NOT_DEFINED'
> test.c:4:2: warning: "not defined"

Ha, I see. So do you still want some thing more than -Wno-undef?

Chris
