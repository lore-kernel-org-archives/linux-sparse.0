From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 22/27] llvm: give arguments a name
Date: Sat, 11 Mar 2017 10:07:01 +0100
Message-ID: <20170311090706.17171-23-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34639 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdCKJHp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:45 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so14145732wrc.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:44 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Arguments, like all LLVMValues, are given a default name
but these name are simply '%0', '%1', ... and are thus not
very readable.

Fix this by giving them an explicit name 'ARG1', ... to
match the names used in sparse's linearized code.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index bbff47877..825bd0347 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1076,6 +1076,17 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	static int nr_bb;
 
+	/* give a name to each argument */
+	for (int i = 0; i < nr_args; i++) {
+		char name[MAX_PSEUDO_NAME];
+		LLVMValueRef arg;
+
+		arg = LLVMGetParam(function.fn, i);
+		snprintf(name, sizeof(name), "ARG%d", i+1);
+		LLVMSetValueName(arg, name);
+	}
+
+	/* create the BBs */
 	FOR_EACH_PTR(ep->bbs, bb) {
 		if (bb->generation == generation)
 			continue;
-- 
2.11.1

