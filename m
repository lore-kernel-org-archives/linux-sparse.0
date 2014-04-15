From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse{i,c}: use LLVM_CONFIG to find llc and lli
Date: Tue, 15 Apr 2014 15:28:38 -0700
Message-ID: <CANeU7Q=Vma64-WO8yCHueU71EewOMCDUrCDmB8iuQ4XaagS8aw@mail.gmail.com>
References: <1397591489-17411-1-git-send-email-cody@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:53679 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaDOW2i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Apr 2014 18:28:38 -0400
Received: by mail-qc0-f171.google.com with SMTP id c9so11137715qcz.2
        for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 15:28:38 -0700 (PDT)
In-Reply-To: <1397591489-17411-1-git-send-email-cody@linux.vnet.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Apr 15, 2014 at 12:51 PM, Cody P Schafer
<cody@linux.vnet.ibm.com> wrote:
> Some systems have multiple llvm versions installed, and have prefixed
> executables ("<exec>-<version>"). While we could require the user to
> specify a variable for each executable (LLC, LLI), using llvm-config
> --bindir to locate them and allowing them to override using LLVM_CONFIG
> makes much less work.

How about this minor incremental patch? It will use the default variable
to make the change smaller.

Chris

diff --git a/sparsec b/sparsec
index f8e7256..9dc96c9 100755
--- a/sparsec
+++ b/sparsec
@@ -34,11 +34,9 @@ TMPFILE=`mktemp -t tmp.XXXXXX`".o"

 $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM

-if [ -z "$LLVM_CONFIG" ]; then
-  LLVM_CONFIG=llvm-config
-fi
+LLC=`"${LLVM_CONFIG:-llvm-config}" --bindir`/llc

-`"$LLVM_CONFIG" --bindir`/llc -o - $TMPLLVM | as -o $TMPFILE
+$LLC -o - $TMPLLVM | as -o $TMPFILE

 if [ $NEED_LINK -eq 1 ]; then
        if [ -z $OUTFILE ]; then
diff --git a/sparsei b/sparsei
index 7a2e0f1..3431a9f 100755
--- a/sparsei
+++ b/sparsei
@@ -3,10 +3,7 @@
 set +e

 DIRNAME=`dirname $0`
-if [ -z "$LLVM_CONFIG" ]; then
-    LLVM_CONFIG=llvm-config
-fi
-LLI=`"$LLVM_CONFIG" --bindir`/lli
+LLI=`"${LLVM_CONFIG:-llvm-config}" --bindir`/lli

 if [ $# -eq 0 ]; then
   echo "`basename $0`: no input files"
