From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: [PATCH 1/2 v2] sparse, llvm: compile: skip function prototypes to avoid SIGSEGV
Date: Fri, 12 Jun 2015 08:20:39 +0300
Message-ID: <1434086440-26905-1-git-send-email-a3at.mail@gmail.com>
References: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:36679 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbFLFUr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Jun 2015 01:20:47 -0400
Received: by lazv15 with SMTP id v15so14910288laz.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 Jun 2015 22:20:46 -0700 (PDT)
In-Reply-To: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, Azat Khuzhin <a3at.mail@gmail.com>

You can't pass function to LLVMConstNull(), according to
Constant::getNullValue, and sparse-llvm already handle functions differently
(i.e. there will be no call to LLVMConstNull(), but this is not true for
function prototypes, because of how linearize_fn() works:
```
static struct entrypoint *linearize_fn(...)
{
  ...
  if (!base_type->stmt)
    return NULL;
  ...
}
```

```
Constant *Constant::getNullValue(Type *Ty) {
  switch (Ty->getTypeID()) {
  ...
  default:
    // Function, Label, or Opaque type?
    llvm_unreachable("Cannot create a null constant of that type!");
  }
}
```

Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
---
v2: Add SOF.

 sparse-llvm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index ecb5b28..6b41afd 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1070,6 +1070,13 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 	return data;
 }
 
+static int is_prototype(struct symbol *sym)
+{
+	if (sym->type == SYM_NODE)
+		sym = sym->ctype.base_type;
+	return sym && sym->type == SYM_FN && !sym->stmt;
+}
+
 static int compile(LLVMModuleRef module, struct symbol_list *list)
 {
 	struct symbol *sym;
@@ -1077,6 +1084,10 @@ static int compile(LLVMModuleRef module, struct symbol_list *list)
 	FOR_EACH_PTR(list, sym) {
 		struct entrypoint *ep;
 		expand_symbol(sym);
+
+		if (is_prototype(sym))
+			continue;
+
 		ep = linearize_symbol(sym);
 		if (ep)
 			output_fn(module, ep);
-- 
2.1.4

