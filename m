From: Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH] Add -gcc-version option
Date: Tue, 18 Jul 2017 14:59:45 -0700
Message-ID: <CAN_72e10vHGWwmovq_ra7FKE9EQgo-T+r8AavwFErkEV9Hnuww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35724 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbdGRV7q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 17:59:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id h143so2084186oic.2
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 14:59:46 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The option argument is parsed into major, minor and patchlevel versions,
which are defined as __GNUC__, __GNUC_MINOR__, and __GNUC_PATCHLEVEL__ in
the preprocessor.

One possible use is running sparse compiled with the lastest gcc compiler
on a Linux kernel that doesn't support that compiler.

Signed-off-by: Pavel Roskin <pavel.roskin@virginorbit.com>
---
 lib.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 sparse.1 |  7 +++++++
 2 files changed, 52 insertions(+)

diff --git a/lib.c b/lib.c
index ce66a81..aff6862 100644
--- a/lib.c
+++ b/lib.c
@@ -24,6 +24,7 @@
  */
 #include <ctype.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -831,10 +832,54 @@ static char **handle_base_dir(char *arg, char **next)
     return next;
 }

+static char **handle_gcc_version(char *arg, char **next)
+{
+    unsigned long gcc_major_ul, gcc_minor_ul = 0, gcc_patchlevel_ul = 0;
+    char *gcc_version, *p;
+
+    gcc_version = *++next;
+    if (!gcc_version)
+        die("missing argument for -gcc-version option");
+
+    gcc_major_ul = strtoul(gcc_version, &p, 10);
+    if (gcc_major_ul > INT_MAX)
+        die("bad gcc major version");
+
+    if (*p == '\0')
+        goto good;
+    else if (*p != '.')
+        die("bad character after gcc major version");
+
+    gcc_minor_ul = strtoul(p + 1, &p, 10);
+    if (gcc_minor_ul > INT_MAX)
+        die("bad gcc minor version");
+
+    if (*p == '\0')
+        goto good;
+    else if (*p != '.')
+        die("bad character after gcc minor version");
+
+    gcc_patchlevel_ul = strtoul(p + 1, &p, 10);
+    if (gcc_patchlevel_ul > INT_MAX)
+        die("bad gcc patchlevel version");
+
+    if (*p != '\0')
+        die("bad character after gcc patchlevel version");
+
+good:
+    gcc_major = gcc_major_ul;
+    gcc_minor = gcc_minor_ul;
+    gcc_patchlevel = gcc_patchlevel_ul;
+
+    return next;
+}
+
 static char **handle_switch_g(char *arg, char **next)
 {
     if (!strcmp (arg, "gcc-base-dir"))
         return handle_base_dir(arg, next);
+    else if (!strcmp (arg, "gcc-version"))
+        return handle_gcc_version(arg, next);

     return next;
 }
diff --git a/sparse.1 b/sparse.1
index b79c587..9f2c52d 100644
--- a/sparse.1
+++ b/sparse.1
@@ -355,6 +355,13 @@ Look for system headers in the multiarch
subdirectory \fIdir\fR.
 The \fIdir\fR name would normally take the form of the target's
 normalized GNU triplet. (e.g. i386-linux-gnu).
 .
+.TP
+.B \-gcc-version \fIversion\fR
+Simulate behavior of gcc of the specified version. At this time, this
+switch only affects macros \fI__GNUC__\fR, \fI__GNUC_MINOR__\fR, and
+\fI__GNUC_PATCHLEVEL__\fR. The default value is the version of gcc that
+compiled sparse, or \fI2.95.0\fR if that information is missing.
+.
 .SH DEBUG OPTIONS
 .TP
 .B \-fdump-linearize[=only]
-- 
2.13.3


-- 
Regards,
Pavel Roskin
