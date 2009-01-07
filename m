From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: lock context warnings
Date: Wed, 7 Jan 2009 12:20:18 +0300
Message-ID: <f19298770901070120v396222d9g1d0ea7b78cbc07c9@mail.gmail.com>
References: <20090107084539.GA15246@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:48857 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZAGJUU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Jan 2009 04:20:20 -0500
Received: by bwz14 with SMTP id 14so25197489bwz.13
        for <linux-sparse@vger.kernel.org>; Wed, 07 Jan 2009 01:20:18 -0800 (PST)
In-Reply-To: <20090107084539.GA15246@lst.de>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sparse@vger.kernel.org

On Wed, Jan 7, 2009 at 11:45, Christoph Hellwig <hch@lst.de> wrote:
> Since a few month sparse keeps spewing tons of wrong lock context
> warnings like:

Yes, the warnings are wrong, and the patches that were supposeed to
fix them breoke other things, so they were never merged.
Christopher reverted the patches that introduced the new warnings
in his tree: git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git
until someone fixes or rewrites the context checking.

It looks like Christopher is serious about maintaining this tree, so
people should probably switch to using it.
