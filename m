From: Christoph Hellwig <hch@infradead.org>
Subject: Re: unable to open limits.h
Date: Tue, 25 Nov 2008 07:37:43 -0500
Message-ID: <20081125123743.GA21584@infradead.org>
References: <20081125110703.GA23049@infradead.org> <f19298770811250418p154bad86qf926c464d16aef02@mail.gmail.com> <20081125123622.GA20420@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:38212 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbYKYMhn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Nov 2008 07:37:43 -0500
Content-Disposition: inline
In-Reply-To: <20081125123622.GA20420@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Tue, Nov 25, 2008 at 07:36:22AM -0500, Christoph Hellwig wrote:
> On Tue, Nov 25, 2008 at 03:18:58PM +0300, Alexey Zaytsev wrote:
> > On Tue, Nov 25, 2008 at 14:07, Christoph Hellwig <hch@infradead.org> wrote:
> > > On Ubuntu 8.10 (glibc 2.8.90) I get the following warnings when
> > > compiling any program using limits.h:
> > >
> > > /usr/include/limits.h:125:17: error: unable to open 'limits.h'
> > 
> > This is probably fixed by
> > http://git.zaytsev.su/git?p=sparse.git;a=commitdiff;h=6f089b22a222dd086d14c985c5a67f8b3afd2177
> > 
> > Josh, please pull the gsoc2008-up branch from git://zaytsev.su/git/sparse.git
> 
> I still see the error with a sparse built from your repository.

Oh, looks like your have the change in some bloody branch.  Care to send
a patch or publish a proper repository?
