From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 18/63] llvm: give arguments a name
Date: Tue, 21 Mar 2017 01:15:22 +0100
Message-ID: <20170321001607.75169-19-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36501 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755839AbdCUAQk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id l37so20367561wrc.3
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:39 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

