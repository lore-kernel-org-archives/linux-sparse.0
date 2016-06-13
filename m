From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ptrlist: use after free in last_ptr_list()
Date: Mon, 13 Jun 2016 12:45:17 +0300
Message-ID: <20160613094517.GA25301@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44866 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964840AbcFMJp0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 13 Jun 2016 05:45:26 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u5D9jOiR024436
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-sparse@vger.kernel.org>; Mon, 13 Jun 2016 09:45:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u5D9jNLG026419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-sparse@vger.kernel.org>; Mon, 13 Jun 2016 09:45:24 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id u5D9jNwK019526
	for <linux-sparse@vger.kernel.org>; Mon, 13 Jun 2016 09:45:23 GMT
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This change is similar to 2e7dd34d11cb ('ptrlist: reading deleted items
in NEXT_PTR_LIST()').  If we use DELETE_CURRENT_PTR() then we can end up
with a list->nr that is zero meaning that we have to go back another
list->prev to find what we want.  Otherwise we dereference 0xf0f0f0f0
and crash.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 ptrlist.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ptrlist.h b/ptrlist.h
index 61e159f..6f90c8f 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -78,6 +78,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	if (!list)
 		return NULL;
 	list = list->prev;
+	while (list->nr == 0)
+		list = list->prev;
 	return PTR_ENTRY(list, list->nr-1);
 }
 
-- 
2.8.1

