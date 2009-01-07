From: Christoph Hellwig <hch@lst.de>
Subject: Re: lock context warnings
Date: Wed, 7 Jan 2009 17:34:04 +0100
Message-ID: <20090107163404.GB2059@lst.de>
References: <20090107084539.GA15246@lst.de> <f19298770901070120v396222d9g1d0ea7b78cbc07c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:41877 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbZAGQeI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Jan 2009 11:34:08 -0500
Content-Disposition: inline
In-Reply-To: <f19298770901070120v396222d9g1d0ea7b78cbc07c9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-sparse@vger.kernel.org

On Wed, Jan 07, 2009 at 12:20:18PM +0300, Alexey Zaytsev wrote:
> On Wed, Jan 7, 2009 at 11:45, Christoph Hellwig <hch@lst.de> wrote:
> > Since a few month sparse keeps spewing tons of wrong lock context
> > warnings like:
> 
> Yes, the warnings are wrong, and the patches that were supposeed to
> fix them breoke other things, so they were never merged.
> Christopher reverted the patches that introduced the new warnings
> in his tree: git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git
> until someone fixes or rewrites the context checking.
> 
> It looks like Christopher is serious about maintaining this tree, so
> people should probably switch to using it.

That tree looks much better, only a few lock context warnings left which
look legit from a first scan.  I'll keep using that tree for now.
