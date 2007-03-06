From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 6 Mar 2007 12:58:46 -0800
Message-ID: <20070306125846.0e3a684a.rdunlap@xenotime.net>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	<20070306023351.GB31138@chrisli.org>
	<20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	<20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	<20070305224025.fe867c28.rdunlap@xenotime.net>
	<1173205177.32333.34.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:43741 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932098AbXCFVAr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 16:00:47 -0500
Received: from midway.site ([71.245.96.156]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 6 Mar 2007 13:00:36 -0800
In-Reply-To: <1173205177.32333.34.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tue, 06 Mar 2007 13:19:37 -0500 Pavel Roskin wrote:

> On Mon, 2007-03-05 at 22:40 -0800, Randy Dunlap wrote:
> > On Tue,  6 Mar 2007 00:42:43 -0500 Pavel Roskin wrote:
> > > There is a relatively easy way to get the problematic file.  Remove the
> > > corresponding object file and run this in the Linux build tree:
> > > 
> > > make CC="gcc -save-temps -D__CHECKER__"
> > > 
> > > This will likely fail, but there will be a file with *.i extension that would
> > > probably cause the same problem with sparse.  That file can be renamed back to
> > > *.c, indented and, time permitting, reduced to a few lines.
> > 
> > Sorry, that's not giving me anything from drivers/net/vioc/.
> > It dies on init/main.c:
> > 
> > init/main.c: At top level:
> > init/main.c:431: warning: 'context' attribute directive ignored
> > init/main.c:431: error: expected ',' or ';' before '{' token
> 
> My bad, sorry.  I tested in on a standalone driver.  Here's a version
> tested on the actual kernel tree:
> 
> make CC="gcc -save-temps -D__CHECKER__" KBUILD_NOCMDDEP=1
> 
> KBUILD_NOCMDDEP=1 prevents rebuilding other files when CC changes.  If
> you still get stuck on another file, please also add "-k" to the command
> line.

OK, that produced a large .i file and running:
  sparse vioc_provision.i
does reproduce the segfault, so now I am cutting down the size of
the .i file, then I'll send it in.

Thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
