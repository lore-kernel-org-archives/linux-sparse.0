From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/3] Makefile: Fix some macro redefinition warnings
Date: Thu, 16 May 2013 20:42:45 +0100
Message-ID: <519536B5.7020603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:46727 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753136Ab3EPTyL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 15:54:11 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 3140A18C6E1
	for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 20:47:32 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


In particular, gcc complains as follows:

       CC       sparse-llvm.o
  <command line>:1:1: warning: "__STDC_CONSTANT_MACROS" redefined
  <command line>:1:1: warning: this is the location of the previous definition
  <command line>:1:1: warning: "__STDC_FORMAT_MACROS" redefined
  <command line>:1:1: warning: this is the location of the previous definition
  <command line>:1:1: warning: "__STDC_LIMIT_MACROS" redefined
  <command line>:1:1: warning: this is the location of the previous definition

The warnings are caused by the macros being defined twice on the
gcc command line. These command line -D macro definitions come
originally from the output of 'llvm-config --cflags', which is
recorded in the $(LLVM_CFLAGS) variable. This variable is then
included in the $(BASIC_CFLAGS) variable twice due to duplication
of the target-specific additions to the BASIC_CFLAGS, viz:

  sparse-llvm_EXTRA_DEPS := sparse-llvm.o
  sparse-llvm.o $(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)

In order to suppress the warnings, we remove the duplication of
the sparse-llvm.o target in the above rule.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 35e3801..ba2ba85 100644
--- a/Makefile
+++ b/Makefile
@@ -90,7 +90,7 @@ LLVM_LIBS := $(shell llvm-config --libs)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm_EXTRA_DEPS := sparse-llvm.o
-sparse-llvm.o $(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)
+$(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)
 sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS)
 endif
 endif
-- 
1.8.2

