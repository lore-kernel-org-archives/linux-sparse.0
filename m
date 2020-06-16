From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: update TODO
Date: Tue, 16 Jun 2020 23:02:59 +0200
Message-ID: <20200616210259.77723-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgFPVDE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 17:03:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD70C061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:03:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gl26so23201771ejb.11
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:03:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Support for __builtin_unreachable() was added in commit
  d2be323e25c3 ("teach sparse to linearize __builtin_unreachable()")

So, remove this item from the TODO list.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/TODO.md | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/TODO.md b/Documentation/TODO.md
index 4344a1dc9b0d..64c1523cdbd0 100644
--- a/Documentation/TODO.md
+++ b/Documentation/TODO.md
@@ -34,7 +34,6 @@ Misc
 ----
 * GCC's -Wenum-compare / clangs's -Wenum-conversion -Wassign-enum
 * parse __attribute_((fallthrough))
-* add support for __builtin_unreachable()
 * add support for format(printf())  (WIP by Ben Dooks)
 * make use of UNDEFs (issues warnings, simplification, ... ?)
 * add a pass to inline small functions during simplification.
-- 
2.27.0
