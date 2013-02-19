From: Kim Phillips <kim.phillips@freescale.com>
Subject: [PATCH] sparse: add built-in byte swap identifiers
Date: Mon, 18 Feb 2013 18:36:29 -0600
Message-ID: <20130218183629.d2a9238ac848758359582e28@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:29845
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755433Ab3BSAjn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Feb 2013 19:39:43 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

this patch stops sparse from complaining about them not being
defined:

include/uapi/linux/swab.h:60:16: error: undefined identifier '__builtin_bswap32'
include/uapi/linux/swab.h:60:33: error: not a function <noident>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
Based on:

git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

since it's more up-to-date than:

git://git.kernel.org/pub/scm/devel/sparse/sparse.git

which is what's advertised as the main sparse tree, here:

https://sparse.wiki.kernel.org/index.php/Main_Page

 lib.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib.c b/lib.c
index 6bd10d3..4f69e11 100644
--- a/lib.c
+++ b/lib.c
@@ -727,6 +727,11 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
 	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
 
+	/* And byte swaps.. */
+	add_pre_buffer("extern unsigned short __builtin_bswap16(unsigned short);\n");
+	add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
+	add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
+
 	/* And some random ones.. */
 	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
 	add_pre_buffer("extern void *__builtin_extract_return_addr(void *);\n");
-- 
1.7.9.7

