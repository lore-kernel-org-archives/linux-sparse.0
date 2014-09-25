From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH] sparse: Fix ioc type check
Date: Thu, 25 Sep 2014 10:20:39 +0200
Message-ID: <8d1bffcadf496f52dc70063986684762344da771.1411633200.git.tgraf@suug.ch>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47028 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbaIYIUn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Sep 2014 04:20:43 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: hans.verkuil@cisco.com, sparse@chrisli.org

Add missing exepcted error output for the test to pass.

Fixes: 42ebe41 "Add test case for the ioc type check"
Signed-off-by: Thomas Graf <tgraf@suug.ch>
---
 validation/ioc-typecheck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/validation/ioc-typecheck.c b/validation/ioc-typecheck.c
index aa060f7..baa200a 100644
--- a/validation/ioc-typecheck.c
+++ b/validation/ioc-typecheck.c
@@ -13,5 +13,6 @@ static unsigned iocnrs[] = {
  * check-name: correct handling of _IOC_TYPECHECK
  *
  * check-error-start
+ioc-typecheck.c:10:21: error: bad integer constant expression
  * check-error-end
  */
-- 
1.9.3

