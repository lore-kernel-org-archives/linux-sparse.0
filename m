From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 06/51] llvm: give arguments a name
Date: Sat, 25 Mar 2017 00:20:12 +0100
Message-ID: <20170324232057.15033-7-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32968 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934542AbdCXXXe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:34 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so611597wrx.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:33 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index 23ae482e1..b9176e19d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -955,6 +955,17 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	function.builder = LLVMCreateBuilder();
 
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
 		static int nr_bb;
 		LLVMBasicBlockRef bbr;
-- 
2.12.0

