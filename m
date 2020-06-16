From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: fix some typos
Date: Tue, 16 Jun 2020 23:03:33 +0200
Message-ID: <20200616210333.77780-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgFPVDk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 17:03:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B3C061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:03:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so23200238ejn.10
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:03:40 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Fix some silly typos.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/types.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/types.rst b/Documentation/types.rst
index e5d07def0bc2..5c10725fa71a 100644
--- a/Documentation/types.rst
+++ b/Documentation/types.rst
@@ -13,7 +13,7 @@ For the purpose of this document, things can be simplified into:
 		struct ctype {
 			struct symbol *base_type;
 			unsigned long modifiers;
-			unsigned long alignement;
+			unsigned long alignment;
 			struct context_list *contexts;
 			struct indent *as;
 		};
@@ -68,7 +68,7 @@ have their own modifiers, address_space, contexts or alignment
 as well as the declaration's identifier.
 
 Usage:
-  * .ctype.base_type points to the unmodified type (wich must not
+  * .ctype.base_type points to the unmodified type (which must not
     be a SYM_NODE itself)
   * .ctype.modifiers, .as, .alignment, .contexts will contains
     the 'variation' (MOD_CONST, the attributes, ...).
-- 
2.27.0
