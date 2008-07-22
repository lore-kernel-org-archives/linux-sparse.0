From: Ben Greenberg <bgreenberg@maximumhavoc.com>
Subject: Documentation? Anywhere?
Date: Tue, 22 Jul 2008 17:31:04 +0000 (UTC)
Message-ID: <loom.20080722T171932-373@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38235 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbYGVUzI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Jul 2008 16:55:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KLOsw-0008IQ-PA
	for linux-sparse@vger.kernel.org; Tue, 22 Jul 2008 20:55:03 +0000
Received: from 74-93-204-196-WashingtonDC.hfc.comcastbusiness.net ([74-93-204-196-WashingtonDC.hfc.comcastbusiness.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 20:55:02 +0000
Received: from bgreenberg by 74-93-204-196-WashingtonDC.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 20:55:02 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

So, I'm new to Linux and to static analysis and so I'm sure I'm not the target
audience for Sparse, but where is all the documentation? The website is
well...sparse, the readme contains nothing helpful and neither does the FAQ. I
compiled Sparse but I have no idea how to use it. There are all these binaries
and none of them accept --help (except for test-suite). Am I missing something?

Basically I'm trying to use Sparse to generate a call graph for a specific
program. I tried using the graph binary which seems to generate XML-like code
but my browser can't read it. Through browsing this message list I found that
people were piping the results of graph through the binaries in the gvpr folder
First of all, how am I supposed to have deduced that the output of graph needs
to be further processed and that the binaries in gvpr are there for that
purpose? Second, when I tried to do that I got an error saying that
/usr/bin/gvpr doesn't exist. Do I need to move the gvpr folder to /usr/bin/ or
is gvpr a separate program? My command is: ./graph flow.c | ./gvpr/return-paths

I don't necesarily need an answer to my specific question, but if someone knows
where to find a how-to or some other documentation that would be great. Thank
you.

