From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: unable to open limits.h
Date: Tue, 25 Nov 2008 13:27:32 +0100
Message-ID: <20081125122732.GA2035@uranus.ravnborg.org>
References: <20081125110703.GA23049@infradead.org> <f19298770811250418p154bad86qf926c464d16aef02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pqueueb.post.tele.dk ([193.162.153.10]:39771 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbYKYMp4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Nov 2008 07:45:56 -0500
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id EA664864B
	for <linux-sparse@vger.kernel.org>; Tue, 25 Nov 2008 13:27:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f19298770811250418p154bad86qf926c464d16aef02@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Tue, Nov 25, 2008 at 03:18:58PM +0300, Alexey Zaytsev wrote:
> On Tue, Nov 25, 2008 at 14:07, Christoph Hellwig <hch@infradead.org> wrote:
> > On Ubuntu 8.10 (glibc 2.8.90) I get the following warnings when
> > compiling any program using limits.h:
> >
> > /usr/include/limits.h:125:17: error: unable to open 'limits.h'
> 
> This is probably fixed by
> http://git.zaytsev.su/git?p=sparse.git;a=commitdiff;h=6f089b22a222dd086d14c985c5a67f8b3afd2177

Is this the right fix?
We should not rely on that sparse is built with the same gcc as currently installed.

The fix should be that we automagically uses the right path which
is available on the system.

> 
> Josh, please pull the gsoc2008-up branch from git://zaytsev.su/git/sparse.git
For a pull request itis prefarable that you always include:
- diffstat
- shortlog
- short intor what is contained

I assume patches has been on sparse ml.


	Sam
