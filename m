From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] sparse, llvm: 'Verify' the LLVM module before writing it
Date: Sun, 19 Aug 2012 02:50:22 +0200
Message-ID: <1345337422-22094-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:43342 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751211Ab2HSAvF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Aug 2012 20:51:05 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>

In later versions sparse-llvm should stop on wrong llvm code, instead
of outputting it, but for now there are too many warnings being produce=
d
for this to be feasible (I think).

Cc: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 sparse-llvm.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 5bcc758..e02e212 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -5,6 +5,7 @@
=20
 #include <llvm-c/Core.h>
 #include <llvm-c/BitWriter.h>
+#include <llvm-c/Analysis.h>
=20
 #include <stdbool.h>
 #include <stdio.h>
@@ -1253,6 +1254,8 @@ int main(int argc, char **argv)
 		compile(module, sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
=20
+	LLVMVerifyModule(module, LLVMPrintMessageAction, NULL);
+
 	LLVMWriteBitcodeToFD(module, STDOUT_FILENO, 0, 0);
=20
 	LLVMDisposeModule(module);
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
