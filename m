From: Christoph Hellwig <hch@lst.de>
Subject: lock context warnings
Date: Wed, 7 Jan 2009 09:45:40 +0100
Message-ID: <20090107084539.GA15246@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:35448 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbZAGIpl (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Jan 2009 03:45:41 -0500
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n078jeIF015394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 7 Jan 2009 09:45:40 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id n078jeuM015392
	for linux-sparse@vger.kernel.org; Wed, 7 Jan 2009 09:45:40 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Since a few month sparse keeps spewing tons of wrong lock context
warnings like:

/home/hch/work/linux-2.6/fs/xfs/quota/xfs_dquot.c:1341:24: warning:
context problem in 'xfs_qm_dqflush_done': 'xfs_trans_ail_delete'
expected different context
/home/hch/work/linux-2.6/fs/xfs/quota/xfs_dquot.c:1341:24:    context
'xa_lock': wanted >= 1, got 0
/home/hch/work/linux-2.6/fs/xfs/quota/xfs_dquot_item.c:565:22: warning:
context problem in 'xfs_qm_qoffend_logitem_committed':
'xfs_trans_ail_delete' expected different context
/home/hch/work/linux-2.6/fs/xfs/quota/xfs_dquot_item.c:565:22:
context 'xa_lock': wanted >= 1, got 0

which mean lock context annotations just don't seem to work, e.g. the
fist one is:

		/* xfs_trans_ail_delete() drops the AIL lock. */
		spin_lock(&ailp->xa_lock);
		if (qip->qli_item.li_lsn == qip->qli_flush_lsn)	
			xfs_trans_ail_delete(ailp, (xfs_log_item_t*)qip);
		else
			spin_unlock(&ailp->xa_lock);


where xfs_trans_ail_delete prototyped as:

void                    xfs_trans_ail_delete(struct xfs_ail *ailp,
                                        struct xfs_log_item *lip)
					__releases(ailp->xa_lock);


These messages are highly annoying in a kernel build, so if you can't
fix them easily, please at least remove the lock context stuff from
the default check flags.
