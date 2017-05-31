From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] div0: add warning option -Wdiv-by-zero
Date: Wed, 31 May 2017 05:22:03 +0200
Message-ID: <20170531032207.95830-6-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36049 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdEaDWV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id k15so1016653wmh.3
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:21 -0700 (PDT)
In-Reply-To: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 2 ++
 lib.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/lib.c b/lib.c
index e1e6a1cbf..af2ad83a2 100644
--- a/lib.c
+++ b/lib.c
@@ -225,6 +225,7 @@ int Wdecl = 1;
 int Wdeclarationafterstatement = -1;
 int Wdefault_bitfield_sign = 0;
 int Wdesignated_init = 1;
+int Wdiv_by_zero = 1;
 int Wdo_while = 0;
 int Winit_cstring = 0;
 int Wenum_mismatch = 1;
@@ -502,6 +503,7 @@ static const struct warning {
 	{ "declaration-after-statement", &Wdeclarationafterstatement },
 	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
 	{ "designated-init", &Wdesignated_init },
+	{ "div-by-zero", &Wdiv_by_zero },
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "sparse-error", &Wsparse_error },
diff --git a/lib.h b/lib.h
index 2c8529f93..820e69476 100644
--- a/lib.h
+++ b/lib.h
@@ -112,6 +112,7 @@ extern int Wdecl;
 extern int Wdeclarationafterstatement;
 extern int Wdefault_bitfield_sign;
 extern int Wdesignated_init;
+extern int Wdiv_by_zero;
 extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wsparse_error;
-- 
2.13.0

