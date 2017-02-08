From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] add support for LLP64 arch
Date: Wed,  8 Feb 2017 23:15:49 +0100
Message-ID: <20170208221549.17543-1-luc.vanoostenryck@gmail.com>
References: <CANeU7QkYmA1opeNQTYjOUXs8hSn1oG3RumVtR094rb4w8KucEQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34893 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbdBHW10 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 17:27:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so358904wmu.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 14:26:56 -0800 (PST)
In-Reply-To: <CANeU7QkYmA1opeNQTYjOUXs8hSn1oG3RumVtR094rb4w8KucEQ@mail.gmail.com>
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
 lib.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/lib.c b/lib.c
index 2a1bbac87..467e040be 100644
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
@@ -399,18 +405,32 @@ static char **handle_switch_m(char *arg, char **next)
 
 static void handle_arch_m64_finalize(void)
 {
-	if (arch_m64) {
+	switch (arch_m64) {
+	case ARCH_LP32:
+		/* default values */
+		return;
+	case ARCH_LP64:
 		bits_in_long = 64;
 		max_int_alignment = 8;
-		bits_in_pointer = 64;
-		pointer_alignment = 8;
 		size_t_ctype = &ulong_ctype;
 		ssize_t_ctype = &long_ctype;
 		add_pre_buffer("#weak_define __LP64__ 1\n");
 		add_pre_buffer("#weak_define _LP64 1\n");
+		goto case_64bit_common;
+	case ARCH_LLP64:
+		bits_in_long = 32;
+		max_int_alignment = 4;
+		size_t_ctype = &ullong_ctype;
+		ssize_t_ctype = &llong_ctype;
+		add_pre_buffer("#weak_define __LLP64__ 1\n");
+		goto case_64bit_common;
+	case_64bit_common:
+		bits_in_pointer = 64;
+		pointer_alignment = 8;
 #ifdef __x86_64__
 		add_pre_buffer("#weak_define __x86_64__ 1\n");
 #endif
+		break;
 	}
 }
 
-- 
2.11.0

