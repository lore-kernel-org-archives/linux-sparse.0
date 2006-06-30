From: Josh Triplett <josht@vnet.ibm.com>
Subject: [PATCH] Add test-dissect to .gitignore
Date: Fri, 30 Jun 2006 11:49:04 -0700
Message-ID: <1151693344.6507.84.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:64181 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S933021AbWF3StE
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 30 Jun 2006 14:49:04 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5UIn4OQ017241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Fri, 30 Jun 2006 14:49:04 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5UImSdQ286928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 30 Jun 2006 12:48:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5UIn3ik026848
	for <linux-sparse@vger.kernel.org>; Fri, 30 Jun 2006 12:49:03 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5UIn353026820
	for <linux-sparse@vger.kernel.org>; Fri, 30 Jun 2006 12:49:03 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Josh Triplett <josh@freedesktop.org>

---

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

50d7ca63b85abe691beeb4d0ea39f6d8653798e9
diff --git a/.gitignore b/.gitignore
index a7e5514..32d6e70 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,7 @@ test-parsing
 obfuscate
 check
 compile
+test-dissect
 test-linearize
 example
 test-unssa
