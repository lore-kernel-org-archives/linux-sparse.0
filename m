From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] sparse, llvm: Fix 'void *' pointer code generation
Date: Mon, 24 Oct 2011 14:56:41 +0300 (EEST)
Message-ID: <alpine.LFD.2.02.1110241455580.13879@tux.localdomain>
References: <1319456619-11546-1-git-send-email-penberg@kernel.org> <CA+55aFx1=9C_QDE2CfqLp1zg_t=x+VjKUPZgj2karJsS1FAZaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49402 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769Ab1JXL4t (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 07:56:49 -0400
Received: by bkbzt19 with SMTP id zt19so8101531bkb.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 04:56:48 -0700 (PDT)
In-Reply-To: <CA+55aFx1=9C_QDE2CfqLp1zg_t=x+VjKUPZgj2karJsS1FAZaA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Mon, Oct 24, 2011 at 1:43 PM, Pekka Enberg <penberg@kernel.org> wrote:
>> Fix the issue by switching to LLVMIntType(bits_per_pointer) in
>> sym_basetype_type().

On Mon, 24 Oct 2011, Linus Torvalds wrote:
> Why bits_per_pointer? Isn't this the "base type" of void *? A more
> logical choice would seem to be to make it equivalent to "char *", and
> just make it fall through to the "case 8" case?

Indeed. Updated patch below.

 			Pekka

From f90242c21b21d91cfed57aa050b4726b6060dfdd Mon Sep 17 00:00:00 2001
From: Pekka Enberg <penberg@kernel.org>
Date: Mon, 24 Oct 2011 14:11:13 +0300
Subject: [PATCH] sparse, llvm: Fix 'void *' pointer code generation

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
  sparse-llvm.c |    4 +---
  1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a85dfea..fc0c2e9 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -79,9 +79,7 @@ static LLVMTypeRef sym_basetype_type(struct symbol *sym)
  		}
  	} else {
  		switch (sym->bit_size) {
-		case -1:
-			ret = LLVMVoidType();
-			break;
+		case -1:	/* 'void *' is treated like 'char *' */
  		case 8:
  			ret = LLVMInt8Type();
  			break;
-- 
1.7.6.4

