From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Mon, 11 Oct 2010 15:23:08 -0700
Message-ID: <20101011222307.GA10570@feather>
References: <20101010173352.GB5851@bicker>
 <1286794326.3634.13.camel@jlt3.sipsolutions.net>
 <20101011185455.GB8537@feather>
 <201010112242.19246.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:42393 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807Ab0JKWXY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 18:23:24 -0400
Content-Disposition: inline
In-Reply-To: <201010112242.19246.arnd@arndb.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Oct 11, 2010 at 10:42:18PM +0200, Arnd Bergmann wrote:
> On Monday 11 October 2010 20:54:56 Josh Triplett wrote:
> > On Mon, Oct 11, 2010 at 12:52:06PM +0200, Johannes Berg wrote:
> >
> > > I don't know. Could be related to trylock issues, could be just historic
> > > since semaphores can't really be annotated, or could be something else
> > > entirely... I would expect a huge amount of warnings from sparse though
> > > if you "just" annotate them since there are things like rtnl_lock()
> > > which would have to propagate context.
> > 
> > As far as I know, no reason exists to not just annotate mutexes; I think
> > mutexes just came along later and nobody happened to add the appropriate
> > annotations.  (Also, sparse does handle trylock.)
> > 
> > But yes, annotating mutexes will then introduce a giant pile of lock
> > warnings that need further annotation propagation.  It will also
> > introduce lock warnings that represent actual bugs, making it important
> > to not just blindly propagate annotations to make warnings go away.
> 
> I've given it a try, wrapping the trylock/interruptible/killable variants
> into macros and the number of additional warnings was much less than
> I had feared. This is the diff for today's sparse with today's linux-next
> x86_64_defconfig:
> 
[...snip...]
> 
> And this is the patch I used for testing. There may still be some flaws in it,
> but it seems to do the trick.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

One minor suggetsion below to simplify the patch; with that added,
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index f363bc8..d4940af 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -14,6 +14,7 @@
>  #include <linux/spinlock_types.h>
>  #include <linux/linkage.h>
>  #include <linux/lockdep.h>
> +#include <linux/compiler.h>
>  
>  #include <asm/atomic.h>
>  
> @@ -131,20 +132,35 @@ static inline int mutex_is_locked(struct mutex *lock)
>   * Also see Documentation/mutex-design.txt.
>   */
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> -extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
> -extern int __must_check mutex_lock_interruptible_nested(struct mutex *lock,
> -					unsigned int subclass);
> -extern int __must_check mutex_lock_killable_nested(struct mutex *lock,
> -					unsigned int subclass);
> -
> +extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass)
> +				__acquires(lock);
> +extern int __must_check __mutex_lock_interruptible_nested(struct mutex *lock,
> +						unsigned int subclass);
> +extern int __must_check __mutex_lock_killable_nested(struct mutex *lock,
> +						unsigned int subclass);
> +#define mutex_lock_interruptible_nested(lock, subclass)	({		\
> +   int __mutex_ret = __mutex_lock_interruptible_nested(lock, subclass);	\
> +   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
> +})
> +#define mutex_lock_killable_nested(lock, subclass)	({		\
> +   int __mutex_ret = __mutex_lock_killable_nested(lock, subclass);	\
> +   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
> +})

Assuming that the underlying function only returns zero/non-zero and
that the actual return value doesn't matter, then you can use the
__cond_lock macro from compiler.h for this:

# define __cond_lock(x,c)       ((c) ? ({ __acquire(x); 1; }) : 0)

>  #define mutex_lock(lock) mutex_lock_nested(lock, 0)
>  #define mutex_lock_interruptible(lock) mutex_lock_interruptible_nested(lock, 0)
>  #define mutex_lock_killable(lock) mutex_lock_killable_nested(lock, 0)
>  #else
> -extern void mutex_lock(struct mutex *lock);
> -extern int __must_check mutex_lock_interruptible(struct mutex *lock);
> -extern int __must_check mutex_lock_killable(struct mutex *lock);
> -
> +extern void mutex_lock(struct mutex *lock) __acquires(lock);
> +extern int __must_check __mutex_lock_interruptible(struct mutex *lock);
> +extern int __must_check __mutex_lock_killable(struct mutex *lock);
> +#define mutex_lock_interruptible(lock)	({				\
> +   int __mutex_ret = __mutex_lock_interruptible(lock);			\
> +   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
> +})
> +#define mutex_lock_killable(lock)	({				\
> +   int __mutex_ret = __mutex_lock_killable(lock);			\
> +   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
> +})

Same here.

>  # define mutex_lock_nested(lock, subclass) mutex_lock(lock)
>  # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
>  # define mutex_lock_killable_nested(lock, subclass) mutex_lock_killable(lock)
> @@ -156,8 +172,16 @@ extern int __must_check mutex_lock_killable(struct mutex *lock);
>   *
>   * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
>   */
> -extern int mutex_trylock(struct mutex *lock);
> -extern void mutex_unlock(struct mutex *lock);
> -extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
> +extern int __mutex_trylock(struct mutex *lock);
> +#define mutex_trylock(lock)	({					\
> +   int __mutex_ret = __mutex_trylock(lock);				\
> +   if (__mutex_ret) __acquire(lock); __mutex_ret; 			\
> +})
> +extern void mutex_unlock(struct mutex *lock) __releases(lock);
> +extern int __atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
> +#define atomic_dec_and_mutex_lock(cnt, lock)	({			\
> +   int __mutex_ret = __atomic_dec_and_mutex_lock(cnt, lock);		\
> +   if (__mutex_ret) __acquire(lock); __mutex_ret; 			\
> +})

And here.

- Josh Triplett
