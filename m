From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 11:26:31 +0100
Message-ID: <20070618102631.GF21478@ftp.linux.org.uk>
References: <20070618101929.GE21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38663 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXFRK0c (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 06:26:32 -0400
Content-Disposition: inline
In-Reply-To: <20070618101929.GE21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jun 18, 2007 at 11:19:29AM +0100, Al Viro wrote:
> Have fun...  The tree is in branch 'initializers' of
> git://git.kernel.org//pub/scm/linux/kernel/git/viro/sparse/

Grr...  That would be

git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse/

BTW, I wonder why does git care about double slash in that place (or
later in the path, for that matter).  Path normalization and healthy
paranoia about people doing something fishy if it doesn't match the
original literally?
