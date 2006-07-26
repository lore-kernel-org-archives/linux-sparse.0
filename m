From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Add support for GCC's __builtin_va_copy
Date: Wed, 26 Jul 2006 11:18:34 -0700
Message-ID: <1153937914.12517.55.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:29105 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751738AbWGZSSd
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Jul 2006 14:18:33 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6QIIWa3010539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 14:18:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6QIIWUk274984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 12:18:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6QIIWv6019669
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 12:18:32 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6QIIVE9019655
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 12:18:31 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Sparse already supports __builtin_va_{start,arg,end} and various others,
but not __builtin_va_copy.

 lib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index ad19696..1e921d3 100644
--- a/lib.c
+++ b/lib.c
@@ -490,6 +490,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#define __builtin_va_arg(arg,type)  ({ type __va_arg_ret = *(type *)(arg); arg += sizeof(type); __va_arg_ret; })\n");
 	add_pre_buffer("#define __builtin_va_alist (*(void *)0)\n");
 	add_pre_buffer("#define __builtin_va_arg_incr(x) ((x) + 1)\n");
+	add_pre_buffer("#define __builtin_va_copy(dest, src) ({ dest = src; (void)0; })\n");
 	add_pre_buffer("#define __builtin_va_end(arg)\n");
 	add_pre_buffer("#define __builtin_offsetof(type, name) ((__SIZE_TYPE__)&((type *)(0ul))->name)\n");
 
