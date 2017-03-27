From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 35/52] llvm: add test case pointer compare with cast
Date: Mon, 27 Mar 2017 23:23:59 +0200
Message-ID: <20170327212416.18536-36-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33575 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdC0V1F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id 20so17044090wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:04 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
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

