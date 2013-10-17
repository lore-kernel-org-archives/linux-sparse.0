From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: sparse: possible false report of context imbalance
Date: Thu, 17 Oct 2013 09:25:52 -0700
Message-ID: <20131017162551.GA4123@jtriplet-mobl1>
References: <525F584C.5010106@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <525F584C.5010106@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Wed, Oct 16, 2013 at 10:23:56PM -0500, Larry Finger wrote:
> Sparse reports the following:
> 
>   CHECK   drivers/staging/rtl8188eu/core/rtw_mlme.c
> drivers/staging/rtl8188eu/core/rtw_mlme.c:1003:9: warning: context
> imbalance in 'rtw_free_assoc_resources' - different lock contexts
> for basic block
> 
> The code in question is as follows:
> 
>         if (lock_scanned_queue)
>                 spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
> 
>         pwlan = rtw_find_network(&pmlmepriv->scanned_queue,
> tgt_network->network.MacAddress);
> 
>         if (lock_scanned_queue)
>                 spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
> 
> As this fragment uses the identical test to unlock that is used to
> lock, and the test variable is not touched, I think this is a false
> indication. I am using version 0.4.4 of sparse.

Sparse can't track conditional contexts like this; sparse intentionally
complains here that you're running the same basic block (the
rtw_find_network call) with and without a lock held.

The following workaround works when this is legitimate, though it isn't
ideal:

if (condition) {
	lock
	do_thing
	unlock
} else {
	do_thing
}

Ideally, Sparse should be able to track conditional contexts, but that
would require some form of abstract evaluation, or as a simplistic hack,
looking for identical side-effect-free conditional expressions.

- Josh Triplett
