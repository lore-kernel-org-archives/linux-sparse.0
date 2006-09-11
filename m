From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] sparse_error() should not silence info() after
	sparse_error()s
Date: Mon, 11 Sep 2006 14:11:27 -0700
Message-ID: <1158009087.4373.49.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:688 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965043AbWIKVLJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Sep 2006 17:11:09 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BLB8AB031622
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 17:11:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BLB8o9240774
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:11:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BLB7I4024659
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:11:07 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Adam DiCarlo <adam.dicarlo@gmail.com>

sparse_error() sets max_warnings = 0 to silence subsequent sparse_warning()s
or info()s; however, this also silences the info() after that sparse_error()
and subsequent sparse_errors() which still get shown.  bad_expr_type runs into
this problem: it reports an error with sparse_error() and then provides
further information with info(), which the user never sees.  Make info()
continue to print as long as the immediately preceeding warning or error does.

Thanks to Adam DiCarlo <adam.dicarlo@gmail.com> for reporting the problem.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
Cc: Adam DiCarlo <adam.dicarlo@gmail.com>
---
 lib.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index feb755a..05ed848 100644
--- a/lib.c
+++ b/lib.c
@@ -94,12 +94,13 @@ static void do_warn(const char *type, st
 }
 
 static int max_warnings = 100;
+static int show_info = 1;
 
 void info(struct position pos, const char * fmt, ...)
 {
 	va_list args;
 
-	if (!max_warnings)
+	if (!show_info)
 		return;
 	va_start(args, fmt);
 	do_warn("", pos, fmt, args);
@@ -110,11 +111,15 @@ void warning(struct position pos, const 
 {
 	va_list args;
 
-	if (!max_warnings)
+	if (!max_warnings) {
+		show_info = 0;
 		return;
+	}
 
-	if (!--max_warnings)
+	if (!--max_warnings) {
+		show_info = 0;
 		fmt = "too many warnings";
+	}
 
 	va_start(args, fmt);
 	do_warn("warning: ", pos, fmt, args);
@@ -126,10 +131,12 @@ void sparse_error(struct position pos, c
 	static int errors = 0;
 	va_list args;
         die_if_error = 1;
+	show_info = 1;
 	/* Shut up warnings after an error */
 	max_warnings = 0;
 	if (errors > 100) {
 		static int once = 0;
+		show_info = 0;
 		if (once)
 			return;
 		fmt = "too many errors";
