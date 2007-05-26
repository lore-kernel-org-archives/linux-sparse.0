From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: pointer arithmetics and casts
Date: Sat, 26 May 2007 05:16:28 +0100
Message-ID: <20070526041628.GQ4095@ftp.linux.org.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk> <118833cc0705251814h9fffa39xc4a0f3f9e61242b9@mail.gmail.com> <4657AA5F.1020705@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34406 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXEZEQb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 May 2007 00:16:31 -0400
Content-Disposition: inline
In-Reply-To: <4657AA5F.1020705@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Morten Welinder <mwelinder@gmail.com>, linux-sparse@vger.kernel.org

On Sat, May 26, 2007 at 04:32:47AM +0100, Derek M Jones wrote:
> This is an unsigned type, so the wrap around behavior is defined.
> But do you really want to map a small negative index into a large 
> positive one?
> 
> You probably have to use intptr_t and uintptr_t.
> 
> On the other hand if sizeof(size_t) == sizeof(type_of(tree for i))
> is an implicit cast needed?

It is not; however, on a lot of targets that doesn't really help since
the typical situation will have i smaller than p (any 64bit target with
32bit int).  So the problem of having to allocate a lot of extra nodes
remains...

FWIW, I don't think that asking which of the target's integer types is
suitable is really relevant; assuming that such type exists at all,
we can make it a parameter of target and be done with that (BTW, we
are not guaranteed that there is an integer type capable of holding
a pointer - see 7.18.1.4, it's an optional type).
