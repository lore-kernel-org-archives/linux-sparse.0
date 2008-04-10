From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 0/3] improve context handling
Date: Thu, 10 Apr 2008 15:25:19 +0200
Message-ID: <20080410132519.049821000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:56462 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619AbYDJOl1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 10:41:27 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Hi,

Here are three patches to improve context tracking in sparse. For example,
with the patches, one could define

spin_lock_irqsave() __acquires(local_irq) __acquires(spinlock)
spin_unlock_irqrestore() __releases(local_irq) __releases(spinlock)

local_irq_save() __acquires(local_irq)
local_irq_restore() __releases(local_irq)

spin_lock() __acquires(spinlock)
spin_unlock() __releases(spinlock)

spin_trylock() __attribute__((conditional_context(spinlock,0,1,0)))

and sparse should be able to check constructs like the one in sungem
completely:

        local_irq_save(flags);
        if (!spin_trylock(&gp->tx_lock)) {
                /* Tell upper layer to requeue */
                local_irq_restore(flags);
                return ...;
        }
        if (..) {
                spin_unlock_irqrestore(&gp->tx_lock, flags);
                return ...;
        }
        [...]
        spin_unlock_irqrestore(&gp->tx_lock, flags);

I haven't tried this particular case, but I have tried simpler versions
of all the primivites used, those are in the test suite.


Also, one can now define, as the sparse man page already suggests without
patches:

/* needs irqs disabled */
void myfunc(void) __attribute__((context(local_irq,1,1)))
{...}

and sparse will warn when the function is called from a context that doesn't
have local_irq. Of course, if the context comes from outside the calling
function then the calling function needs to use that attribute as well to
indicate that it too needs irqs disabled.

Comments welcome!

johannes

