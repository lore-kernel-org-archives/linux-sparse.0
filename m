From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 45/52] llvm: add support for restricted types
Date: Mon, 27 Mar 2017 23:24:09 +0200
Message-ID: <20170327212416.18536-46-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35343 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbdC0V1P (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id p52so14122320wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:13 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index cd527eb1c..8b170b4bf 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -203,6 +203,7 @@ static LLVMTypeRef symbol_type(struct symbol *sym)
 
 	switch (sym->type) {
 	case SYM_BITFIELD:
+	case SYM_RESTRICT:
 	case SYM_ENUM:
 		ret = symbol_type(sym->ctype.base_type);
 		break;
-- 
2.12.0

