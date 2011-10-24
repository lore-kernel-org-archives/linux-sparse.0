From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Fix 'void *' pointer code generation
Date: Mon, 24 Oct 2011 14:43:39 +0300
Message-ID: <1319456619-11546-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61220 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab1JXLnv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 07:43:51 -0400
Received: by bkbzt19 with SMTP id zt19so8090209bkb.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 04:43:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

Sparse front-end generates SYM_PTR with SYM_BASETYPE with bit_size set to -1
for "void *" pointers. We currently map that to LLVMVoidType() but that no
longer works with LLVM Subversion trunk:

  $ ./sparse-llvm validation/backend/struct.c
  sparse-llvm: Type.cpp:676: static llvm::PointerType* llvm::PointerType::get(llvm::Type*, unsigned int): Assertion `isValidElementType(EltTy) && "Invalid type for pointer element!"' failed.
Aborted

Fix the issue by switching to LLVMIntType(bits_per_pointer) in
sym_basetype_type().

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a85dfea..ec46a04 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -80,7 +80,7 @@ static LLVMTypeRef sym_basetype_type(struct symbol *sym)
 	} else {
 		switch (sym->bit_size) {
 		case -1:
-			ret = LLVMVoidType();
+			ret = LLVMIntType(bits_in_pointer);
 			break;
 		case 8:
 			ret = LLVMInt8Type();
-- 
1.7.6.4

