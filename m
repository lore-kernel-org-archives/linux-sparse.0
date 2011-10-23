From: penberg@cs.helsinki.fi
Subject: [RFC/PATCH 1/2] sparse: Fix including glibc headers on x86-64
Date: Sun, 23 Oct 2011 15:36:59 +0300
Message-ID: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53463 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1JWMhI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 23 Oct 2011 08:37:08 -0400
Received: by bkbzt19 with SMTP id zt19so6947490bkb.19
        for <linux-sparse@vger.kernel.org>; Sun, 23 Oct 2011 05:37:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

From: Pekka Enberg <penberg@kernel.org>

Sparse treats code as 32-bit which causes problems for userspace projects on
x86-64 Fedora if you don't have the 32-bit glibc compat package installed
("glib-devel.i686"):

  $ ./sparse allocate.c
  /usr/include/gnu/stubs.h:7:12: error: unable to open 'gnu/stubs-32.h'

Fix the issue by defining relevant macros on 64-bit.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 lib.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 396e9f1..f372296 100644
--- a/lib.c
+++ b/lib.c
@@ -827,6 +827,12 @@ void create_builtin_stream(void)
 	add_pre_buffer("#weak_define __LONG_MAX__ " STRINGIFY(__LONG_MAX__) "\n");
 	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
 	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
+
+#ifdef __x86_64
+	add_pre_buffer("#weak_define x86_64 1\n");
+	add_pre_buffer("#weak_define __x86_64 1\n");
+	add_pre_buffer("#weak_define __x86_64__ 1\n");
+#endif
 }
 
 static struct symbol_list *sparse_tokenstream(struct token *token)
-- 
1.7.6.4

