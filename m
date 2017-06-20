From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] teach sparse about -m{big,little}-endian
Date: Tue, 20 Jun 2017 22:19:29 +0200
Message-ID: <20170620201931.92864-2-luc.vanoostenryck@gmail.com>
References: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33498 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdFTUTi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 16:19:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id x23so20344736wrb.0
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 13:19:38 -0700 (PDT)
In-Reply-To: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some macros, structures definitions, ... depends on the
endianness and thus checking them with sparse demands
that sparse is endian-aware.

Give this information to sparse with two flags:
-mbig-endian/-mlittle-endian, and by default use
the endianness of the platform used to compile sparse.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 15 ++++++++++++++-
 lib.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index eac84ee3f..a22635ecc 100644
--- a/lib.c
+++ b/lib.c
@@ -282,6 +282,14 @@ static enum { STANDARD_C89,
 int arch_m64 = ARCH_M64_DEFAULT;
 int arch_msize_long = 0;
 
+#ifdef __BIG_ENDIAN__
+#define ARCH_BIG_ENDIAN 1
+#else
+#define ARCH_BIG_ENDIAN 0
+#endif
+int arch_big_endian = ARCH_BIG_ENDIAN;
+
+
 #define CMDLINE_INCLUDE 20
 static int cmdline_include_nr = 0;
 static char *cmdline_include[CMDLINE_INCLUDE];
@@ -410,8 +418,13 @@ static char **handle_switch_m(char *arg, char **next)
 		arch_m64 = ARCH_LLP64;
 	} else if (!strcmp(arg, "msize-long")) {
 		arch_msize_long = 1;
-	} else if (!strcmp(arg, "multiarch-dir"))
+	} else if (!strcmp(arg, "multiarch-dir")) {
 		return handle_multiarch_dir(arg, next);
+	} else if (!strcmp(arg, "mbig-endian")) {
+		arch_big_endian = 1;
+	} else if (!strcmp(arg, "mlittle-endian")) {
+		arch_big_endian = 0;
+	}
 	return next;
 }
 
diff --git a/lib.h b/lib.h
index e09f47f12..3f8d3615a 100644
--- a/lib.h
+++ b/lib.h
@@ -150,6 +150,7 @@ extern int fdump_linearize;
 extern unsigned long long fmemcpy_max_count;
 
 extern int arch_m64;
+extern int arch_big_endian;
 
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
-- 
2.13.0

