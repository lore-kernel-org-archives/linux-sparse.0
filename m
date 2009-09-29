From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Ignore the ms_abi/sysv_abi attributes.
Date: Tue, 29 Sep 2009 23:01:06 +0200
Message-ID: <20090929210106.GA3592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41157 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbZI2VBD (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Sep 2009 17:01:03 -0400
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8TL171W015492
	for <linux-sparse@vger.kernel.org>; Tue, 29 Sep 2009 17:01:07 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8TL16hr018979
	for <linux-sparse@vger.kernel.org>; Tue, 29 Sep 2009 17:01:07 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is needed for getting a meaningful sparse run on a Wine 64-bit
compile. Else the basic Win32 headers will produce tons of
error: attribute 'ms_abi': unknown attribute
which end in
error: too many errors.

The sysv_abi attribute was just added for symmetry.

Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
 parse.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index 5e75242..5f6f9c3 100644
--- a/parse.c
+++ b/parse.c
@@ -525,6 +525,10 @@ static struct init_keyword {
 	{ "__stdcall__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "fastcall",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__fastcall__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "ms_abi",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__ms_abi__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "sysv_abi",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__sysv_abi__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "dllimport",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__dllimport__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "dllexport",	NS_KEYWORD,	.op = &ignore_attr_op },
-- 
1.6.5.rc1
