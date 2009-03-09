From: Al Viro <viro@ftp.linux.org.uk>
Subject: [patches] more declarations fixes
Date: Mon, 09 Mar 2009 07:10:08 +0000
Message-ID: <E1LgZcm-0000qk-0S@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43719 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbZCIHKK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:10:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZcm-0000qk-0S
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:10:08 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


OK, that pile ought to take care of a lot of nastiness.  We still have
rather messy crap in attributes' handling, but it's actually getting
cleaner now.  In particular, direct_declarator and declaration_specifiers
are relatively sane, handling of type specifiers should be correct now (and
much cleaner than it used to be) and most of the tangled mess around
attributes is untangled.  Still a mess, but at least doing something
about it becomes feasible...

That series is on top of Chris' tree; equivalent on top of Josh's one
is not particulary different.  Have fun...

