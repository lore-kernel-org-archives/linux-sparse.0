From: Pavel Roskin <proski@gnu.org>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 06 Mar 2007 13:19:37 -0500
Message-ID: <1173205177.32333.34.camel@dv>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	 <20070306023351.GB31138@chrisli.org>
	 <20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	 <20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	 <20070305224025.fe867c28.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:48677 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965505AbXCFSTl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 13:19:41 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HOeEW-0002sP-U4
	for linux-sparse@vger.kernel.org; Tue, 06 Mar 2007 13:17:57 -0500
In-Reply-To: <20070305224025.fe867c28.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Mon, 2007-03-05 at 22:40 -0800, Randy Dunlap wrote:
> On Tue,  6 Mar 2007 00:42:43 -0500 Pavel Roskin wrote:
> > There is a relatively easy way to get the problematic file.  Remove the
> > corresponding object file and run this in the Linux build tree:
> > 
> > make CC="gcc -save-temps -D__CHECKER__"
> > 
> > This will likely fail, but there will be a file with *.i extension that would
> > probably cause the same problem with sparse.  That file can be renamed back to
> > *.c, indented and, time permitting, reduced to a few lines.
> 
> Sorry, that's not giving me anything from drivers/net/vioc/.
> It dies on init/main.c:
> 
> init/main.c: At top level:
> init/main.c:431: warning: 'context' attribute directive ignored
> init/main.c:431: error: expected ',' or ';' before '{' token

My bad, sorry.  I tested in on a standalone driver.  Here's a version
tested on the actual kernel tree:

make CC="gcc -save-temps -D__CHECKER__" KBUILD_NOCMDDEP=1

KBUILD_NOCMDDEP=1 prevents rebuilding other files when CC changes.  If
you still get stuck on another file, please also add "-k" to the command
line.

-- 
Regards,
Pavel Roskin
