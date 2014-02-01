From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] validation: In context test, make conditional acquire return
 a status
Date: Sat, 1 Feb 2014 10:33:40 -0800
Message-ID: <20140201183335.GA9697@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51940 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaBASds (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Feb 2014 13:33:48 -0500
Received: from mfilter26-d.gandi.net (mfilter26-d.gandi.net [217.70.178.154])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 2C023172094
	for <linux-sparse@vger.kernel.org>; Sat,  1 Feb 2014 19:33:45 +0100 (CET)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter26-d.gandi.net (mfilter26-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Ie+RTUGJSs4S for <linux-sparse@vger.kernel.org>;
	Sat,  1 Feb 2014 19:33:43 +0100 (CET)
Received: from leaf (static-50-43-14-201.bvtn.or.frontiernet.net [50.43.14.201])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EC14F172055
	for <linux-sparse@vger.kernel.org>; Sat,  1 Feb 2014 19:33:42 +0100 (CET)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The context test defines and tests a __cond_lock mechanism similar to
the kernel, but then applies it to a function that returns void.  Change
that to int.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 validation/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/context.c b/validation/context.c
index 33b70b8..b9500dc 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -10,7 +10,7 @@ static void r(void) __attribute__((context(1,0)))
 	__context__(-1);
 }
 
-extern void _ca(int fail);
+extern int _ca(int fail);
 #define ca(fail) __cond_lock(_ca(fail))
 
 static void good_paired1(void)
-- 
1.9.rc1

