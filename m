From: Adam DiCarlo <bikko@us.ibm.com>
Subject: [PATCH] Add type information to enum mismatch warning
Date: Thu, 31 Aug 2006 17:07:47 -0700
Message-ID: <44F779D3.8090402@us.ibm.com>
Reply-To: bikko@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:29380 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964824AbWIAAHy
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Aug 2006 20:07:54 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8107pTR006524
	for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2006 20:07:51 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8107ojE271790
	for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2006 18:07:50 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8107o66017996
	for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2006 18:07:50 -0600
Received: from [9.47.18.74] (dyn9047018074.beaverton.ibm.com [9.47.18.74])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k8107o3Q017969
	for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2006 18:07:50 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Adam DiCarlo <adam.dicarlo@gmail.com>
---
  evaluate.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 177797a..3076d41 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -253,8 +253,11 @@ warn_for_different_enum_types (struct po
  	if (typea == typeb)
  		return;

-	if (typea->type == SYM_ENUM && typeb->type == SYM_ENUM)
+	if (typea->type == SYM_ENUM && typeb->type == SYM_ENUM) {
  		warning(pos, "mixing different enum types");
+		info(pos, "    %s versus", show_typename(typea));
+		info(pos, "    %s", show_typename(typeb));
+	}
  }

  /*
-- 
1.4.2.ga444
