From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: sparse handles int64_t type wrong
Date: Tue, 12 Dec 2006 12:02:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121155450.3535@woody.osdl.org>
References: <1165952070.17896.7.camel@chaos.malinovka7.net>
 <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:35992 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932426AbWLLUC6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Dec 2006 15:02:58 -0500
In-Reply-To: <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org



On Tue, 12 Dec 2006, Linus Torvalds wrote:
> 
> Did you use "-m64" if you are doing this on an architecture with 64-bit 
> /usr/include?

Never mind, that's not it.

The problem is that the standard headers use _this_ for "int64_t":

	typedef int int64_t __attribute__ ((__mode__ (__DI__)));

and sparse just says "ok, int64_t is an 'int'"

The "__attribute__((__mode__()))" thing has always been a quick hack - 
sparse actually tries to parse it, but not very well.

If you use 

	typedef long long s64;

sparse gets it right.

In fact, sparse even gets it right if you do

	typedef int __attribute__((__mode__(__DI__))) int64_t;

because then the attribute gets attached to the underlying type, before it 
gets bound to the typedef.

I'll take a look if I can fix typedef to accept the crapola __attibute__ 
syntax.

Putting the attributes at the end really _does_ suck. It's as if you were 
to write

	typedef void * const_ptr_t const;

and that obviously isn't supposed to work. Why gcc thinks attributes can 
go at the end will never be clear to me.

Gcc attributes suck. Some gcc extensions really were thought out really 
really badly.

		Linus
