From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 60/63] llvm: fix type of bitfields
Date: Tue, 21 Mar 2017 01:16:04 +0100
Message-ID: <20170321001607.75169-61-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34506 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbdCUARa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:30 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so20450590wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:24 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

