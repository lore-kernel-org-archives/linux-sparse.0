From: Randy Dunlap <rdunlap@xenotime.net>
Subject: sparse preprocessing confused
Date: Wed, 25 Apr 2007 16:43:55 -0700
Message-ID: <20070425164355.2c250388.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:47335 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754351AbXDYXkU (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Apr 2007 19:40:20 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Wed, 25 Apr 2007 16:40:16 -0700
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Although this may just be a case of "it's fugly, kill it".

In net/core/skbuff.c (2.6.21-rc7-mm1), we have:

	memcpy(data + nhead, skb->head,
#ifdef NET_SKBUFF_DATA_USES_OFFSET
		skb->tail);
#else
		skb->tail - skb->head);
#endif

and sparse says:

net/core/skbuff.c:651:2: error: unmatched #else within stream
net/core/skbuff.c:653:2: error: unmatched #endif in stream
net/core/skbuff.c:648:2: error: Expected ) in expression
net/core/skbuff.c:648:2: error: got #
net/core/skbuff.c:648:2: error: Expected ) in function call
net/core/skbuff.c:648:2: error: got #
net/core/skbuff.c:648:2: error: Expected ; at end of statement
net/core/skbuff.c:648:2: error: got __ret
net/core/skbuff.c:652:24: error: Expected ; at end of statement
net/core/skbuff.c:652:24: error: got )
net/core/skbuff.c:648:2: error: undefined identifier 'else'
net/core/skbuff.c:652:13: error: incompatible types for operation (-)
net/core/skbuff.c:652:13:    left side has type unsigned int [unsigned] [usertype] tail
net/core/skbuff.c:652:13:    right side has type unsigned char *head

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
