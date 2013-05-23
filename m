From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Thu, 23 May 2013 08:28:02 -0700
Message-ID: <519E3582.7060704@gmail.com>
References: <5195370B.9080702@ramsay1.demon.co.uk> <51972FDB.6060201@chrisli.org> <5197387E.5030000@gmail.com> <519A6EAD.8070700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050800080209080905070203"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:46228 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759661Ab3EWP2K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 May 2013 11:28:10 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so3036310pbb.10
        for <linux-sparse@vger.kernel.org>; Thu, 23 May 2013 08:28:09 -0700 (PDT)
In-Reply-To: <519A6EAD.8070700@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050800080209080905070203
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 05/20/2013 11:42 AM, Ramsay Jones wrote:

> Unfortunately not. :(

Sorry about that.

>         const char *paths[] = { path, NULL };

I see where I make the mistake. I need to drop the parentheses
only for char type. Can you please try this patch again? It is a
replacement patch of your patch No3. Not a delta. It works for the
the test case above.

Let's hope this one works.

Chris


--------------050800080209080905070203
Content-Type: text/x-patch;
 name="0001-symbol.c-Set-correct-size-of-array-from-parenthesize.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-symbol.c-Set-correct-size-of-array-from-parenthesize.pa";
 filename*1="tch"

From 5a3bd40c1e9976c0896ad2d198e202a515dcf194 Mon Sep 17 00:00:00 2001
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Thu, 16 May 2013 20:44:11 +0100
Subject: [PATCH] symbol.c: Set correct size of array from parenthesized string
 initializer

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 symbol.c                      | 30 ++++++++++++++++++++++++++----
 validation/init-char-array1.c | 27 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)
 create mode 100644 validation/init-char-array1.c

diff --git a/symbol.c b/symbol.c
index 80a2f23..2ec6200 100644
--- a/symbol.c
+++ b/symbol.c
@@ -296,9 +296,21 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 				if (entry->idx_to >= nr)
 					nr = entry->idx_to+1;
 				break;
+			case EXPR_PREOP: {
+				struct expression *e = entry;
+				if (is_char) {
+					while (e && e->type == EXPR_PREOP && e->op == '(')
+						e = e->unop;
+					if (e && e->type == EXPR_STRING) {
+						entry = e;
 			case EXPR_STRING:
-				if (is_char)
-					str_len = entry->string->length;
+						if (is_char)
+							str_len = entry->string->length;
+					}
+
+
+				}
+			}
 			default:
 				nr++;
 			}
@@ -307,9 +319,19 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 			nr = str_len;
 		break;
 	}
+	case EXPR_PREOP:
+		if (is_char) { 
+			struct expression *e = expr;
+			while (e && e->type == EXPR_PREOP && e->op == '(')
+				e = e->unop;
+			if (e && e->type == EXPR_STRING) {
+				expr = e;
 	case EXPR_STRING:
-		if (is_char)
-			nr = expr->string->length;
+				if (is_char)
+					nr = expr->string->length;
+			}
+		}
+		break;
 	default:
 		break;
 	}
diff --git a/validation/init-char-array1.c b/validation/init-char-array1.c
new file mode 100644
index 0000000..24fd8d8
--- /dev/null
+++ b/validation/init-char-array1.c
@@ -0,0 +1,27 @@
+/*
+ * for array of char, ("...") as the initializer is an gcc language
+ * extension. check that a parenthesized string initializer is handled
+ * correctly and that -Wparen-string warns about it's use.
+ */
+static const char u[] = ("hello");
+static const char v[] = {"hello"};
+static const char v1[] = {("hello")};
+static const char w[] = "hello";
+static const char x[5] = "hello";
+
+static void f(void)
+{
+	char a[1/(sizeof(u) == 6)];
+	char b[1/(sizeof(v) == 6)];
+	char c[1/(sizeof(w) == 6)];
+	char d[1/(sizeof(x) == 5)];
+}
+/*
+ * check-name: parenthesized string initializer
+ * check-command: sparse -Wparen-string $file
+ *
+ * check-error-start
+init-char-array1.c:6:26: warning: array initialized from parenthesized string constant
+init-char-array1.c:8:28: warning: array initialized from parenthesized string constant
+ * check-error-end
+ */
-- 
1.8.1.4


--------------050800080209080905070203--
