From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] pre-process: fix a compiler array subscript type warning
Date: Fri, 5 Jun 2020 22:29:24 +0100
Message-ID: <fbb9ba2b-14fa-c6e1-a730-80d35547ea52@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:58133 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgFEV33 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 5 Jun 2020 17:29:29 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


On cygwin, the <ctype.h> header is written in such a way as to cause
a gcc compiler warning if a plain 'char' is passed to the character
classification macros (in this case isdigit). The result is defined
only if the parameter is representable as an unsigned char, or if it
is EOF.

When passing a 'char' type argument to isdigit(), the compiler warns
like so:

    CC      pre-process.o
  In file included from pre-process.c:33:
  pre-process.c: In function ‘predefine’:
  pre-process.c:1429:18: warning: array subscript has type ‘char’ [-Wchar-subscripts]
   1429 |   if (isdigit(buf[0])) {
        |               ~~~^~~

In order to suppress the warning, cast the argument of isdigit() to
an 'unsigned char' type.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Luc,

Having not done so in a while, last night I updated my cygwin
installation. This resulted in updates to the versions of the
libc/headers/gcc, among other things. (eg. gcc is now v9.3.0).

This patch fixes the new compiler warning that results!

ATB,
Ramsay Jones

 pre-process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pre-process.c b/pre-process.c
index c8725dc8..d96035e2 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1426,7 +1426,7 @@ void predefine(const char *name, int weak, const char *fmt, ...)
 		va_end(ap);
 
 		value = __alloc_token(0);
-		if (isdigit(buf[0])) {
+		if (isdigit((unsigned char)buf[0])) {
 			token_type(value) = TOKEN_NUMBER;
 			value->number = xstrdup(buf);
 		} else {
-- 
2.27.0
