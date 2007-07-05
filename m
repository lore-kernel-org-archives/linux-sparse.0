From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Subject: support of __restrict and __constructor__
Date: Thu, 05 Jul 2007 20:52:55 +0300
Message-ID: <1183657975.5958.46.camel@pc299.sam-solutions.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c71.sam-solutions.net ([217.21.35.67]:30817 "EHLO
	c71.sam-solutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759647AbXGESJ6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Jul 2007 14:09:58 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I updated libntfs/ntfsprogs to use sparse for checking endianness.
Thanks much for this feature, it very useful. Helped to find several
bugs in our project.

The only problem is 2 annoying lines in glibc and gnupg headers that
sparse-0.3 do not like:
1. Sparse do not like __restrict_attr inside regexec() definition in
   regex.h. Relevant code:

   extern int regexec (const regex_t *__restrict __preg,
                    const char *__restrict __string, size_t __nmatch,
                    regmatch_t __pmatch[__restrict_arr],
                    int __eflags);

   Produces following error: 
   /usr/include/regex.h:543:27: error: typename in expression
   /usr/include/regex.h:543:27: error: undefined identifier '__restrict'
   /usr/include/regex.h:543:27: error: bad constant expression type

   (Note: __restrict_arr is defined to __restrict)
2. And sparse do not know about attribute __constructor__ inside
   gpg-error.h. Relevant code:

#if _GPG_ERR_GCC_VERSION > 30100
#define _GPG_ERR_CONSTRUCTOR    __attribute__ ((__constructor__))
#define _GPG_ERR_HAVE_CONSTRUCTOR
#endif
#endif

#ifndef _GPG_ERR_CONSTRUCTOR
#define _GPG_ERR_CONSTRUCTOR
#endif

/* Initialization function.  */

/* Initialize the library.  This function should be run early.  */
gpg_error_t gpg_err_init (void) _GPG_ERR_CONSTRUCTOR;

I would really happy if you will fix this. Thanks!

-- 
Best regards,
        Yura
