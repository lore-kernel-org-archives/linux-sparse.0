From: Randy Dunlap <rdunlap@xenotime.net>
Subject: error, types differ in signedness
Date: Mon, 5 Feb 2007 10:54:20 -0800
Message-ID: <20070205105420.6f19a57d.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:59340 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933365AbXBES5u (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 5 Feb 2007 13:57:50 -0500
Received: from midway.site ([71.245.99.70]) by xenotime.net for <linux-sparse@vger.kernel.org>; Mon, 5 Feb 2007 10:57:39 -0800
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

On Linux 2.6.20 and current sparse, I see these warnings:

net/core/skbuff.c:1838:5: error: symbol 'skb_append_datato_frags' redeclared with different type (originally declared at include/linux/skbuff.h:380) - incompatible argument 3 (different signedness)

fs/mpage.c:821:5: error: symbol 'mpage_writepage' redeclared with different type (originally declared at include/linux/mpage.h:22) - incompatible argument 2 (different signedness)



These are both in function pointers that are arguments to a function.
The skbuff.[hc] difference is in *getfrag vs. getfrag.
The mpage.[hc] difference is in  *get_block vs. getblock.

Questions:
1.  Is the warning valid?
2.  Isn't the '*' unnecessary?

Thanks,
---
~Randy
