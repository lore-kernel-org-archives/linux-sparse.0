From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sparse: minor manpage corrections
Date: Sat, 20 Jan 2018 15:48:58 -0800
Message-ID: <8f4eac6f-fe62-8238-0e89-fe117131b921@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45365 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeATXtF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 18:49:05 -0500
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix some man page typos, punctuation, and grammar.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Triplett <josh@joshtriplett.org>
---
 sparse.1 |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- sprs-2018-0119.orig/sparse.1
+++ sprs-2018-0119/sparse.1
@@ -56,7 +56,7 @@ arithmetic operations other than bitwise
 one restricted type into another, except via a cast that includes
 \fB__attribute__((force))\fR.
 
-__bitwise ends up being a "stronger integer separation". That one
+__bitwise ends up being a "stronger integer separation", one that
 doesn't allow you to mix with non-bitwise integers, so now it's much
 harder to lose the type by mistake.
 
@@ -204,7 +204,7 @@ Sparse issues these warnings by default.
 .B \-Winit\-cstring
 Warn about initialization of a char array with a too long constant C string.
 
-If the size of the char array and the length of the string is the same,
+If the size of the char array and the length of the string are the same,
 there is no space for the last nul char of the string in the array:
 
 .nf
@@ -348,7 +348,7 @@ Warn about preprocessor conditionals tha
 preprocessor symbol.
 
 Standard C (C99 6.10.1) permits using the value of an undefined preprocessor
-symbol in preprocessor conditionals, and specifies it has have a value of 0.
+symbol in preprocessor conditionals, and specifies it has a value of 0.
 However, this behavior can lead to subtle errors.
 
 Sparse does not issue these warnings by default.
@@ -368,7 +368,7 @@ normalized GNU triplet. (e.g. i386-linux
 .TP
 .B \-fdump-linearize[=only]
 Dump the IR code of a function directly after its linearization,
-before any simplifications is made. If the argument \fB=only\fR is
+before any simplifications are made. If the argument \fB=only\fR is
 also given no further processing is done on the function.
 .
 .B \-fmem-report

