From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] lib: workaround the 'redeclared with different type'
 errors
Date: Wed, 19 Jul 2017 21:05:18 +0100
Message-ID: <74a1852c-a9ef-ec91-d9da-925c7e8def94@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:35219 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbdGSUFV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 16:05:21 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>


The 'selfcheck' make target issues sparse errors for function symbols
'error_die' and 'die', like so:

       CHECK    lib.c
  lib.c:194:6: error: symbol 'error_die' redeclared with different type \
	(originally declared at lib.h:98) - different modifiers
  lib.c:203:6: error: symbol 'die' redeclared with different type \
	(originally declared at lib.h:94) - different modifiers

This is caused by the 'noreturn' attribute being treated similar to a
type qualifier and insisting that, not only the declaration and the
definition of the function have the 'noreturn', but that they have the
attribute in the same position.

In order to suppress the error, move the attribute(s) to the beginning
of the declaration, in the header file, and add an 'noreturn' attribute
at the beginning of the definition (in lib.c).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Chris,

I meant to send this yesterday, but I got busy with something else. :(
This is the 'workaround' that I have used on git to suppress these
errors (except for the regex example, which is in _imported_ code).
As I said, this also happens with the 'pure' attribute.

ATB,
Ramsay Jones

 lib.c | 2 ++
 lib.h | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index ce66a81..73e9a2f 100644
--- a/lib.c
+++ b/lib.c
@@ -191,6 +191,7 @@ void expression_error(struct expression *expr, const char *fmt, ...)
 	expr->ctype = &bad_ctype;
 }
 
+NORETURN_ATTR
 void error_die(struct position pos, const char * fmt, ...)
 {
 	va_list args;
@@ -200,6 +201,7 @@ void error_die(struct position pos, const char * fmt, ...)
 	exit(1);
 }
 
+NORETURN_ATTR
 void die(const char *fmt, ...)
 {
 	va_list args;
diff --git a/lib.h b/lib.h
index c90e0e3..307ccae 100644
--- a/lib.h
+++ b/lib.h
@@ -91,11 +91,16 @@ struct token *expect(struct token *, int, const char *);
 #define NORETURN_ATTR
 #define SENTINEL_ATTR
 #endif
-extern void die(const char *, ...) FORMAT_ATTR(1) NORETURN_ATTR;
+
+FORMAT_ATTR(1) NORETURN_ATTR
+extern void die(const char *, ...);
+
+FORMAT_ATTR(2) NORETURN_ATTR
+extern void error_die(struct position, const char *, ...);
+
 extern void info(struct position, const char *, ...) FORMAT_ATTR(2);
 extern void warning(struct position, const char *, ...) FORMAT_ATTR(2);
 extern void sparse_error(struct position, const char *, ...) FORMAT_ATTR(2);
-extern void error_die(struct position, const char *, ...) FORMAT_ATTR(2) NORETURN_ATTR;
 extern void expression_error(struct expression *, const char *, ...) FORMAT_ATTR(2);
 
 #define	ERROR_CURR_PHASE	(1 << 0)
-- 
2.13.0
