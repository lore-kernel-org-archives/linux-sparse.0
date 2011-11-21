From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 2/3] sparse, llvm: Fix 'extern' symbol code generation
Date: Mon, 21 Nov 2011 22:03:29 +0200
Message-ID: <1321905810-2253-2-git-send-email-penberg@kernel.org>
References: <1321905810-2253-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54471 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab1KUUDk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Nov 2011 15:03:40 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so7013808bke.19
        for <linux-sparse@vger.kernel.org>; Mon, 21 Nov 2011 12:03:39 -0800 (PST)
In-Reply-To: <1321905810-2253-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

LLVMExternalLinkage is used for both extern and non-extern C symbols. The
linkage is differentiated by LLVMSetInitializer() which is should not be called
for extern symbols.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index ca49a6e..1a2a34d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1090,7 +1090,8 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 
 	LLVMSetLinkage(data, data_linkage(sym));
 
-	LLVMSetInitializer(data, initial_value);
+	if (!(sym->ctype.modifiers & MOD_EXTERN))
+		LLVMSetInitializer(data, initial_value);
 
 	return data;
 }
-- 
1.7.6.4

