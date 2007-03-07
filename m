From: Pavel Roskin <proski@gnu.org>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 06 Mar 2007 22:02:04 -0500
Message-ID: <1173236524.5140.31.camel@dv>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	 <20070306023351.GB31138@chrisli.org>
	 <20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	 <20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	 <20070305224025.fe867c28.rdunlap@xenotime.net>
	 <1173205177.32333.34.camel@dv>
	 <20070306125846.0e3a684a.rdunlap@xenotime.net>
	 <70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
	 <20070306151252.239c58f8.rdunlap@xenotime.net>
	 <118833cc0703061843s22d35a9ei17fd48f97fc7626a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:39190 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161355AbXCGDCH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 22:02:07 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HOmO7-0007En-C1
	for linux-sparse@vger.kernel.org; Tue, 06 Mar 2007 22:00:23 -0500
In-Reply-To: <118833cc0703061843s22d35a9ei17fd48f97fc7626a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Morten Welinder <mwelinder@gmail.com>

On Tue, 2007-03-06 at 21:43 -0500, Morten Welinder wrote:
> Try running sparse under valgrind to see if there is some memory
> corruption at an
> earlier stage.

Randy,

maybe you'll just post the .i file as is (perhaps compressed with
bzip2)?  It looks like your post has generated lots of interest, but
nobody can reproduce the problem.  It's a much bigger waste of bandwidth
to have others download the -mm kernel.

If the file is too large for the list, please send it to me, and I'll
put it online.  Or put that file on pastebin.com or turboupload.com.

If I can reproduce the bug, with or without valgrind, I'll reduce the
file to the minimal required for the bug to be see.  I did it before.

If sparse crashes for you only, then you'll need to debug it on your
system, and it doesn't matter how big the file is.  What matters is the
backtrace and other info from gdb.

-- 
Regards,
Pavel Roskin
