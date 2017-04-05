From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] build: add missing #include "compat.h"
Date: Wed,  5 Apr 2017 03:14:53 +0200
Message-ID: <20170405011455.60222-2-luc.vanoostenryck@gmail.com>
References: <20170405011455.60222-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35948 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdDEBRF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 21:17:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so183454wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 18:17:04 -0700 (PDT)
In-Reply-To: <20170405011455.60222-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The files in compat/ didnt included "compat.h" which contains
the declarations of the functions defined there.

Fix this by adding the missing #include "compat.h".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile           | 1 +
 compat/mmap-blob.c | 1 +
 compat/strtold.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 76902b75e..e8edd95f6 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,7 @@ OS = linux
 CC = gcc
 CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
+CFLAGS += -I.
 LDFLAGS += -g
 LD = gcc
 AR = ar
diff --git a/compat/mmap-blob.c b/compat/mmap-blob.c
index 1cab4dead..79040c26e 100644
--- a/compat/mmap-blob.c
+++ b/compat/mmap-blob.c
@@ -1,3 +1,4 @@
+#include "compat.h"
 #include <sys/mman.h>
 #include <sys/types.h>
 
diff --git a/compat/strtold.c b/compat/strtold.c
index 1b6ad7d51..29e6eb73f 100644
--- a/compat/strtold.c
+++ b/compat/strtold.c
@@ -1,3 +1,4 @@
+#include "compat.h"
 #include <stdlib.h>
 
 long double string_to_ld(const char *nptr, char **endptr)
-- 
2.12.0

