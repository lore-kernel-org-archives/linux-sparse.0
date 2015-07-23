From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ptrlist: reading deleted items in NEXT_PTR_LIST()
Date: Thu, 23 Jul 2015 11:24:14 +0300
Message-ID: <20150723082414.GA30778@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43222 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbbGWIYX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 Jul 2015 04:24:23 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t6N8ONiR009776
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2015 08:24:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t6N8OMQQ025208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2015 08:24:23 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t6N8OMYP022683
	for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2015 08:24:22 GMT
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

If you call DELETE_CURRENT_PTR(), then you can sometimes end up with a
__list->nr that is zero.  The FOR_EACH_PTR() macro can handle this but
the NEXT_PTR_LIST() macro returns ptr = 0xf0f0f0f0 which leads to a
segfault.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 ptrlist.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ptrlist.h b/ptrlist.h
index 58d3bda..61e159f 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -97,6 +97,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
 			} else {							\
 				__list = __list->next;					\
 				ptr = NULL;						\
+				while (__list->nr == 0 && __list != __head)		\
+					__list = __list->next;				\
 				if (__list != __head) {					\
 					__nr = 0;					\
 					ptr = PTR_ENTRY(__list,0);			\
-- 
2.1.4

