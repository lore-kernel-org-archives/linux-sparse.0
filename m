From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] misc: fix typo: s/OS_UNIX/OS_NATIVE/
Date: Mon, 18 May 2020 01:21:46 +0200
Message-ID: <20200517232146.1710-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgEQXVz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:21:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703BC061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:21:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so9745526wrq.2
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:21:53 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 machine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/machine.h b/machine.h
index c55e3f1badd4..9c17dd6aa620 100644
--- a/machine.h
+++ b/machine.h
@@ -113,7 +113,7 @@ enum {
 #elif defined(__sun__) || defined(__sun)
 #define OS_NATIVE	OS_SUNOS
 #elif defined(__unix__) || defined(__unix)
-#define OS_UNIX		OS_UNIX
+#define OS_NATIVE	OS_UNIX
 #else
 #define OS_NATIVE	OS_UNKNOWN
 #endif
-- 
2.26.2
