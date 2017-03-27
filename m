From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 48/52] llvm: fix type of bitfields
Date: Mon, 27 Mar 2017 23:24:12 +0200
Message-ID: <20170327212416.18536-49-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33718 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbdC0V1N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so17045236wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:11 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c1aefc682..840e8c6ba 100644
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

