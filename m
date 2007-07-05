From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: support of __restrict and __constructor__
Date: Thu, 05 Jul 2007 12:04:46 -0700
Message-ID: <1183662286.2604.50.camel@josh-work.beaverton.ibm.com>
References: <1183657975.5958.46.camel@pc299.sam-solutions.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:41428 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759113AbXGETEo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Jul 2007 15:04:44 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l65IxQ9g008797
	for <linux-sparse@vger.kernel.org>; Thu, 5 Jul 2007 14:59:26 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l65J4c7w266834
	for <linux-sparse@vger.kernel.org>; Thu, 5 Jul 2007 13:04:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l65J4c5l013081
	for <linux-sparse@vger.kernel.org>; Thu, 5 Jul 2007 13:04:38 -0600
In-Reply-To: <1183657975.5958.46.camel@pc299.sam-solutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, 2007-07-05 at 20:52 +0300, Yura Pakhuchiy wrote:
> I updated libntfs/ntfsprogs to use sparse for checking endianness.
> Thanks much for this feature, it very useful. Helped to find several
> bugs in our project.

Very glad to hear it!

> The only problem is 2 annoying lines in glibc and gnupg headers that
> sparse-0.3 do not like:
>
> 1. Sparse do not like __restrict_attr inside regexec() definition in
>    regex.h. Relevant code:
> 
>    extern int regexec (const regex_t *__restrict __preg,
>                     const char *__restrict __string, size_t __nmatch,
>                     regmatch_t __pmatch[__restrict_arr],
>                     int __eflags);
> 
>    Produces following error: 
>    /usr/include/regex.h:543:27: error: typename in expression
>    /usr/include/regex.h:543:27: error: undefined identifier '__restrict'
>    /usr/include/regex.h:543:27: error: bad constant expression type
> 
>    (Note: __restrict_arr is defined to __restrict)

Right.  I've run into the same error, and I have this on my todo list to
fix.  Sparse just needs to parse and ignore restrict and __restrict in
array declarations like that.

> 2. And sparse do not know about attribute __constructor__ inside
>    gpg-error.h. Relevant code:
> 
> #if _GPG_ERR_GCC_VERSION > 30100
> #define _GPG_ERR_CONSTRUCTOR    __attribute__ ((__constructor__))
> #define _GPG_ERR_HAVE_CONSTRUCTOR
> #endif
> #endif
> 
> #ifndef _GPG_ERR_CONSTRUCTOR
> #define _GPG_ERR_CONSTRUCTOR
> #endif
> 
> /* Initialization function.  */
> 
> /* Initialize the library.  This function should be run early.  */
> gpg_error_t gpg_err_init (void) _GPG_ERR_CONSTRUCTOR;

Latest sparse from git already parses and ignores the constructor and
destructor attributes, and their double-underscore variants.

> I would really happy if you will fix this. Thanks!

No problem.  Thanks for using Sparse; glad to hear that it helped you!

- Josh Triplett
