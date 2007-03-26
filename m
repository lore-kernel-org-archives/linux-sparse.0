From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Mon, 26 Mar 2007 11:50:09 -0700
Message-ID: <20070326115009.3991343a.rdunlap@xenotime.net>
References: <20070322073344.GU4095@ftp.linux.org.uk>
	<20070322070354.GA22151@chrisli.org>
	<20070322171118.GL15364@redhat.com>
	<20070322221050.GC22151@chrisli.org>
	<20070323150459.52b02342.rdunlap@xenotime.net>
	<20070323233127.GA10115@uranus.ravnborg.org>
	<20070323164307.3e2e2803.rdunlap@xenotime.net>
	<20070324064456.GA13745@uranus.ravnborg.org>
	<20070324094648.60505bd3.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0703240957530.6730@woody.linux-foundation.org>
	<20070326180741.GA24841@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:48203 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752974AbXCZSs6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 14:48:58 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Mon, 26 Mar 2007 11:48:53 -0700
In-Reply-To: <20070326180741.GA24841@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Mon, 26 Mar 2007 11:07:41 -0700 Christopher Li wrote:

> On Sat, Mar 24, 2007 at 10:02:22AM -0700, Linus Torvalds wrote:
> > 
> > Well, sparse is often also an "arbiter of good taste".
> > 
> > "Technically correct" or "..but gcc accepts it" are secondary to "does the 
> > source make sense".
> > 
> > For example, gcc accepts a *lot* of insanity when it comes to attributes 
> > in odd places. That doesn't necessarily mean that sparse should accept it.
> 
> Points taken. 

Ack.

> Sparse can parse it and warn about it. It is still better than
> the obscure parser error from sparse.

Yes, thanks.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
