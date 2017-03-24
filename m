From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 35/51] llvm: add test case pointer compare with cast
Date: Sat, 25 Mar 2017 00:20:41 +0100
Message-ID: <20170324232057.15033-36-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34866 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935315AbdCXXYC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id u108so606148wrb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:00 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/pointer-cmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/validation/backend/pointer-cmp.c b/validation/backend/pointer-cmp.c
index fa76d1b57..d1eec0ed2 100644
--- a/validation/backend/pointer-cmp.c
+++ b/validation/backend/pointer-cmp.c
@@ -3,6 +3,9 @@ int cmpflt( float x, float y)	{ return x == y; }
 int cmpvptr(void *x, void *y)	{ return x == y; }
 int cmpiptr(int  *x, int  *y)	{ return x == y; }
 
+int cmpmptr(long  x, int  *y)	{ return (int*)x == y; }
+int cmpnptr(int  *x, long  y)	{ return x == (int*)y; }
+
 /*
  * check-name: pointer comparison
  * check-command: ./sparsec -Wno-decl -c $file -o tmp.o
-- 
2.12.0

