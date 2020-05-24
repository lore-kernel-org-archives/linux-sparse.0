From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add an option to suppress warning no 'newline at EOF'
Date: Sun, 24 May 2020 16:00:57 +0200
Message-ID: <20200524140057.5927-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgEXOBG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 24 May 2020 10:01:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5CC061A0E
        for <linux-sparse@vger.kernel.org>; Sun, 24 May 2020 07:01:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id yc10so17958563ejb.12
        for <linux-sparse@vger.kernel.org>; Sun, 24 May 2020 07:01:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some platforms have some of their systems header files which
are missing the ending newline. Sparse will then warn about
the missng newline, again and again, and more important warnings
can easily be lost in the noise.

So, add an option flag '-W[no-]newline-eof' to conditionalize
this warning.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c      | 2 ++
 lib.h      | 1 +
 sparse.1   | 7 +++++++
 tokenize.c | 2 +-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 9ee8d3cf6b21..7aca9cd0ac40 100644
--- a/lib.c
+++ b/lib.c
@@ -272,6 +272,7 @@ int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
 int Wsparse_error = 0;
 int Wmemcpy_max_count = 1;
+int Wnewline_eof = 1;
 int Wnon_pointer_null = 1;
 int Wold_initializer = 1;
 int Wold_style_definition = 1;
@@ -761,6 +762,7 @@ static const struct flag warnings[] = {
 	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
 	{ "memcpy-max-count", &Wmemcpy_max_count },
 	{ "non-pointer-null", &Wnon_pointer_null },
+	{ "newline-eof", &Wnewline_eof },
 	{ "old-initializer", &Wold_initializer },
 	{ "old-style-definition", &Wold_style_definition },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
diff --git a/lib.h b/lib.h
index 5e6db111170a..e767840c1038 100644
--- a/lib.h
+++ b/lib.h
@@ -161,6 +161,7 @@ extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
 extern int Wmemcpy_max_count;
+extern int Wnewline_eof;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
 extern int Wold_style_definition;
diff --git a/sparse.1 b/sparse.1
index 50e928392573..63b408e3aa5a 100644
--- a/sparse.1
+++ b/sparse.1
@@ -280,6 +280,13 @@ The limit can be changed with \fB\-fmemcpy\-max\-count=COUNT\fR,
 the default being \fB100000\fR.
 .
 .TP
+.B \-Wnewline\-eof
+Warn if the input file doesn't end with a newline.
+
+Sparse issues these warnings by default.  To turn them off, use
+\fB\-Wno\-newline\-eof\fR.
+.
+.TP
 .B \-Wnon\-pointer\-null
 Warn about the use of 0 as a NULL pointer.
 
diff --git a/tokenize.c b/tokenize.c
index d8bbef498a46..d3371e1e7cb1 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -411,7 +411,7 @@ got_eof:
 		c = '\\';
 		goto out;
 	}
-	if (stream->pos)
+	if (stream->pos & Wnewline_eof)
 		warning(stream_pos(stream), "no newline at end of file");
 	else if (spliced)
 		warning(stream_pos(stream), "backslash-newline at end of file");
-- 
2.26.2
