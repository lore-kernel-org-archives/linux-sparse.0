From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: reformulate an item in the TODO
Date: Tue, 16 Jun 2020 23:04:13 +0200
Message-ID: <20200616210413.77884-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgFPVES (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 17:04:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE75C061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:04:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y13so23259887eju.2
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:04:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

One of the item wasn't even grammatical. Reformulate it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/TODO.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/TODO.md b/Documentation/TODO.md
index 64c1523cdbd0..e2043e481f99 100644
--- a/Documentation/TODO.md
+++ b/Documentation/TODO.md
@@ -84,8 +84,8 @@ Longer term/to investigate
 
 	"warning: Variable length array is used. (-Wno-vla)"
 
-* ptrlists must have elements be removed while being iterated but this
-  is hard to insure it is not done.
+* ptrlists must not have elements removed while being iterated;
+  this should somehow be enforced.
 * having 'struct symbol' used to represent symbols *and* types is
   quite handy but it also creates lots of problems and complications
 * Possible mixup of symbol for a function designator being not a pointer?
-- 
2.27.0
