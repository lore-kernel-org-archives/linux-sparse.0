From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 1/2] sparse, llvm: Make 'sparsec' error handling more robust
Date: Fri, 18 Nov 2011 17:30:58 +0200
Message-ID: <1321630259-2213-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56579 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757808Ab1KRPbU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Nov 2011 10:31:20 -0500
Received: by bke11 with SMTP id 11so3557738bke.19
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2011 07:31:18 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

Make 'sparsec' more robust against SIGSEGV in Sparse/LLVM code so that 'make
check' detects test breakage.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparsec |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sparsec b/sparsec
index 1e5c8bd..33e1a2b 100755
--- a/sparsec
+++ b/sparsec
@@ -2,6 +2,8 @@
 #
 # GCC compatible C compiler based on Sparse LLVM
 
+set +e
+
 SPARSEOPTS=""
 DIRNAME=`dirname $0`
 
@@ -27,9 +29,12 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
+TMPLLVM=`mktemp -t tmp.XXXXXX`".llvm"
 TMPFILE=`mktemp -t tmp.XXXXXX`".o"
 
-$DIRNAME/sparse-llvm $SPARSEOPTS | llc | as -o $TMPFILE
+$DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
+
+llc $TMPLLVM | as -o $TMPFILE
 
 if [ $NEED_LINK -eq 1 ]; then
 	if [ -z $OUTFILE ]; then
@@ -43,3 +48,5 @@ else
 	fi
 	mv $TMPFILE $OUTFILE
 fi
+
+rm -f $TMPLLVM
-- 
1.7.6.4

