From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: bitfields treatment
Date: Sat, 21 Mar 2009 21:57:41 +0000
Message-ID: <49C562D5.40103@knosof.co.uk>
References: <20090320213727.GJ28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:5281 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716AbZCUV5q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 21 Mar 2009 17:57:46 -0400
In-Reply-To: <20090320213727.GJ28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

Al,

> * standard wording is such that it does *NOT* have integer promotions applied
> to such bitfields, even if the size is smaller than int.  Arguably, that's
> a hole in standard; in any case, both gcc and sparse *do* integer promotions
> on those, with the same behaviour as usual (value-preserving promotion).

The usual arithmetic conversions (of which integer promotion is a
subset) are performed where the standard says they are performed,
bit-field involving an implementation defined type or not.

> * for all bitfields we are told that they act as (signed or unsigned)
> integer types of specified width.  That has interesting implications:

See:
http://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_315.htm

> unsigned long long f(unsigned long long n)
> {
> 	struct {
> 		unsigned long long n:33;
> 	} x = {n};
> 	return x.n + x.n;
> }
> 
> *must* be equivalent to (n + n) & 0x1ffffffff on all implementations that
> allow such bitfields.  I.e. these suckers are not promoted to base type;

Sentence 1162 says otherwise:
http://c0x.coding-guidelines.com/6.5.6.html

> they act as if we really head 33bit unsigned type, usual conversions in
> x.n + x.n left the result with that type and addition had been done within
> that type.
> 
> gcc does it that way, we do not (x.n gets promoted to unsigned long long).

It has been argued at WG14 that gcc gets it wrong.

> 	What happens when we mix two such suckers with the same width?

At the very least sparse should generate a useful message.

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
