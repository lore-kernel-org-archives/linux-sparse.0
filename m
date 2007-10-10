From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: idio{,ma}tic typos (was Re: + fix-vm_can_nonlinear-check-in-sys_remap_file_pages.patch added to -mm tree)
Date: Wed, 10 Oct 2007 09:35:49 -0400
Message-ID: <118833cc0710100635x205503a2peb73d24384538afa@mail.gmail.com>
References: <20071010104540.GA6366@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:12773 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbXJJNfx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Oct 2007 09:35:53 -0400
Received: by nf-out-0910.google.com with SMTP id g13so175188nfb
        for <linux-sparse@vger.kernel.org>; Wed, 10 Oct 2007 06:35:52 -0700 (PDT)
In-Reply-To: <20071010104540.GA6366@localhost.sw.ru>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, Pierre Ossman <drzeus@drzeus.cx>, akpm@osdl.org, linux-sparse@vger.kernel.org

> While we're at it, below is somewhat ugly sparse patch for detecting
> "&& 0x" typos.

Excellent idea, and there is something to be said about a low-footprint patch
like that.  However, if you really want to capture this kind of bugs, you would
need to have some kind "not a boolean" or "bitfield" attribute that
can propagate.
For example, you would want

    if (foo && (BAR | BAZ)) ...;

with BAR and BAZ being hex constants to produce the same warning.

Incidentally, it is probably not just hex constants that deserve this treatment:
octal constants and variations of (1 << cst) are of the same nature.  As well
as enums defined in such manners.

Morten
