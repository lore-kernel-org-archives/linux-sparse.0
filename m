From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: sparse segfault in kernel -mm tree
Date: Mon, 5 Mar 2007 22:40:25 -0800
Message-ID: <20070305224025.fe867c28.rdunlap@xenotime.net>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	<20070306023351.GB31138@chrisli.org>
	<20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	<20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:58786 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965796AbXCFGmX (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 01:42:23 -0500
Received: from midway.site ([71.245.96.156]) by xenotime.net for <linux-sparse@vger.kernel.org>; Mon, 5 Mar 2007 22:42:18 -0800
In-Reply-To: <20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tue,  6 Mar 2007 00:42:43 -0500 Pavel Roskin wrote:

> Quoting Randy Dunlap <rdunlap@xenotime.net>:
> > > I can't reproduce it with a script that copy your command line
> > > for mm1 tree either. I need to modify the gcc include path.
> > > But after that it pass fine.
> > >
> > > Can you send me your .config file?
> >
> > make allmodconfig
> 
> There is a relatively easy way to get the problematic file.  Remove the
> corresponding object file and run this in the Linux build tree:
> 
> make CC="gcc -save-temps -D__CHECKER__"
> 
> This will likely fail, but there will be a file with *.i extension that would
> probably cause the same problem with sparse.  That file can be renamed back to
> *.c, indented and, time permitting, reduced to a few lines.

Sorry, that's not giving me anything from drivers/net/vioc/.
It dies on init/main.c:

init/main.c: At top level:
init/main.c:431: warning: 'context' attribute directive ignored
init/main.c:431: error: expected ',' or ';' before '{' token


---
~Randy
