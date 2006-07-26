From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Add support for GCC's __builtin_extract_return_addr
	function.
Date: Wed, 26 Jul 2006 10:29:53 -0700
Message-ID: <1153934993.12517.52.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:63192 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751721AbWGZR3v
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Jul 2006 13:29:51 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6QHTouu027900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 13:29:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6QHTo0V170316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 11:29:50 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6QHToUb001797
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 11:29:50 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6QHTnMw001781
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 11:29:50 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Needed to avoid several sparse errors when checking recent Linux kernels
from GIT, which use this builtin in include/linux/kallsyms.h, included
from various places.

 lib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index ad19696..eba58c3 100644
--- a/lib.c
+++ b/lib.c
@@ -463,6 +463,7 @@ void declare_builtin_functions(void)
 
 	/* And some random ones.. */
 	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
+	add_pre_buffer("extern void *__builtin_extract_return_addr(void *);\n");
 	add_pre_buffer("extern void *__builtin_frame_address(unsigned int);\n");
 	add_pre_buffer("extern void __builtin_trap(void);\n");
 	add_pre_buffer("extern int __builtin_ffs(int);\n");
