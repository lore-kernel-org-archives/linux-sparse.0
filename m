From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: ignore indirect_branch attribute
Date: Tue, 13 Feb 2018 23:12:47 +0100
Message-ID: <20180213221245.2ylhdtqdf4c5qmog@ltop.local>
References: <c97d360f-a0d2-8c0d-b951-e064843ff4d8@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:39553 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965931AbeBMWMv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 17:12:51 -0500
Received: by mail-wm0-f49.google.com with SMTP id b21so18622780wme.4
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 14:12:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c97d360f-a0d2-8c0d-b951-e064843ff4d8@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Feb 13, 2018 at 01:52:54PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Teach sparse about the "indirect_branch" attribute as used in
> Linux kernel:
> #define __noretpoline __attribute__((indirect_branch("keep")))
> and tell sparse to ignore it.
> 
> This eliminates over 148K warnings (which also cause the
> 0day bot to send error reports uselessly).

Sigh.
I think that these unknown attribute warnings are useless
in general and even more so for the kernel. The kernel should
have "-Wno-unknown-attribute" in its CHECKFLAGS.
 
> Or does sparse need to do something with it?

No, it's the only thing needed. Thanks.

I've applied it in my dev tree and will push it in a few
days to the stable tree where I collect all pending changes:
	git://github.com/lucvoo/sparse.git

-- Luc
