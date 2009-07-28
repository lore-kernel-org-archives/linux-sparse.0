From: Sam Ravnborg <sam@ravnborg.org>
Subject: Detect unused header files?
Date: Tue, 28 Jul 2009 20:18:04 +0200
Message-ID: <20090728181803.GA20845@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:47735 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbZG1SSE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 14:18:04 -0400
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 16667A50035
	for <linux-sparse@vger.kernel.org>; Tue, 28 Jul 2009 20:18:03 +0200 (CEST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse <linux-sparse@vger.kernel.org>

In the kernel we would like to avoid all
unused include files.
Especially in the headers we export to userspace.

Are there any easy way we can use sparse to detect
that a specific header file is not used?

I know this will depend on the configuration, but
for the use I have in mind this does matter only a little.

The header files I have in mind will be fully self-contained
as they all include the header files they need to be used.

Sample:

cat foo.h:
#include <linux/types.h>
#include <linux/swab.h>

struct foo {
        __u32 bar;
        __u32 baz;
};

EOF


Here <linux/swab.h> is obviously not used.
And I would like sparse to flag this...

	Sam

