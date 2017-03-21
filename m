From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 57/63] llvm: add support for restricted types
Date: Tue, 21 Mar 2017 01:16:01 +0100
Message-ID: <20170321001607.75169-58-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33921 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756013AbdCUARW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so264770wmg.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:20 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index ac0093a3b..6e6d49bf2 100644
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

