From: Christopher Li <sparse@chrisli.org>
Subject: [RFC] More checking with sparse 0/4
Date: Thu, 28 Dec 2006 01:23:59 -0800
Message-ID: <20061228092359.GA6573@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc11.comcast.net ([204.127.225.91]:60086 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbWL1JmS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Dec 2006 04:42:18 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Josh Triplett <josh@freedesktop.org>, Dan Carpenter <error27@gmail.com>

Hi,

I have been play with sparse to add more Stanford checker style
of checking. The paper is "Checking System Rules Using System-
Specific, Programmer-Written Compiler Extensions" by Dawson Engler
etc.

Unlike the Stanford checker and smatch, this checker is working on
the linearization level instead of AST level. Linearization code
can be very convenient (when it works) to trace the data flow because
pseudo is in SSA form. There is define/user chain to avoid scan
every instruction.

I write the demo of checking null pointer and irq checking. It is mostly
an example.

The checking seems very fast. It adds about 10 seconds to the whole
make C=1 run. We might able to add it to stander sparse checking.

The some of the patch I send it to the list before. I post it again
to make it easy for the people who want to try it out.

As always, comments and suggestions are welcome.

Chris
