From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/5] Makefile: suppress error message from shell
Date: Sat, 18 Jul 2009 21:42:56 +0100
Message-ID: <4A6233D0.1060502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:41476 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744AbZGRVJ6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:09:58 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


In particular, on systems which do not have 'pkg-config' installed,
every invocation of make issues the following message:

    /bin/sh: pkg-config: command not found

Suppress the message by redirecting stderr to the bit-bucket.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 72f3686..70ccbc9 100644
--- a/Makefile
+++ b/Makefile
@@ -15,7 +15,7 @@ AR = ar
 #     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 #
 
-HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
+HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 2>/dev/null && echo 'yes')
 HAVE_GCC_DEP=$(shell touch .gcc-test.c && 				\
 		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
 		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
-- 
1.6.3.1


