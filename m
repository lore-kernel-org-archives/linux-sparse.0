From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Fix symbol_type() for bitfields and enums
Date: Tue, 25 Oct 2011 11:59:16 +0300
Message-ID: <1319533156-2765-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45471 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab1JYI7X (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Oct 2011 04:59:23 -0400
Received: by bkbzt19 with SMTP id zt19so246402bkb.19
        for <linux-sparse@vger.kernel.org>; Tue, 25 Oct 2011 01:59:22 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch adds SYM_BITFIELD and SYM_ENUM support to symbol_type().

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 5d1b79c..9f4586f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -121,6 +121,8 @@ static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 	LLVMTypeRef ret = NULL;
 
 	switch (sym->type) {
+	case SYM_BITFIELD:
+	case SYM_ENUM:
 	case SYM_NODE:
 		ret = symbol_type(module, sym->ctype.base_type);
 		break;
-- 
1.7.6.4

