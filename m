From: Sam Ravnborg <sam@ravnborg.org>
Subject: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Thu, 18 Jun 2009 21:20:58 +0200
Message-ID: <20090618192058.GB14086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:51105 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbZFRTSk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 15:18:40 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

The linux kernel is one of the major customers of
sparse and several sparse hackers are very
active on the kernel front too.

How about combining forces and move sparse.git inside
the kernel.

I assume that we can work out something on the
license side so sparse has the correct license??

Benefits doing so:

- Easy access to sparse from within the kernel.
  Doing a make C=2 run is now trivial for everyone

- We (the kernel hackers) has the source readily
  avalibale when we need to hack it.

Drawbacks:

- We need to come up with a solution so it is
  easy to distribute sparse binaries/source packages
  without the need to distribute the full kernel source


The idea has come up before, and now that the kernel
has a tools/ directory we have a place where sparse can live.

And I think Linus can find a way to pull sparse.git
with full history so we do not loose anything doing so.

On the maintainer side of sparse one has to ask Linus to
pull now and then - this is a doable task.

	Sam
