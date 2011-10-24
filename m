From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 1/2] sparse, llvm: Use new LLVM type system API for structs
Date: Mon, 24 Oct 2011 18:37:21 +0300
Message-ID: <1319470642-21031-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39731 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782Ab1JXPhe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 11:37:34 -0400
Received: by bkbzt19 with SMTP id zt19so8339129bkb.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 08:37:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

To fix an issue with structs that refer to themselves:

  struct symbol {
          struct symbol *next;
  };

convert the code to use new type system API introduced in LLVM 3.0 so that
there's a LLVMTypeRef of the struct we can look up while walking through the
struct members.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index fc0c2e9..14744e5 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -40,15 +40,26 @@ static LLVMTypeRef sym_struct_type(struct symbol *sym)
 {
 	LLVMTypeRef elem_types[MAX_STRUCT_MEMBERS];
 	struct symbol *member;
+	char buffer[256];
+	LLVMTypeRef ret;
 	unsigned nr = 0;
 
+	sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
+
+	ret = LLVMStructCreateNamed(LLVMGetGlobalContext(), buffer);
+
 	FOR_EACH_PTR(sym->symbol_list, member) {
+		LLVMTypeRef member_type;
+
 		assert(nr < MAX_STRUCT_MEMBERS);
 
-		elem_types[nr++] = symbol_type(member);
+		member_type = symbol_type(member);
+
+		elem_types[nr++] = member_type; 
 	} END_FOR_EACH_PTR(member);
 
-	return LLVMStructType(elem_types, nr, 0 /* packed? */);
+	LLVMStructSetBody(ret, elem_types, nr, 0 /* packed? */); 
+	return ret;
 }
 
 static LLVMTypeRef sym_ptr_type(struct symbol *sym)
-- 
1.7.6.4

