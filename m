From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: add script to display the deserialized LLVM IR
Date: Sat, 11 Mar 2017 12:58:13 +0100
Message-ID: <20170311115813.23249-1-luc.vanoostenryck@gmail.com>
References: <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35858 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753959AbdCKL62 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 06:58:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id v190so2756808wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 03:58:27 -0800 (PST)
In-Reply-To: <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal is to use this in some of test cases, by comparing
the expected output with the actual one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm-dis | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100755 sparse-llvm-dis

diff --git a/sparse-llvm-dis b/sparse-llvm-dis
new file mode 100755
index 000000000..573f8bbd0
--- /dev/null
+++ b/sparse-llvm-dis
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+set +e
+
+DIRNAME=`dirname $0`
+DIS=`"${LLVM_CONFIG:-llvm-config}" --bindir`/llvm-dis
+
+if [ $# -eq 0 ]; then
+  echo "`basename $0`: no input files"
+  exit 1
+fi
+
+$DIRNAME/sparse-llvm $@ | $DIS
-- 
2.11.1

