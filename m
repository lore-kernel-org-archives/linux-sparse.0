From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] univ-init: set default to -Wno-universal-initializer
Date: Sat, 30 May 2020 17:49:45 +0200
Message-ID: <20200530154945.44985-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Ptv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 30 May 2020 11:49:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86612C03E969
        for <linux-sparse@vger.kernel.org>; Sat, 30 May 2020 08:49:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g9so4012771edw.10
        for <linux-sparse@vger.kernel.org>; Sat, 30 May 2020 08:49:51 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Asher Gordon <AsDaGo@posteo.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'{ 0 }' is the standard idiom for the universal zero initializer '{ }'.

But if the '0' is taken literally, warnings can be issued, for exemple
for 'using 0 as NULL pointer' or for 'using a positional initializer'
when the attribute 'designated_init' is used.
These warnings were not intended to be issued for this initializer
and are confusing and annoying when people have to use or want to
use standard code or ignore that '{ }' is fine to use with GCC,
clang or Sparse.

So, set sparse default to -Wno-universal-initializer, suppressing
any warnings caused by using '{ 0 }' instead of '{ }'.

Reference: https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/
Reference: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95379
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 9ee8d3cf6b21..37c09d914c56 100644
--- a/lib.c
+++ b/lib.c
@@ -295,7 +295,7 @@ int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
-int Wuniversal_initializer = 1;
+int Wuniversal_initializer = 0;
 int Wunknown_attribute = 0;
 int Wvla = 1;
 
-- 
2.26.2
