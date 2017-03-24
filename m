From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 48/51] llvm: fix type of bitfields
Date: Sat, 25 Mar 2017 00:20:54 +0100
Message-ID: <20170324232057.15033-49-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34937 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936134AbdCXXYO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id u108so606536wrb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:12 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 93237b3d0..f57571f1c 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -203,6 +203,8 @@ static LLVMTypeRef symbol_type(struct symbol *sym)
 
 	switch (sym->type) {
 	case SYM_BITFIELD:
+		ret = LLVMIntType(sym->bit_size);
+		break;
 	case SYM_RESTRICT:
 	case SYM_ENUM:
 		ret = symbol_type(sym->ctype.base_type);
-- 
2.12.0

