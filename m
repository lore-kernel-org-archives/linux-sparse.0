From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] Add support for GCC's __builtin_extract_return_addr
	function.
Date: Tue, 29 Aug 2006 17:40:46 -0700
Message-ID: <1156898446.5203.3.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:11686 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751454AbWH3Akl
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Aug 2006 20:40:41 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U0ee3l011829
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 20:40:40 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7U0edea274824
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:40:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7U0edH5009500
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:40:39 -0600
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
index feb755a..023036d 100644
--- a/lib.c
+++ b/lib.c
@@ -465,6 +465,7 @@ void declare_builtin_functions(void)
 
 	/* And some random ones.. */
 	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
+	add_pre_buffer("extern void *__builtin_extract_return_addr(void *);\n");
 	add_pre_buffer("extern void *__builtin_frame_address(unsigned int);\n");
 	add_pre_buffer("extern void __builtin_trap(void);\n");
 	add_pre_buffer("extern int __builtin_ffs(int);\n");
-- 
1.4.1.1
