From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: [PATCH] sparse{i,c}: use LLVM_CONFIG to find llc and lli
Date: Tue, 15 Apr 2014 12:51:29 -0700
Message-ID: <1397591489-17411-1-git-send-email-cody@linux.vnet.ibm.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:54789 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbaDOTwS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Apr 2014 15:52:18 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <cody@linux.vnet.ibm.com>;
	Tue, 15 Apr 2014 15:52:17 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 01CF438C801A
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 15:52:15 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3FJqEri64094212
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 19:52:14 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3FJqE2Q026169
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 15:52:14 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>

Some systems have multiple llvm versions installed, and have prefixed
executables ("<exec>-<version>"). While we could require the user to
specify a variable for each executable (LLC, LLI), using llvm-config
--bindir to locate them and allowing them to override using LLVM_CONFIG
makes much less work.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 sparsec | 6 +++++-
 sparsei | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sparsec b/sparsec
index 9c90b30..f8e7256 100755
--- a/sparsec
+++ b/sparsec
@@ -34,7 +34,11 @@ TMPFILE=`mktemp -t tmp.XXXXXX`".o"
 
 $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
 
-llc -o - $TMPLLVM | as -o $TMPFILE
+if [ -z "$LLVM_CONFIG" ]; then
+  LLVM_CONFIG=llvm-config
+fi
+
+`"$LLVM_CONFIG" --bindir`/llc -o - $TMPLLVM | as -o $TMPFILE
 
 if [ $NEED_LINK -eq 1 ]; then
 	if [ -z $OUTFILE ]; then
diff --git a/sparsei b/sparsei
index 4632154..7a2e0f1 100755
--- a/sparsei
+++ b/sparsei
@@ -3,7 +3,10 @@
 set +e
 
 DIRNAME=`dirname $0`
-LLI=`llvm-config --bindir`/lli
+if [ -z "$LLVM_CONFIG" ]; then
+    LLVM_CONFIG=llvm-config
+fi
+LLI=`"$LLVM_CONFIG" --bindir`/lli
 
 if [ $# -eq 0 ]; then
   echo "`basename $0`: no input files"
-- 
1.9.2

