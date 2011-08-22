From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 5/5] sparse: Add end-to-end compiler shell script
Date: Mon, 22 Aug 2011 16:57:31 +0300
Message-ID: <1314021451-24808-5-git-send-email-penberg@kernel.org>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:59166 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab1HVN5f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 09:57:35 -0400
In-Reply-To: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch adds a 'kcc' shell script that combines the sparse's i386 backend
with GCC and GNU assembler to make it easier for people to find bugs in sparse.
You can, for example, attempt to build sparse with itself and see it crash and
burn:

  make && find . -name "*.o" | xargs rm
  make CC=./kcc
       CC       test-lexing.o
  FIXME! no value for symbol preprocess_only.  creating pseudo 1 (stack offset 4)
  {standard input}: Assembler messages:
  {standard input}:79: Error: operand type mismatch for `mov'
  make: *** [test-lexing.o] Error 1

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 kcc |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 kcc

diff --git a/kcc b/kcc
new file mode 100755
index 0000000..7f275a9
--- /dev/null
+++ b/kcc
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# GCC compatible C compiler based on Sparse
+
+SPARSEOPTS=""
+ASOPTS=""
+DIRNAME=`dirname $0`
+
+use_gcc=1
+
+while [ $# -gt 0 ]; do
+	case $1 in
+	'-o')
+		ASOPTS=$ASOPTS"-o "$2" "
+		shift
+		;;
+	'-c')
+		use_gcc=0
+		;;
+	*)
+		SPARSEOPTS="$SPARSEOPTS $1 " ;;
+	esac
+	shift
+done
+
+if [ $use_gcc -eq 1 ]; then
+	gcc $ASOPTS $SPARSEOPTS
+
+else
+	$DIRNAME/compile $SPARSEOPTS | as $ASOPTS
+fi
-- 
1.7.4.1

