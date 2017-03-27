From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 06/52] llvm: give arguments a name
Date: Mon, 27 Mar 2017 23:23:30 +0200
Message-ID: <20170327212416.18536-7-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36446 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbdC0V0m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id u1so17115696wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:36 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
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
 sparse-llvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 23ae482e1..53c13122b 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -935,6 +935,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	struct symbol *arg;
 	const char *name;
 	int nr_args = 0;
+	int i;
 
 	FOR_EACH_PTR(base_type->arguments, arg) {
 		struct symbol *arg_base_type = arg->ctype.base_type;
@@ -955,6 +956,17 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	function.builder = LLVMCreateBuilder();
 
+	/* give a name to each argument */
+	for (i = 0; i < nr_args; i++) {
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

