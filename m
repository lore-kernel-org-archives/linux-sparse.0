From: Roland Dreier <rdreier@cisco.com>
Subject: Sparse annotation for "context imbalance" false positives?
Date: Wed, 14 May 2008 20:16:39 -0700
Message-ID: <adaod78fe94.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:47151 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbYEODQk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 May 2008 23:16:40 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

Now that I've gotten the sparse noise in drivers/infiniband down to a
fairly low level, I'm starting to look at some of the more recalcitrant
false positive warnings.  One example is:

    drivers/infiniband/hw/mlx4/qp.c:605:2: warning: context imbalance in 'mlx4_ib_lock_cqs' - wrong count at exit

where the function being warned about is:

	static void mlx4_ib_lock_cqs(struct mlx4_ib_cq *send_cq, struct mlx4_ib_cq *recv_cq)
	{
		if (send_cq == recv_cq)
			spin_lock_irq(&send_cq->lock);
		else if (send_cq->mcq.cqn < recv_cq->mcq.cqn) {
			spin_lock_irq(&send_cq->lock);
			spin_lock_nested(&recv_cq->lock, SINGLE_DEPTH_NESTING);
		} else {
			spin_lock_irq(&recv_cq->lock);
			spin_lock_nested(&send_cq->lock, SINGLE_DEPTH_NESTING);
		}
	}

this function wraps up the locking rules for aquiring the completion
queue (CQ) locks associated with a queue pair (QP) -- the rule is that
if both the send and receive CQs are the same object, we (obviously)
only lock it once, otherwise we take the lock belonging to the CQ with a
numerically lower ID first (to avoid AB-BA deadlocks).

So obviously is it correct and intended that this function return
holding one or two locks, but I don't know how to tell sparse that.
I've tried messing around with __acquires() etc but it doesn't seem to
be exactly what I want.

Is there any way to tell sparse what's going on here, or do I just live
with the warnings?

Thanks,
  Roland
