From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: what's with "symbol blah was not declared"
Date: Thu, 30 Aug 2007 21:05:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0708302100090.26586@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:45784 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751035AbXHaEFg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 31 Aug 2007 00:05:36 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-sparse@vger.kernel.org>; Thu, 30 Aug 2007 21:05:34 -0700
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


e.g., linux kernel source code: init/do_mounts.c, line 23 is:

int __initdata rd_doload;


and sparse (snapshot of 2007-08-31) says:

init/do_mounts.c:23:16: warning: symbol 'rd_doload' was not declared. Should it be static?



thanks,
-- 
~Randy
