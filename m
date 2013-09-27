From: "Emilio G. Cota" <cota@braap.org>
Subject: [PATCH] gitignore: add 'version.h'
Date: Fri, 27 Sep 2013 19:57:41 -0400
Message-ID: <1380326261-13229-1-git-send-email-cota@braap.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33777 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab3I0X6q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Sep 2013 19:58:46 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index bb33508..d32d063 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,6 +8,7 @@
 # generated
 pre-process.h
 sparse.pc
+version.h
 
 # programs
 test-inspect
-- 
1.8.3

