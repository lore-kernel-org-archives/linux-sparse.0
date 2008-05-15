From: Roland Dreier <rdreier@cisco.com>
Subject: Re: Sparse annotation for "context imbalance" false positives?
Date: Thu, 15 May 2008 08:05:23 -0700
Message-ID: <ada7idvfw0c.fsf@cisco.com>
References: <adaod78fe94.fsf@cisco.com>
	<1210841663.4282.9.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:22453 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742AbYEOPGY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 15 May 2008 11:06:24 -0400
In-Reply-To: <1210841663.4282.9.camel@johannes.berg> (Johannes Berg's message
	of "Thu, 15 May 2008 10:54:23 +0200")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, David Brownell <david-b@pacbell.net>

 > You could, for example, insert this:
 > 
 > > 	static void mlx4_ib_lock_cqs(struct mlx4_ib_cq *send_cq, struct mlx4_ib_cq *recv_cq)
 > > 	{
 > > 		if (send_cq == recv_cq)
 > 		{
 > > 			spin_lock_irq(&send_cq->lock);
 > 			 /* pretend to have acquired both for sparse */	
 > 			__acquire(&recv_cq->lock);
 > 		}

but the problem sparse sees is not that some paths take only one lock
and some take two -- sparse is complaining that this function is
returning without unlocking the locks that it takes.  Even if I change
the function to something as simple as:

	static void mlx4_ib_lock_cqs(struct mlx4_ib_cq *send_cq, struct mlx4_ib_cq *recv_cq)
	{
		spin_lock_irq(&recv_cq->lock);
	}

I still get

    drivers/infiniband/hw/mlx4/qp.c:603:13: warning: context imbalance in 'mlx4_ib_lock_cqs' - wrong count at exitn

thanks,
  Roland
