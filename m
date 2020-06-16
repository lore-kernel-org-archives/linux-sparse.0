From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] predefine: add a macro telling about named address spaces
Date: Tue, 16 Jun 2020 02:50:12 +0200
Message-ID: <20200616005012.66141-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFPAuS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 Jun 2020 20:50:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327FC061A0E
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 17:50:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t21so12947727edr.12
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 17:50:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse supports named address spaces since v0.6.0-rc1.
This gives much nicer warnings ('... __user' instead of '... <asn:1>')
but this featres is not yet used in the kernel since it could be
a problem for people using an older version of Sparse.

So, add a define which can be used to check if named address spaces
are supported or not.

I should have done this a long time ago!

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib.c b/lib.c
index 951d400ea2fa..ebbcd3b150aa 100644
--- a/lib.c
+++ b/lib.c
@@ -1295,6 +1295,7 @@ static void predefined_ctype(const char *name, struct symbol *type, int flags)
 static void predefined_macros(void)
 {
 	predefine("__CHECKER__", 0, "1");
+	predefine("__SPARSE_HAS_NAMED_ADDRESS_SPACE__", 0, "1");
 	predefine("__GNUC__", 1, "%d", gcc_major);
 	predefine("__GNUC_MINOR__", 1, "%d", gcc_minor);
 	predefine("__GNUC_PATCHLEVEL__", 1, "%d", gcc_patchlevel);
-- 
2.27.0
