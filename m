From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Sat, 24 Mar 2007 10:02:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703240957530.6730@woody.linux-foundation.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk>
 <20070322070354.GA22151@chrisli.org> <20070322171118.GL15364@redhat.com>
 <20070322221050.GC22151@chrisli.org> <20070323150459.52b02342.rdunlap@xenotime.net>
 <20070323233127.GA10115@uranus.ravnborg.org> <20070323164307.3e2e2803.rdunlap@xenotime.net>
 <20070324064456.GA13745@uranus.ravnborg.org> <20070324094648.60505bd3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:44532 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932325AbXCXRDJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 24 Mar 2007 13:03:09 -0400
In-Reply-To: <20070324094648.60505bd3.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christopher Li <sparse@chrisli.org>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org



On Sat, 24 Mar 2007, Randy Dunlap wrote:
> 
> But I would not complain if sparse just read & ignored the
> attributes (rather than throwing errors on them).

Well, sparse is often also an "arbiter of good taste".

"Technically correct" or "..but gcc accepts it" are secondary to "does the 
source make sense".

For example, gcc accepts a *lot* of insanity when it comes to attributes 
in odd places. That doesn't necessarily mean that sparse should accept it.

And any C compiler will accept

	void *ptr = 0;

and that doesn't mean that sparse should accept that mind-boggling bug in 
the C standard. Yes, the zero constant is a special pointer, but it's 
special when cast to a pointer type, not when used as a integer. And the 
fact that the C standard disagrees with me just means that the C standard 
is wrong.

So I don't think sparse should necessarily accept crap code just because 
(a) gcc accepts it and (b) there is some crap code in the kernel that uses 
it. That "__attribute__((unused))" on a label seems to be exactly that 
kind of horror. It's not like it's any prettier than tons of *valid* ways 
to do the same (for example, using the C preprocessor).

			Linus
