From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/4] Set gcc include path at runtime.
Date: Tue, 9 Dec 2008 05:08:59 -0500
Message-ID: <20081209100859.GA11082@infradead.org>
References: <20081208091817.15890.27981.stgit@xl0.local> <20081208092040.15890.89076.stgit@xl0.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:59693 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbYLIKJC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Dec 2008 05:09:02 -0500
Content-Disposition: inline
In-Reply-To: <20081208092040.15890.89076.stgit@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey zaytsev <alexey.zaytsev@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Josh Triplett <josh@freedesktop.org>

On Mon, Dec 08, 2008 at 12:20:41PM +0300, Alexey zaytsev wrote:
> You can now tell sparse where to look for the compiler
> headers with -gcc-base-dir <dir>. Otherwise sparse will
> look for headers used to build it.
> 
> Also adds $GCC_BASE/include-fixed used by newer gcc
> versions.

Thanks, that fixes the limits.h warnings for me.

