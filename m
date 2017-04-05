From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/9] avoid warnings about using 0 instead of NULL
Date: Wed,  5 Apr 2017 23:09:20 +0200
Message-ID: <20170405210927.27948-3-luc.vanoostenryck@gmail.com>
References: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35484 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934249AbdDEVJl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:09:41 -0400
Received: by mail-wr0-f196.google.com with SMTP id t20so6062298wra.2
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:09:41 -0700 (PDT)
In-Reply-To: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These warning wehere not emitted because of previous errors.
But ...
---
 validation/function-redecl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/validation/function-redecl.c b/validation/function-redecl.c
index 7fbceb43a..475f18e79 100644
--- a/validation/function-redecl.c
+++ b/validation/function-redecl.c
@@ -1,5 +1,5 @@
 #define __user	__attribute__((address_space(1)))
