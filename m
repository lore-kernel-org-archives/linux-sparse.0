From: Jeff Layton <jlayton@primarydata.com>
Subject: [PATCH v2] sparse: make bits_to_bytes round up instead of down
Date: Wed, 16 Jul 2014 12:27:42 -0400
Message-ID: <1405528062-588-1-git-send-email-jlayton@primarydata.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:55439 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965386AbaGPQ1s (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Jul 2014 12:27:48 -0400
Received: by mail-qc0-f178.google.com with SMTP id x3so976313qcv.37
        for <linux-sparse@vger.kernel.org>; Wed, 16 Jul 2014 09:27:47 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>

Currently, sparse handles arrays of bools incorrectly. If you declare an
array of bools like this:

    static _Bool boolarray[3] = {
        [0] = 1,
        [1] = 1,
    };

...you get warnings like this (which are bogus):

    ./test.c:2:10: warning: Initializer entry defined twice
    ./test.c:3:10:   also defined here

The problem is that bits_to_bytes rounds down instead of up, and sparse
defaults to _Bool being only 1 bit in size. This causes sparse to think
that they sit within the same byte, when they do not.

Fix bits_to_bytes to round up instead of down, and fix the call in
init_ctype to no longer correct for it. Also add a validation
test to ensure that we don't break this in the future.

Signed-off-by: Jeff Layton <jlayton@primarydata.com>
---
 symbol.c                                     |  2 +-
 target.h                                     |  2 +-
 validation/initializer-entry-defined-twice.c | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/symbol.c b/symbol.c
index eb6e1215ee87..f02e07bd8c59 100644
--- a/symbol.c
+++ b/symbol.c
@@ -888,7 +888,7 @@ void init_ctype(void)
 		struct symbol *sym = ctype->ptr;
 		unsigned long bit_size = ctype->bit_size ? *ctype->bit_size : -1;
 		unsigned long maxalign = ctype->maxalign ? *ctype->maxalign : 0;
-		unsigned long alignment = bits_to_bytes(bit_size + bits_in_char - 1);
+		unsigned long alignment = bits_to_bytes(bit_size);
 
 		if (alignment > maxalign)
 			alignment = maxalign;
diff --git a/target.h b/target.h
index 1030c7c38993..140df3c1a64d 100644
--- a/target.h
+++ b/target.h
@@ -49,7 +49,7 @@ extern int enum_alignment;
 
 static inline int bits_to_bytes(int bits)
 {
-	return bits >= 0 ? bits / bits_in_char : -1;
+	return bits >= 0 ? (bits + bits_in_char - 1) / bits_in_char : -1;
 }
 
 static inline int bytes_to_bits(int bytes)
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
-- 
1.9.3

