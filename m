From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Wed, 30 Aug 2017 17:55:00 +0100
Message-ID: <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:56894 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdH3QzE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Aug 2017 12:55:04 -0400
In-Reply-To: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>, linux-sparse@vger.kernel.org
Cc: 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>



On 30/08/17 17:14, Uwe Kleine-König wrote:
> Hello,
> 
> Antoine Beaupre (on Cc:) noticed that sparse doesn't work on some not so
> common architectures like ppc32le, s390x, ppc64 and sparc64[1]. This is
> nicely catched by the testsuite, e.g.:

The only architecture, from the above list, that is not supported
by cgcc seems to be ppc32le.

> 	ukleinek@plummer:~/sparse$ git rev-parse HEAD
> 	958c11c35d98417eb6b948bffe2dffed14eb3320
> 	ukleinek@plummer:~/sparse$ uname -a
> 	Linux plummer 4.9.0-3-powerpc64le #1 SMP Debian 4.9.30-2+deb9u3 (2017-08-06) ppc64le GNU/Linux
> 	ukleinek@plummer:~/sparse$ make check V=1

It would be easier to see the results if you _didn't_ add V=1. ;-)

[snip]
> 	Out of 287 tests, 272 passed, 15 failed (10 of them are known to fail)
> 	Makefile:232: recipe for target 'check' failed
> 	make: *** [check] Error 1
> 	ukleinek@plummer:~/sparse$ 

The additional five failures are all in the llvm backend (sparsec),
which you do not need to use sparse as a 'checker'.

> The problem is that some cpp symbols are not defined in sparse that are
> expected to exist. So I can "fix" backend/sum.c with the following
> patch:
> 
> diff --git a/validation/backend/sum.c b/validation/backend/sum.c
> index 0604299..d0be8dd 100644
> --- a/validation/backend/sum.c
> +++ b/validation/backend/sum.c
> @@ -1,3 +1,5 @@
> +#define __powerpc64__
> +#define _CALL_ELF 2
>  #include <stdio.h>
>  #include <stdlib.h>
>  
> 

Yep, sparse/sparsec do not define various macros that gcc/clang define
by default on a given architecture. This is a known problem (that I have
been meaning to fix ...). The 'workaround' for the time being is to use
the cgcc front-end to sparse. (for example 'make CC=cgcc', or perhaps
'cgcc -no-compile').

[You didn't mention your usage - is this for a kernel build?]

ATB,
Ramsay Jones

