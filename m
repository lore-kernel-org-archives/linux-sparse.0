From: Yoann Padioleau <padator@wanadoo.fr>
Subject: contextual attributes
Date: Mon, 17 Nov 2008 15:47:28 -0600
Message-ID: <8763mmuirz.fsf@aryx.cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from expredir7.cites.uiuc.edu ([128.174.5.168]:60491 "EHLO
	expredir7.cites.uiuc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYKQVtW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Nov 2008 16:49:22 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org



Hi, 

Is it possible by using the __attribute((context(x,y)) sparse
attribute to enforce statically that all the callers of 
certain functions do certain actions such as disabling interrupts ?

I would like an attribute like __assume_disabled_interrupt and 
have such programs:


int __assume_disabled_interrupt    
startpoint() 
{
	return 1;
}


int f1ok()
{
	spin_lock_irq();
	startpoint();
	spin_unlock_irq();
}


int f1bad()
{
	startpoint();
}

