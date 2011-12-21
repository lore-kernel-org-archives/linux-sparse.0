From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 1/3] sparse, llvm: Use LLVMInt1Type() in sym_basetype_type()
Date: Wed, 21 Dec 2011 11:25:26 +0200
Message-ID: <1324459528-9344-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57432 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495Ab1LUJZn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Dec 2011 04:25:43 -0500
Received: by lahd3 with SMTP id d3so467217lah.19
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2011 01:25:42 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

In preparation for reverting commit 2ded1e7 ("sparse: Bump up sizeof(_Bool) to
8 bits"), teach sym_basetype_type() about LLVMInt1Type().

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 38f40fc..a291a0d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -175,6 +175,9 @@ static LLVMTypeRef sym_basetype_type(struct symbol *sym)
 		}
 	} else {
 		switch (sym->bit_size) {
+		case 1:
+			ret = LLVMInt1Type();
+			break;
 		case -1:	/* 'void *' is treated like 'char *' */
 		case 8:
 			ret = LLVMInt8Type();
-- 
1.7.6.4

