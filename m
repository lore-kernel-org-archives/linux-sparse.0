From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 45/51] llvm: add support for restricted types
Date: Sat, 25 Mar 2017 00:20:51 +0100
Message-ID: <20170324232057.15033-46-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36258 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936333AbdCXXYL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so805324wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:10 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

