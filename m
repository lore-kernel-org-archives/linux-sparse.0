From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: error: undefined identifier '__builtin_va_copy'
Date: Sun, 25 Dec 2005 19:03:00 -0800
Message-ID: <20051225190300.4726e208.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:15030 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750984AbVLZDCZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 25 Dec 2005 22:02:25 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-sparse@vger.kernel.org>; Sun, 25 Dec 2005 19:02:24 -0800
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


In Linux 2.6.15-rc7/kernel/audit.c, line 754,
with gcc 3.3.5:
gcc (GCC) 3.3.5 20050117 (prerelease) (SUSE Linux)


kernel/audit.c:754:2: error: undefined identifier '__builtin_va_copy'


Is this a gcc or sparse or kernel error?

Thanks,
---
~Randy
