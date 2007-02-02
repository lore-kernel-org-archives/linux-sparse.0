From: Pavel Roskin <proski@gnu.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp
	symbols
Date: Fri, 02 Feb 2007 17:30:37 -0500
Message-ID: <1170455437.4698.2.camel@dv>
References: <1170437836.2272.22.camel@dv>
	 <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
	 <20070202215603.GA27667@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:37758 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946111AbXBBWal (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:30:41 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HD6uX-00048p-Q4
	for linux-sparse@vger.kernel.org; Fri, 02 Feb 2007 17:29:37 -0500
In-Reply-To: <20070202215603.GA27667@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On Fri, 2007-02-02 at 13:56 -0800, Christopher Li wrote:

> I did some trivial test:
> 
> #if SYMBOL_NOT_DEFINED
> #warning "defined"
> #else
> #warning "not defined"
> #endif
> 
> On sparse git tip, or sparse 0.2. Here is what I get:
> 
> ./sparse /tmp/a.c 
> /tmp/a.c:5:2: warning: "not defined"
> 
> That is what Pavel wants. So Linus should complain instead.
> 
> I am confused.

You need -Wundef or -Wall to check for undefined preprocessor symbols.

$ sparse -Wundef test.c 
test.c:1:5: warning: undefined preprocessor identifier
'SYMBOL_NOT_DEFINED'
test.c:4:2: warning: "not defined"

-- 
Regards,
Pavel Roskin
