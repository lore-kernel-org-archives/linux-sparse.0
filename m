From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Sat, 24 Mar 2007 09:46:48 -0700
Message-ID: <20070324094648.60505bd3.rdunlap@xenotime.net>
References: <20070322063600.GD15364@redhat.com>
	<20070322073344.GU4095@ftp.linux.org.uk>
	<20070322070354.GA22151@chrisli.org>
	<20070322171118.GL15364@redhat.com>
	<20070322221050.GC22151@chrisli.org>
	<20070323150459.52b02342.rdunlap@xenotime.net>
	<20070323233127.GA10115@uranus.ravnborg.org>
	<20070323164307.3e2e2803.rdunlap@xenotime.net>
	<20070324064456.GA13745@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:45656 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932280AbXCXQpt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 24 Mar 2007 12:45:49 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Sat, 24 Mar 2007 09:45:43 -0700
In-Reply-To: <20070324064456.GA13745@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christopher Li <sparse@chrisli.org>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, 24 Mar 2007 07:44:56 +0100 Sam Ravnborg wrote:

> > 
> > > You could argue that the error from sparse could be better but
> > > it is preferable to have consistent style over the kernel.
> > 
> > I lean more towards "is it valid C or not"?
> I thought all the attribute() stuff was purely gcc extensions.

That's probably correct.  I should have said something more like
"is it accepted by a widely-used C compiler or not".  :)

But I would not complain if sparse just read & ignored the
attributes (rather than throwing errors on them).

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
