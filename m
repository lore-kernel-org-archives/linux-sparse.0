From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC,PATCH 4/4] add support for LLP64 arch
Date: Tue,  7 Feb 2017 21:04:25 +0100
Message-ID: <20170207200425.34189-5-luc.vanoostenryck@gmail.com>
References: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33439 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754921AbdBGUGf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:06:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so30256597wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:06:35 -0800 (PST)
In-Reply-To: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

There was recently on the mailing list some questions
and a need to support LLP64 model.

This patch add is by adjusting a few size-related variables
under the control of a new flag: -msize-llp64 (ugly name
but we already have we have '-msize-long').

CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib.c b/lib.c
index 2a1bbac87..6e740839c 100644
--- a/lib.c
+++ b/lib.c
@@ -257,10 +257,14 @@ static enum { STANDARD_C89,
               STANDARD_GNU89,
               STANDARD_GNU99, } standard = STANDARD_GNU89;
 
+#define ARCH_LP32  0
+#define ARCH_LP64  1
+#define ARCH_LLP64 2
+
 #ifdef __x86_64__
-#define ARCH_M64_DEFAULT 1
+#define ARCH_M64_DEFAULT ARCH_LP64
 #else
-#define ARCH_M64_DEFAULT 0
+#define ARCH_M64_DEFAULT ARCH_LP32
 #endif
 
 int arch_m64 = ARCH_M64_DEFAULT;
@@ -387,9 +391,11 @@ static char **handle_multiarch_dir(char *arg, char **next)
 static char **handle_switch_m(char *arg, char **next)
 {
 	if (!strcmp(arg, "m64")) {
-		arch_m64 = 1;
+		arch_m64 = ARCH_LP64;
 	} else if (!strcmp(arg, "m32")) {
-		arch_m64 = 0;
+		arch_m64 = ARCH_LP32;
+	} else if (!strcmp(arg, "msize-llp64")) {
+		arch_m64 = ARCH_LLP64;
 	} else if (!strcmp(arg, "msize-long")) {
 		arch_msize_long = 1;
 	} else if (!strcmp(arg, "multiarch-dir"))
@@ -400,14 +406,22 @@ static char **handle_switch_m(char *arg, char **next)
 static void handle_arch_m64_finalize(void)
 {
 	if (arch_m64) {
-		bits_in_long = 64;
-		max_int_alignment = 8;
 		bits_in_pointer = 64;
 		pointer_alignment = 8;
-		size_t_ctype = &ulong_ctype;
-		ssize_t_ctype = &long_ctype;
-		add_pre_buffer("#weak_define __LP64__ 1\n");
-		add_pre_buffer("#weak_define _LP64 1\n");
+		if (arch_m64 == ARCH_LP64) {
+			bits_in_long = 64;
+			max_int_alignment = 8;
+			size_t_ctype = &ulong_ctype;
+			ssize_t_ctype = &long_ctype;
+			add_pre_buffer("#weak_define __LP64__ 1\n");
+			add_pre_buffer("#weak_define _LP64 1\n");
+		} else {
+			bits_in_long = 32;
+			max_int_alignment = 4;
+			size_t_ctype = &ullong_ctype;
+			ssize_t_ctype = &llong_ctype;
+			add_pre_buffer("#weak_define __LLP64__ 1\n");
+		}
 #ifdef __x86_64__
 		add_pre_buffer("#weak_define __x86_64__ 1\n");
 #endif
-- 
2.11.0

