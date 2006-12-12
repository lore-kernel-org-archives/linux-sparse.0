From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: sparse handles int64_t type wrong
Date: Tue, 12 Dec 2006 11:44:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org>
References: <1165952070.17896.7.camel@chaos.malinovka7.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34345 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932410AbWLLToS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Dec 2006 14:44:18 -0500
In-Reply-To: <1165952070.17896.7.camel@chaos.malinovka7.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org



On Tue, 12 Dec 2006, Yura Pakhuchiy wrote:
>
> sparse 0.2 produces following errors on attached code:
> a.c:15:7: warning: incorrect type in argument 1 (different type sizes)
> a.c:15:7:    expected int [long] [usertype] *baz
> a.c:15:7:    got int *<noident>
> a.c:13:10: warning: shift too big (32) for type int 
> 
> However I believe it should not. Please fix!

Did you use "-m64" if you are doing this on an architecture with 64-bit 
/usr/include?

		Linus
