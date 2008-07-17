From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Context imbalance false positive
Date: Thu, 17 Jul 2008 16:52:31 -0700
Message-ID: <43e72e890807171652r133c973dh160ea28d361a4601@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:22957 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760484AbYGQXwf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Jul 2008 19:52:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so196821and.103
        for <linux-sparse@vger.kernel.org>; Thu, 17 Jul 2008 16:52:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>

I'm not sure how to resolve a situation like this:

#include <linux/module.h>
#include <linux/spinlock.h>

MODULE_AUTHOR("Luis R. Rodriguez");
MODULE_LICENSE("GPL");

static spinlock_t some_lock;

static void lock(int bh_flag)
{
        if (bh_flag)
                spin_lock_bh(&some_lock);
        else
                spin_lock(&some_lock);
}

static void unlock(int bh_flag)
{
        if (bh_flag)
                spin_unlock_bh(&some_lock);
        else
                spin_unlock(&some_lock);
}

static int hello_init(void)
{
        spin_lock_init(&some_lock);
        lock(1);
        printk("I am a module, cheers!\n");
        unlock(1);
        return 0;
}

static void goodbye_exit(void)
{
        printk("Goodbye cruel world!\n");
}

module_init(hello_init);
module_exit(goodbye_exit);

----

Sparse complains with:
/home/mcgrof/devel/spin_lock_sparse/sparse_spinlock.c:14:3: warning:
context imbalance in 'lock': wrong count at exit
/home/mcgrof/devel/spin_lock_sparse/sparse_spinlock.c:14:3:    context
'lock': wanted 0, got 1
/home/mcgrof/devel/spin_lock_sparse/sparse_spinlock.c:20:3: warning:
context problem in 'unlock': '_spin_unlock_bh' expected different
context
/home/mcgrof/devel/spin_lock_sparse/sparse_spinlock.c:20:3:    context
'lock': wanted >= 1, got 0

You can test compile from files here:

http://ruslug.rutgers.edu/~mcgrof/spin_lock_sparse/

  Luis
