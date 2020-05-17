From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] doc: remove done item from the TODO
Date: Mon, 18 May 2020 01:27:19 +0200
Message-ID: <20200517232719.1789-4-luc.vanoostenryck@gmail.com>
References: <20200517232719.1789-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgEQX11 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:27:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EDEC061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so9663413wrx.10
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:27 -0700 (PDT)
In-Reply-To: <20200517232719.1789-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/TODO.md | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/TODO.md b/Documentation/TODO.md
index 31826df33aae..4344a1dc9b0d 100644
--- a/Documentation/TODO.md
+++ b/Documentation/TODO.md
@@ -24,12 +24,6 @@ Core
   - add the sym into a list and
   - recalculate the addressability before memops's SSA conversion
 * bool_ctype should be split into internal 1-bit / external 8-bit
-* Previous declarations and the definition need to be merged. For example,
-  in the code here below, the function definition is **not** static:
-  ```
-	static void foo(void);
-	void foo(void) { ... }
-  ```
 
 Testsuite
 ---------
-- 
2.26.2
