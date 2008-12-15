From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 07/15] OpenBSD support
Date: Mon, 15 Dec 2008 03:26:45 +0300
Message-ID: <20081215002645.16107.34273.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63676 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYLOARe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:17:34 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1154922bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:17:33 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

From: Blue Swirl <blauwirbel@gmail.com>

This patch adds OpenBSD support to sparse.

Acked-by: Christopher Li <sparse@chrisli.org>
Signed-off-by: Blue Swirl <blauwirbel@gmail.com>
---
 cgcc         |    3 +++
 compat-bsd.c |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 compat-bsd.c

diff --git a/cgcc b/cgcc
index 98686a7..cda8dab 100755
--- a/cgcc
+++ b/cgcc
@@ -221,6 +221,9 @@ sub add_specs {
     } elsif ($spec eq 'linux') {
 	return &add_specs ('unix') .
 	    ' -D__linux__=1 -D__linux=1 -Dlinux=linux';
+    } elsif ($spec eq 'openbsd') {
+	return &add_specs ('unix') .
+	    ' -D__OpenBSD__=1';
     } elsif ($spec eq 'unix') {
 	return ' -Dunix=1 -D__unix=1 -D__unix__=1';
     } elsif ( $spec =~ /^cygwin/) {
diff --git a/compat-bsd.c b/compat-bsd.c
new file mode 100644
index 0000000..4f3c8c0
--- /dev/null
+++ b/compat-bsd.c
@@ -0,0 +1,20 @@
+/*
+ * BSD Compatibility functions
+ *
+ *
+ *  Licensed under the Open Software License version 1.1
+ */
+
+#include <sys/types.h>
+#include <string.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "token.h"
+
+#include "compat/mmap-blob.c"
+
+long double string_to_ld(const char *nptr, char **endptr)
+{
+	return strtod(nptr, endptr);
+}

