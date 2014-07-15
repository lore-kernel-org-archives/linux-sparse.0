From: Jeff Layton <jlayton@primarydata.com>
Subject: [sparse PATCH RFC] Revert "Revert "sparse: Bump up sizeof(_Bool) to 8 bits""
Date: Tue, 15 Jul 2014 11:46:40 -0400
Message-ID: <1405439200-27515-1-git-send-email-jlayton@primarydata.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:37974 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaGOPqr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jul 2014 11:46:47 -0400
Received: by mail-qg0-f42.google.com with SMTP id j5so883448qga.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Jul 2014 08:46:46 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>

This reverts commit 65be24b8ddf54164ff25febfd3d5f9c26ae3877d.
bits_in_bool was originally set to 1 bit, and then was reset to 8 to
work around some issues with LLVM. Once those were resolved it was
apparently set back to being 1 bit.

The problem here is that, at least with GCC on x86_64, a _Bool always
seems to be end up being 8 bits (which makes sense -- how would you get
a pointer to it otherwise?). If you declare and initialize an array like
this:

    static _Bool boolarray[3] = {
            [0] = 1,
            [1] = 1,
    };

...you get warnings like this (which are bogus):

    ./test.c:2:10: warning: Initializer entry defined twice
    ./test.c:3:10:   also defined here

The bits_to_bytes conversion ends up wrong because it relies on
integer division, and that causes the above bogus warning.

Reset it back to 8 bits, and add a validation test that creates the
above array to ensure that we don't end up breaking it again.

Cc: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Jeff Layton <jlayton@primarydata.com>
---
 target.c                                     |  2 +-
 validation/initializer-entry-defined-twice.c | 10 ++++++++++
 validation/sizeof-bool.c                     |  6 +-----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/target.c b/target.c
index 17b228ae924c..6a535bc0b2d7 100644
--- a/target.c
+++ b/target.c
@@ -14,7 +14,7 @@ int max_alignment = 16;
 /*
  * Integer data types
  */
-int bits_in_bool = 1;
+int bits_in_bool = 8;
 int bits_in_char = 8;
 int bits_in_short = 16;
 int bits_in_int = 32;
diff --git a/validation/initializer-entry-defined-twice.c b/validation/initializer-entry-defined-twice.c
index 968e3dd1af2a..8a5bd3a95631 100644
--- a/validation/initializer-entry-defined-twice.c
+++ b/validation/initializer-entry-defined-twice.c
@@ -41,6 +41,16 @@ static struct same_offset not_an_error = {
 	.field1 = { },
 	.field2 = 0
 };
+
+/*
+ * _Bools generally take a whole byte, so ensure that we can initialize
+ * them without spewing a warning.
+ */
+static _Bool boolarray[3] = {
+	[0] = 1,
+	[1] = 1,
+};
+
 /*
  * check-name: Initializer entry defined twice
  *
diff --git a/validation/sizeof-bool.c b/validation/sizeof-bool.c
index 6c68748a0b3f..71ae1bce3699 100644
--- a/validation/sizeof-bool.c
+++ b/validation/sizeof-bool.c
@@ -4,9 +4,5 @@ static int a(void)
 }
 /*
  * check-name: sizeof(_Bool) is valid
- * check-description: sizeof(_Bool) was rejected because _Bool is not an even
- * number of bytes
- * check-error-start
-sizeof-bool.c:3:16: warning: expression using sizeof bool
- * check-error-end
+ * check-description: sizeof(_Bool) is valid
  */
-- 
1.9.3

