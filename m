From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Documentation? Anywhere?
Date: Thu, 24 Jul 2008 15:23:30 -0700
Message-ID: <1216938210.5455.16.camel@josh-work.beaverton.ibm.com>
References: <loom.20080722T171932-373@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41888 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbYGXWXa (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Jul 2008 18:23:30 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6OMNRkF016110
	for <linux-sparse@vger.kernel.org>; Thu, 24 Jul 2008 18:23:27 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6OMNRDO169846
	for <linux-sparse@vger.kernel.org>; Thu, 24 Jul 2008 18:23:27 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m6OMNRL0009264
	for <linux-sparse@vger.kernel.org>; Thu, 24 Jul 2008 18:23:27 -0400
In-Reply-To: <loom.20080722T171932-373@post.gmane.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ben Greenberg <bgreenberg@maximumhavoc.com>
Cc: linux-sparse@vger.kernel.org

On Tue, 2008-07-22 at 17:31 +0000, Ben Greenberg wrote:
> So, I'm new to Linux and to static analysis and so I'm sure I'm not the target
> audience for Sparse, but where is all the documentation? The website is
> well...sparse, the readme contains nothing helpful and neither does the FAQ. I
> compiled Sparse but I have no idea how to use it. There are all these binaries
> and none of them accept --help (except for test-suite). Am I missing something?

sparse and cgcc have manpages.  Other than that, you haven't missed
anything.

> Basically I'm trying to use Sparse to generate a call graph for a specific
> program. I tried using the graph binary which seems to generate XML-like code
> but my browser can't read it. Through browsing this message list I found that
> people were piping the results of graph through the binaries in the gvpr folder
> First of all, how am I supposed to have deduced that the output of graph needs
> to be further processed and that the binaries in gvpr are there for that
> purpose? Second, when I tried to do that I got an error saying that
> /usr/bin/gvpr doesn't exist. Do I need to move the gvpr folder to /usr/bin/ or
> is gvpr a separate program? My command is: ./graph flow.c | ./gvpr/return-paths

graph does not generate XML.  It generates graphviz output.  You need
graphviz to work with it; graphviz also includes gvpr.  You do not need
to process the output further; you simply have the option of doing so.
You can directly feed the output of graph to "dot" or one of the other
graphviz tools to get an image.

However, I agree that no obvious connection exists between the "graph"
program and the post-processing scripts in gvpr.

- Josh Triplett


