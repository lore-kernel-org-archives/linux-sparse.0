From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: multiple source files [was four sparse patches]
Date: Fri, 27 Jun 2008 21:40:15 +0200
Message-ID: <20080627194015.GA19046@uranus.ravnborg.org>
References: <32e600e90805021158vb6be3c9jbb75c3a61345448@mail.gmail.com> <1214592477.5189.7.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:53301 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771AbYF0Tja (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 15:39:30 -0400
Content-Disposition: inline
In-Reply-To: <1214592477.5189.7.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Geoff Johnstone <geoffsheep.johnstonefrog@googlemail.com>, Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

> I'd like Sparse to handle multiple files on the same command line.  I
> don't mind invasive patches, though as always I'd like to see them
> broken up into incremental patches when possible.

I once made a test patch for kbuild that allowed me to run
sparse on all files for a module.
It started out nicely but when I hit the xfs source my machine went
in swap death.
So there is a memory consumption issue to take care of too.

	Sam
