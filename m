From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Booleans, what a wonderful type!
Date: Wed, 18 Jul 2007 03:19:08 +0100
Message-ID: <20070718021907.GS21668@ftp.linux.org.uk>
References: <1184723019.469d704b6111b@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47145 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757408AbXGRCTK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jul 2007 22:19:10 -0400
Content-Disposition: inline
In-Reply-To: <1184723019.469d704b6111b@portal.student.luth.se>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ricknu-0@student.ltu.se
Cc: linux-sparse@vger.kernel.org

On Wed, Jul 18, 2007 at 03:43:39AM +0200, ricknu-0@student.ltu.se wrote:
 
> * Most likly a _really_ stupid newbie question, but I have seen several of this
> form:
> <function>
> {
>         <variable> a;
>         <doing something useful (no sign of 'a')>
>         a = <some value/variable>;
>         <exit>
> }
> How is this variable useful?

Explain, please.  If you mean moving the declaration down - it's not
idiomatic in C and frankly, C++ style tends to make declarations harder
to find when you read the code.
 
> * Why is there no va_end() after va_start()?

Where?

> According to the manual (STDARG(3)):
> va_end
>        Each invocation of va_start() must be matched by a corresponding  invo-
>        cation  of va_end() in the same function. After the call va_end(ap) the
>        variable ap is undefined.  Multiple  transversals  of  the  list,  each
>        bracketed  by  va_start() and va_end() are possible.  va_end() may be a
>        macro or a function.

Yes, and AFAICS uses of va_start()/va_end() in sparse are correct.  If you
see any broken one - yell.

> * Is there any advantage of "for (;;)" instead of ex "while (true)"?

It's more idiomatic and faster recognized by readers.  while (1) is also
quite common; while (true) will be understood, but will distract since it
will take more conscious effort to recognize.
 
> * Why is it written in C and not C++. Easier access to kernel-developers? (just
> curious)

Generally saner language?  Turn the question around - what in sparse would
be inherently cleaner in C++?
