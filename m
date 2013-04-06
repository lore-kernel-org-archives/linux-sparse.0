From: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 1/3] Warn about initialization of a char array with a too long constant C string.
Date: Sun,  7 Apr 2013 01:58:55 +0900
Message-ID: <1365267537-3787-1-git-send-email-yamato@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from h219-110-095-248.catv01.itscom.jp ([219.110.95.248]:53280 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751663Ab3DFRLd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Apr 2013 13:11:33 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: yamato@redhat.com

This patch adds new option -Winit-cstring to sparse.

With the option sparse can Warn about initialization of a char array
with a too long constant C string.  If the size of the char array and
the length of the string is the same, there is no space for the last
nul char of the string in the array.

              char s[3] = "abc";

If the array is used as just a byte array, not as C string, this
warning is just noise. However, if the array is passed to functions
dealing with C string like printf(%s) and strcmp, it may cause a
trouble.

Here is a example of such trouble:
     http://www.spinics.net/lists/netdev/msg229765.html
     http://www.spinics.net/lists/netdev/msg229870.html

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 evaluate.c | 12 ++++++++----
 lib.c      |  2 ++
 lib.h      |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index d09f271..9f2c4ac 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2592,10 +2592,14 @@ String:
 	p = alloc_expression(e->pos, EXPR_STRING);
 	*p = *e;
 	type = evaluate_expression(p);
-	if (ctype->bit_size != -1 &&
-	    ctype->bit_size + bits_in_char < type->bit_size) {
-		warning(e->pos,
-			"too long initializer-string for array of char");
+	if (ctype->bit_size != -1) {
+		if (ctype->bit_size + bits_in_char < type->bit_size)
+			warning(e->pos,
+				"too long initializer-string for array of char");
+		else if (Winit_cstring && ctype->bit_size + bits_in_char == type->bit_size) {
+			warning(e->pos,
+				"too long initializer-string for array of char(no space for nul char)");
+		}
 	}
 	*ep = p;
 	return 1;
diff --git a/lib.c b/lib.c
index 4f69e11..7c44414 100644
--- a/lib.c
+++ b/lib.c
@@ -199,6 +199,7 @@ int Wdecl = 1;
 int Wdefault_bitfield_sign = 0;
 int Wdesignated_init = 1;
 int Wdo_while = 0;
+int Winit_cstring = 0;
 int Wenum_mismatch = 1;
 int Wnon_pointer_null = 1;
 int Wold_initializer = 1;
@@ -410,6 +411,7 @@ static const struct warning {
 	{ "designated-init", &Wdesignated_init },
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
+	{ "init-cstring", &Winit_cstring },
 	{ "non-pointer-null", &Wnon_pointer_null },
 	{ "old-initializer", &Wold_initializer },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
diff --git a/lib.h b/lib.h
index ee954fe..1227de9 100644
--- a/lib.h
+++ b/lib.h
@@ -95,6 +95,7 @@ extern int Wdefault_bitfield_sign;
 extern int Wdesignated_init;
 extern int Wdo_while;
 extern int Wenum_mismatch;
+extern int Winit_cstring;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
 extern int Wone_bit_signed_bitfield;
-- 
1.7.11.7

