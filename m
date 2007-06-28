From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 01:39:59 -0400
Message-ID: <20070628053959.30704.91680.stgit@dv.roinet.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:38927 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417AbXF1FkA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:40:00 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3mjY-0008K9-6P
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:00 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1I3mjX-0007zm-LF
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:39:59 -0400
In-Reply-To: <20070628053954.30704.66440.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Use the actual sizeof values at the compile time to describe the default
target.  If sparse is compiled on a 64-bit system, it will default to a
64-bit system now.

To force 32-bit operation on 64-bit systems, recognize -m32.  Reject
machine options other than -m32 and -m64.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 lib.c    |   13 +++++++------
 target.c |   45 +++++++++++++++++++++++++++++++--------------
 target.h |    6 ++++++
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/lib.c b/lib.c
index 7fea474..e695f1c 100644
--- a/lib.c
+++ b/lib.c
@@ -320,12 +320,13 @@ static char **handle_switch_M(char *arg, char **next)
 
 static char **handle_switch_m(char *arg, char **next)
 {
-	if (!strcmp(arg, "m64")) {
-		bits_in_long = 64;
-		max_int_alignment = 8;
-		bits_in_pointer = 64;
-		pointer_alignment = 8;
-	}
+	if (!strcmp(arg, "m32"))
+		target_set_m32();
+	else if (!strcmp(arg, "m64"))
+		target_set_m64();
+	else
+		die("unsupported machine specification: -%s", arg);
+
 	return next;
 }
 
diff --git a/target.c b/target.c
index 22e948e..1d0912d 100644
--- a/target.c
+++ b/target.c
@@ -1,4 +1,5 @@
 #include <stdio.h>
+#include <sys/param.h>
 
 #include "symbol.h"
 #include "target.h"
@@ -15,31 +16,47 @@ int max_alignment = 16;
  * Integer data types
  */
 int bits_in_bool = 1;
-int bits_in_char = 8;
-int bits_in_short = 16;
-int bits_in_int = 32;
-int bits_in_long = 32;
-int bits_in_longlong = 64;
+int bits_in_char = NBBY * sizeof(char);
+int bits_in_short = NBBY * sizeof(short);
+int bits_in_int = NBBY * sizeof(int);
+int bits_in_long = NBBY * sizeof(long);
+int bits_in_longlong = NBBY * sizeof(long long);
 
-int max_int_alignment = 4;
+int max_int_alignment = sizeof(int);
 
 /*
  * Floating point data types
  */
-int bits_in_float = 32;
-int bits_in_double = 64;
-int bits_in_longdouble = 80;
+int bits_in_float = NBBY * sizeof(float);
+int bits_in_double = NBBY * sizeof(double);
+int bits_in_longdouble = NBBY * sizeof(long double);
 
-int max_fp_alignment = 8;
+int max_fp_alignment = sizeof(double);
 
 /*
  * Pointer data type
  */
-int bits_in_pointer = 32;
-int pointer_alignment = 4;
+int bits_in_pointer = NBBY * sizeof(void *);
+int pointer_alignment = sizeof(void *);
 
 /*
  * Enum data types
  */
-int bits_in_enum = 32;
-int enum_alignment = 4;
+int bits_in_enum = NBBY * sizeof(enum {ENUM_BITS});
+int enum_alignment = sizeof(enum {ENUM_ALIGN});
+
+void target_set_m32(void)
+{
+	bits_in_long = 32;
+	max_int_alignment = 4;
+	bits_in_pointer = 32;
+	pointer_alignment = 4;
+}
+
+void target_set_m64(void)
+{
+	bits_in_long = 64;
+	max_int_alignment = 8;
+	bits_in_pointer = 64;
+	pointer_alignment = 8;
+}
diff --git a/target.h b/target.h
index 25f7948..94e182f 100644
--- a/target.h
+++ b/target.h
@@ -42,4 +42,10 @@ extern int pointer_alignment;
 extern int bits_in_enum;
 extern int enum_alignment;
 
+/*
+ * Functions
+ */
+void target_set_m32(void);
+void target_set_m64(void);
+
 #endif
