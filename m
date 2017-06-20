From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] teach sparse about __BYTE_ORDER__ & __ORDER_{BIG,LITTLE}_ENDIAN__
Date: Tue, 20 Jun 2017 22:19:31 +0200
Message-ID: <20170620201931.92864-4-luc.vanoostenryck@gmail.com>
References: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33563 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdFTUTl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 16:19:41 -0400
Received: by mail-wr0-f193.google.com with SMTP id x23so20345037wrb.0
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 13:19:40 -0700 (PDT)
In-Reply-To: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some macros, structures definitions, ... depends on the
endianness. This is generaly done via some header file
but these headers need information from the compiler via
the macros __BYTE_ORDER__, itself being defined to
__ORDER_BIG_ENDIAN__ or __ORDER_LITTLE_ENDIAN__.

Let sparse predefine these macros like compilers do.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                      | 6 ++++++
 validation/endian-big.c    | 3 +++
 validation/endian-little.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/lib.c b/lib.c
index daf7d0219..de6350439 100644
--- a/lib.c
+++ b/lib.c
@@ -964,6 +964,12 @@ static void predefined_macros(void)
 
 	add_pre_buffer("#weak_define __%s_ENDIAN__ 1\n",
 		arch_big_endian ? "BIG" : "LITTLE");
+
+	add_pre_buffer("#weak_define __ORDER_LITTLE_ENDIAN__ 1234\n");
+	add_pre_buffer("#weak_define __ORDER_BIG_ENDIAN__ 4321\n");
+	add_pre_buffer("#weak_define __ORDER_PDP_ENDIAN__ 3412\n");
+	add_pre_buffer("#weak_define __BYTE_ORDER__ __ORDER_%s_ENDIAN__\n",
+		arch_big_endian ? "BIG" : "LITTLE");
 }
 
 void declare_builtin_functions(void)
diff --git a/validation/endian-big.c b/validation/endian-big.c
index d535748cd..ebf95df70 100644
--- a/validation/endian-big.c
+++ b/validation/endian-big.c
@@ -4,6 +4,9 @@
 #if (__BIG_ENDIAN__ != 1)
 #error "__BIG_ENDIAN__ not correctly defined!"
 #endif
+#if (__BYTE_ORDER__ != __ORDER_BIG_ENDIAN__)
+#error "__BYTE_ORDER__ not correctly defined!"
+#endif
 
 /*
  * check-name: endian-big.c
diff --git a/validation/endian-little.c b/validation/endian-little.c
index cc4a14f73..57ef69866 100644
--- a/validation/endian-little.c
+++ b/validation/endian-little.c
@@ -4,6 +4,9 @@
 #if (__LITTLE_ENDIAN__ != 1)
 #error "__LITTLE_ENDIAN__ not correctly defined!"
 #endif
+#if (__BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__)
+#error "__BYTE_ORDER__ not correctly defined!"
+#endif
 
 /*
  * check-name: endian-little.c
-- 
2.13.0

