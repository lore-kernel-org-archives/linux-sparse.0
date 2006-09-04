From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 0/4] pre-processor fixes
Date: Mon, 4 Sep 2006 19:41:16 +0400
Message-ID: <20060904154115.GA6419@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from taganka54-host.corbina.net ([213.234.233.54]:1755 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964783AbWIDLlQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Sep 2006 07:41:16 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josht@us.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>

Hello.

Re-send, see

	[PATCH 1/7] use lookup_macro() in handle_undef()
	http://marc.theaimsgroup.com/?l=linux-sparse&m=113622504413831
	... and others ...

There was no responce. I must admit, I don't remember how this all
works, but this series still applies cleanly, and still fixes bugs.

This is also a preparation for the strong define/undef implementation,
it was sent and ignored as well :)

Oleg.


-- 
VGER BF report: U 0.476099
