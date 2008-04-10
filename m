From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC 1/3] add macros for new sparse features
Date: Thu, 10 Apr 2008 18:37:48 +0200
Message-ID: <47FE425C.7060405@s5r6.in-berlin.de>
References: <20080410134810.629048000@sipsolutions.net> <20080410134827.771251000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757191AbYDJQim@vger.kernel.org>
In-Reply-To: <20080410134827.771251000@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@freedesktop.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-wireless@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Johannes Berg wrote:
> This patch adds kernel macros for a few new sparse features, namely
>  * checking try_lock functions and
>  * making a function or macro require a certain lock.
> 
> Still waiting to see what the sparse folks say to my patches.
> 
> Not-yet-signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>  include/linux/compiler.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- everything.orig/include/linux/compiler.h	2008-04-10 15:36:18.000000000 +0200
> +++ everything/include/linux/compiler.h	2008-04-10 15:36:40.000000000 +0200
> @@ -11,9 +11,12 @@
>  # define __nocast	__attribute__((nocast))
>  # define __iomem	__attribute__((noderef, address_space(2)))
>  # define __acquires(x)	__attribute__((context(x,0,1)))
> +# define __try_acquires(x,t,f)	__attribute__((conditional_context(x,0,t,f)))
>  # define __releases(x)	__attribute__((context(x,1,0)))
>  # define __acquire(x)	__context__(x,1)
>  # define __release(x)	__context__(x,-1)
> +# define __requires(x)	__attribute__((context(x,1,1)))
> +# define __macro_requires(x)	__context__(x,0,1)


So, instead of

  /* always call with host_lock held */
  int foo(struct bar *b)
  {

we could write

  int foo(struct bar *b) __requires(host_lock)
  {

and let sparse check the call chains... or how is it used?

And what about dynamically allocated locks?
E.g. b->lock
Or struct host h* = container_of(b, struct host, m); with the necessity
to hold h->lock...
-- 
Stefan Richter
-=====-==--- -=-- -=-=-
http://arcgraph.de/sr/
