From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 1/3 v3] .gitignore: add cscope and Qt project files
Date: Mon, 10 Aug 2015 08:33:54 -0400
Message-ID: <1439210034-19310-1-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-2-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbbHJMd5 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 10 Aug 2015 08:33:57 -0400
In-Reply-To: <1438216001-8862-2-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com, sparse@chrisli.org

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index d32d063..44218a2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,3 +40,6 @@ series
 # local makefile
 local.mk
 
+# cscope and Qt files
+cscope.out
+*.pro*
-- 
2.4.3

