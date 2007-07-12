From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [RFC] show_type() format problems
Date: Thu, 12 Jul 2007 09:22:10 -0700
Message-ID: <1184257330.3000.7.camel@josh-work.beaverton.ibm.com>
References: <20070712091453.GY21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:40680 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406AbXGLQ1u (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 Jul 2007 12:27:50 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6CGRlVF003528
	for <linux-sparse@vger.kernel.org>; Thu, 12 Jul 2007 12:27:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l6CGQFs2217796
	for <linux-sparse@vger.kernel.org>; Thu, 12 Jul 2007 10:27:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6CGLuSU006477
	for <linux-sparse@vger.kernel.org>; Thu, 12 Jul 2007 10:21:56 -0600
In-Reply-To: <20070712091453.GY21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Thu, 2007-07-12 at 10:14 +0100, Al Viro wrote:
> int __attribute__((address_space(1))) **p;
> int *__attribute__((address_space(1))) *q;
> 
> void foo(void)
> {
>         p = q;
> }
> 
> quite predictably gives a warning.  The contents of that warning,
> however, is somewhat unfortunate:
> 
> test.c:6:4: warning: incorrect type in assignment (different address spaces)
> test.c:6:4:    expected int **[addressable] [toplevel] p<asn:1>
> test.c:6:4:    got int **[addressable] [toplevel] q<asn:1>
> 
> The reason is simple: we put <asn:...> *after* the identifier.  *, of
> course, goes before it.  So when we have a pointer to pointer, there's
> no way to tell which of them had brought address_space.
> 
> Do we want to keep the current behaviour?  It's obviously not nice -
> especially when we get warnings like one above.
>
> We also can't tell pointer to array from array of pointers.  Does anybody
> object against making it look more like C declarations?  I.e. put <asn:...>
> together with modifiers and at least add parens when needed?

Please do go ahead and change the output.  I'd love for show_type to
output something as close to a parsable C type as possible.

> Believe me, I do realize that it will change build logs.  I probably have
> more of those than just about anybody else (several years worth of sparse
> runs on the kernel for couple dozens of targets).  And yes, it'll hurt.
> I don't see a better alternative, though; we might be able to tweak the
> output to deal with ambiguities and still keep the same results for (very)
> simple cases, but if we are tweaking it at all we really ought to go for
> something recognizable for normal C programmers...

I do understand the concern, but I think that consistency of build logs
matters far less than sanity for the users of *current* Sparse.  Let's
no go making purely gratuitous output changes, but here we have a good
reason to change the output.

- Josh Triplett
