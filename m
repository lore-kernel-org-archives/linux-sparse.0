From: Pavel Roskin <proski@gnu.org>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue,  6 Mar 2007 00:42:43 -0500
Message-ID: <20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	<20070306023351.GB31138@chrisli.org>
	<20070305210416.7b5c0a2a.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailgate.cesmail.net ([216.154.195.36]:51869 "HELO
	mailgate.cesmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933953AbXCFFmo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 00:42:44 -0500
In-Reply-To: <20070305210416.7b5c0a2a.rdunlap@xenotime.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

Quoting Randy Dunlap <rdunlap@xenotime.net>:
> > I can't reproduce it with a script that copy your command line
> > for mm1 tree either. I need to modify the gcc include path.
> > But after that it pass fine.
> >
> > Can you send me your .config file?
>
> make allmodconfig

There is a relatively easy way to get the problematic file.  Remove the
corresponding object file and run this in the Linux build tree:

make CC="gcc -save-temps -D__CHECKER__"

This will likely fail, but there will be a file with *.i extension that would
probably cause the same problem with sparse.  That file can be renamed back to
*.c, indented and, time permitting, reduced to a few lines.

--
Regards,
Pavel Roskin
