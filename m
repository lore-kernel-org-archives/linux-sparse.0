From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 4/6] Avoid use of libc headers in the validation suite
Date: Thu, 28 Jun 2007 01:40:09 -0400
Message-ID: <20070628054009.30704.18718.stgit@dv.roinet.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:38933 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988AbXF1FkK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:40:10 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3mji-0008L7-DB
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:10 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1I3mjh-00080L-Qn
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:09 -0400
In-Reply-To: <20070628053954.30704.66440.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

We don't want libc to affect the validation suite.  Compatibility with
libc headers can be checked by other means, e.g. by compiling some
significant program (even sparse itself) using cgcc as the compiler.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 validation/check_byte_count-ice.c |    2 +-
 validation/double-semicolon.c     |    2 +-
 validation/test-be.c              |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/validation/check_byte_count-ice.c b/validation/check_byte_count-ice.c
index eaeef96..e58312d 100644
--- a/validation/check_byte_count-ice.c
+++ b/validation/check_byte_count-ice.c
@@ -1,4 +1,4 @@
-#include <string.h>
+extern void *memset (void *s, int c, int n);
 
 static void foo(void *a)
 {
diff --git a/validation/double-semicolon.c b/validation/double-semicolon.c
index 039236f..36cb332 100644
--- a/validation/double-semicolon.c
+++ b/validation/double-semicolon.c
@@ -1,4 +1,4 @@
-#include <string.h>
+extern void *memset (void *s, int c, int n);
 static void test(void)
 {
 	struct { int foo;; } val;
diff --git a/validation/test-be.c b/validation/test-be.c
index 6dfa55f..6b74555 100644
--- a/validation/test-be.c
+++ b/validation/test-be.c
@@ -1,5 +1,5 @@
-#include <stdio.h>
-#include <stdlib.h>
+int printf(char *c, ...);
+void exit(int c);
 
 #undef PRINT_OUTPUTS
 
