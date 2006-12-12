From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Subject: Re: sparse handles int64_t type wrong
Date: Tue, 12 Dec 2006 21:50:49 +0200
Message-ID: <1165953049.17896.9.camel@chaos.malinovka7.net>
References: <1165952070.17896.7.camel@chaos.malinovka7.net>
	 <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ftp.iptel.by ([80.94.225.5]:45029 "EHLO iptel.by"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932415AbWLLTuy (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Dec 2006 14:50:54 -0500
In-Reply-To: <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

On Tue, 12 Dec 2006 at 11:44 -0800, Linus Torvalds wrote:
> 
> On Tue, 12 Dec 2006, Yura Pakhuchiy wrote:
> >
> > sparse 0.2 produces following errors on attached code:
> > a.c:15:7: warning: incorrect type in argument 1 (different type sizes)
> > a.c:15:7:    expected int [long] [usertype] *baz
> > a.c:15:7:    got int *<noident>
> > a.c:13:10: warning: shift too big (32) for type int 
> > 
> > However I believe it should not. Please fix!
> 
> Did you use "-m64" if you are doing this on an architecture with 64-bit 
> /usr/include?

I use 32bit machine. But I tried to append -m64 anyway and this does not
helps.

-- 
Best regards,
        Yura
