From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sparse: ignore indirect_branch attribute
Date: Tue, 13 Feb 2018 13:52:54 -0800
Message-ID: <c97d360f-a0d2-8c0d-b951-e064843ff4d8@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965843AbeBMVw4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 16:52:56 -0500
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

From: Randy Dunlap <rdunlap@infradead.org>

Teach sparse about the "indirect_branch" attribute as used in
Linux kernel:
#define __noretpoline __attribute__((indirect_branch("keep")))
and tell sparse to ignore it.

This eliminates over 148K warnings (which also cause the
0day bot to send error reports uselessly).

Or does sparse need to do something with it?

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 gcc-attr-list.h |    1 +
 1 file changed, 1 insertion(+)

--- sparse-2018-02-13.orig/gcc-attr-list.h
+++ sparse-2018-02-13/gcc-attr-list.h
@@ -62,6 +62,7 @@ GCC_ATTR(hidden)
 GCC_ATTR(hot)
 GCC_ATTR(hotpatch)
 GCC_ATTR(ifunc)
+GCC_ATTR(indirect_branch)
 GCC_ATTR(init_priority)
 GCC_ATTR(interfacearm)
 GCC_ATTR(internal)


