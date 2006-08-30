From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] Add support for GCC's __builtin_va_copy
Date: Tue, 29 Aug 2006 17:41:19 -0700
Message-ID: <1156898479.5203.5.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:21672 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751472AbWH3AlN
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Aug 2006 20:41:13 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U0fCbQ012490
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 20:41:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7U0fChr283706
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:41:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7U0fCm3010470
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:41:12 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Recent versions of Linux started using this extension, so sparse needs
this fix to avoid parse errors.

 lib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index feb755a..bb2da7b 100644
--- a/lib.c
+++ b/lib.c
@@ -492,6 +492,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#define __builtin_va_arg(arg,type)  ({ type __va_arg_ret = *(type *)(arg); arg += sizeof(type); __va_arg_ret; })\n");
 	add_pre_buffer("#define __builtin_va_alist (*(void *)0)\n");
 	add_pre_buffer("#define __builtin_va_arg_incr(x) ((x) + 1)\n");
+	add_pre_buffer("#define __builtin_va_copy(dest, src) ({ dest = src; (void)0; })\n");
 	add_pre_buffer("#define __builtin_va_end(arg)\n");
 	add_pre_buffer("#define __builtin_offsetof(type, name) ((__SIZE_TYPE__)&((type *)(0ul))->name)\n");
 
-- 
1.4.1.1
