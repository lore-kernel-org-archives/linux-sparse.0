From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: barrier macro
Date: Tue, 1 May 2007 21:35:00 -0700
Message-ID: <20070501213500.d36850a5.rdunlap@xenotime.net>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net>
	<463802E1.4030303@freedesktop.org>
	<46381269.9090305@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:52678 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754223AbXEBEax (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 00:30:53 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 1 May 2007 21:30:46 -0700
In-Reply-To: <46381269.9090305@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tue, 01 May 2007 21:24:09 -0700 Josh Triplett wrote:

> After analyzing net/sunrpc/xprtsock.i, I managed to reproduce the problem with
> the following test case:
> 
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> static void f(void)
> {
> 	barrier();
> l:
> 	barrier();
> }
> 
> 
> Apparently sparse doesn't like __asm__ __volatile__ after a label.  Looks like
> the change to enable attributes on labels makes Sparse interpret the __asm__
> as an attribute on the label, not as a statement.  If I locally revert the
> label attributes change, aec53c938c34c47cdbdd6824552e0f2a5104b1cb, this test
> case compiles without warning, as does net/sunrpc/xprtsock.c.
> 
> The label attributes change needs some additional work, to make it only handle
> attribute and __attribute__, and nothing else.

OK, thanks for the analysis (and not making me cut down 35000 lines :).

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
