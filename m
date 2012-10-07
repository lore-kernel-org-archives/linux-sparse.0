From: Ed Cashin <ecashin@coraid.com>
Subject: Re: "unexpected unlock" when unlocking, conditional, lock in loop
Date: Sun, 7 Oct 2012 16:28:16 -0500
Message-ID: <E2F79A45-57FB-48C5-B8FC-27C431B1B2BB@coraid.com>
References: <1349552876.20963@cat.he.net> <20121006202102.GA28179@leaf>
 <66AC2AD6-C0FA-4F60-850A-D8C9426184B8@coraid.com>
 <20121007023946.GA30713@leaf>
 <E7D62B13-C7E3-4A4B-B579-81E773DDC641@coraid.com> <20121007194552.GA909@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server505f.appriver.com ([98.129.35.10]:2777 "EHLO
	server505.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751278Ab2JGV2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Oct 2012 17:28:21 -0400
In-Reply-To: <20121007194552.GA909@leaf>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Oct 7, 2012, at 3:45 PM, Josh Triplett wrote:

> On Sun, Oct 07, 2012 at 07:49:25AM -0500, Ed Cashin wrote:
...
>>  CC [M]  drivers/block/aoe/demo.o
>> drivers/block/aoe/demo.c:9: warning: `context' attribute directive ignored
>> drivers/block/aoe/demo.c:9: error: expected `,' or `;' before `{' token
>> make[1]: *** [drivers/block/aoe/demo.o] Error 1
>> make: *** [drivers/block/aoe/aoe.ko] Error 2
> 
> Oh, that complaint doesn't come from Sparse; that comes from GCC, since
> GCC doesn't understand the context attribute.  Look at
> include/linux/compiler.h; it has wrapper macros for the various Sparse
> attributes, and defines them to nothing when not compiling with Sparse.
> If you want to use the context attribute to denote a lock held through a
> function, you need a patch like this:
> 
> From 0b862fc1a131a874d157420e9443f16a714596ef Mon Sep 17 00:00:00 2001
> From: Josh Triplett <josh@joshtriplett.org>
> Date: Sun, 7 Oct 2012 12:41:13 -0700
> Subject: [PATCH] linux/compiler.h: Add __must_hold macro for functions called with a lock held

Ah.  OK.  So... would you like me to submit your patch to the LKML, or are you doing that?

It seems like a needed addition.

> linux/compiler.h has macros to denote functions that acquire or release
> locks, but not to denote functions called with a lock held that return
> with the lock still held.  Add a __must_hold macro to cover this case.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
> include/linux/compiler.h |    2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index f430e41..b121554 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -10,6 +10,7 @@
> # define __force	__attribute__((force))
> # define __nocast	__attribute__((nocast))
> # define __iomem	__attribute__((noderef, address_space(2)))
> +# define __must_hold(x)	__attribute__((context(x,1,1)))
> # define __acquires(x)	__attribute__((context(x,0,1)))
> # define __releases(x)	__attribute__((context(x,1,0)))
> # define __acquire(x)	__context__(x,1)
> @@ -33,6 +34,7 @@ extern void __chk_io_ptr(const volatile void __iomem *);
> # define __chk_user_ptr(x) (void)0
> # define __chk_io_ptr(x) (void)0
> # define __builtin_warning(x, y...) (1)
> +# define __must_hold(x)
> # define __acquires(x)
> # define __releases(x)
> # define __acquire(x) (void)0

-- 
  Ed Cashin
  ecashin@coraid.com


