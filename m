From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add missing #include "char.h" to char.c
Date: Wed,  2 Nov 2016 18:15:44 +0100
Message-ID: <20161102171544.17783-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34314 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932624AbcKBRPv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 13:15:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id p190so4052640wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 10:15:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

And so quiets a warning from sparse about undeclared
symbols when running on its own code.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/char.c b/char.c
index 9bd3fc0d..e3f6a006 100644
--- a/char.c
+++ b/char.c
@@ -4,6 +4,7 @@
 #include "allocate.h"
 #include "token.h"
 #include "expression.h"
+#include "char.h"
 
 static const char *parse_escape(const char *p, unsigned *val, const char *end, int bits, struct position pos)
 {
-- 
2.10.1

