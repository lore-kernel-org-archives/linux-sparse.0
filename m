From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: ignore indirect_branch attribute
Date: Thu, 15 Feb 2018 21:42:27 +0100
Message-ID: <20180215204225.kexgsqbcuvkwhpva@ltop.local>
References: <c97d360f-a0d2-8c0d-b951-e064843ff4d8@infradead.org>
 <20180213221245.2ylhdtqdf4c5qmog@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39790 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161186AbeBOUma (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Feb 2018 15:42:30 -0500
Received: by mail-wm0-f54.google.com with SMTP id b21so3210893wme.4
        for <linux-sparse@vger.kernel.org>; Thu, 15 Feb 2018 12:42:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180213221245.2ylhdtqdf4c5qmog@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 13, 2018 at 11:12:47PM +0100, Luc Van Oostenryck wrote:
> On Tue, Feb 13, 2018 at 01:52:54PM -0800, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Teach sparse about the "indirect_branch" attribute as used in
> > Linux kernel:
> > #define __noretpoline __attribute__((indirect_branch("keep")))
> > and tell sparse to ignore it.
> > 
> > This eliminates over 148K warnings (which also cause the
> > 0day bot to send error reports uselessly).

FWIW, I've pushed this to my stable tree:
	https://github.com/lucvoo/sparse 
	git://github.com/lucvoo/sparse.git
together with a patch making '-Wunknown-attribute' off by default.

-- Luc
