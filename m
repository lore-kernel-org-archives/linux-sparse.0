From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 47/63] llvm: add test case pointer compare with cast
Date: Tue, 21 Mar 2017 01:15:51 +0100
Message-ID: <20170321001607.75169-48-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36157 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdCUARL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so254589wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:10 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

