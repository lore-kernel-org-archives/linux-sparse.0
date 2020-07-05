From: Davidson Francis <davidsondfgl@gmail.com>
Subject: [PATCH] test-inspect: reset locale after gtk_init()
Date: Sun,  5 Jul 2020 15:50:13 -0300
Message-ID: <20200705185013.8578-1-davidsondfgl@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgGESvA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 14:51:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC1C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 11:50:59 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di5so11382897qvb.11
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 11:50:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Davidson Francis <davidsondfgl@gmail.com>

The test-inspect tool uses GTK to visualize symbol nodes. It turns
out that gtk_init() implicitly sets the locale to the system locale,
and since Sparse uses strtod()/strtold() for parsing floating-point
numbers in expressions, parsing becomes locale-dependent.

Since the system's locale may be different from "C", test-inspect
may be unable to parse float numbers.

Steps to reproduce:
    $ echo "int main(void){3.14;}" > test.c
    $ LC_ALL="fr_FR.UTF-8" test-inspect test.c
Output:
    test.c:1:16: error: constant 3.14 is not a valid number

Fix this by resetting the locale right after gtk_init().

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
 test-inspect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test-inspect.c b/test-inspect.c
index 63754cb3..a59cd902 100644
--- a/test-inspect.c
+++ b/test-inspect.c
@@ -6,6 +6,7 @@
 #include <ctype.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <locale.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -31,6 +32,7 @@ int main(int argc, char **argv)
 	struct symbol_list *view_syms = NULL;
 
 	gtk_init(&argc,&argv);
+	setlocale(LC_ALL, "C");
 	expand_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR(filelist, file) {
 		struct symbol_list *syms = sparse(file);
-- 
2.11.0
