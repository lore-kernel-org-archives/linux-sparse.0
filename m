From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: sparse: possible false report of context imbalance
Date: Wed, 16 Oct 2013 22:23:56 -0500
Message-ID: <525F584C.5010106@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:49107 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761432Ab3JQDX6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Oct 2013 23:23:58 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

Sparse reports the following:

   CHECK   drivers/staging/rtl8188eu/core/rtw_mlme.c
drivers/staging/rtl8188eu/core/rtw_mlme.c:1003:9: warning: context imbalance in 
'rtw_free_assoc_resources' - different lock contexts for basic block

The code in question is as follows:

         if (lock_scanned_queue)
                 spin_lock_bh(&(pmlmepriv->scanned_queue.lock));

         pwlan = rtw_find_network(&pmlmepriv->scanned_queue, 
tgt_network->network.MacAddress);

         if (lock_scanned_queue)
                 spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));

As this fragment uses the identical test to unlock that is used to lock, and the 
test variable is not touched, I think this is a false indication. I am using 
version 0.4.4 of sparse.

Thanks,

Larry
