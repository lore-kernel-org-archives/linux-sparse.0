From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] predefine: add testcase for multi-token predefines
Date: Sun,  5 Jul 2020 15:11:45 +0200
Message-ID: <20200705131146.26439-2-luc.vanoostenryck@gmail.com>
References: <20200705131146.26439-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENLw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:11:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D42C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:11:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so31005065edy.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:11:52 -0700 (PDT)
In-Reply-To: <20200705131146.26439-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The function predefine() and its variants are only valid
if they define a single-token value.

Add a testcase for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/predef-token.c | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 validation/preprocessor/predef-token.c

diff --git a/validation/preprocessor/predef-token.c b/validation/preprocessor/predef-token.c
new file mode 100644
index 000000000000..6df8ea407fc5
--- /dev/null
+++ b/validation/preprocessor/predef-token.c
@@ -0,0 +1,5 @@
+static __UINT8_TYPE__ u8;
+
+/*
+ * check-name: predef-token
+ */
-- 
2.27.0
