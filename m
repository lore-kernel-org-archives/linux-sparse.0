From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/8] add a .warned field to struct instruction
Date: Sat,  3 Jun 2017 10:01:29 +0200
Message-ID: <20170603080135.46477-3-luc.vanoostenryck@gmail.com>
References: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34785 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdFCIBp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 04:01:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so22056408wmf.1
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 01:01:44 -0700 (PDT)
In-Reply-To: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linearize.h b/linearize.h
index c704b87b4..2b6cb0c86 100644
--- a/linearize.h
+++ b/linearize.h
@@ -75,8 +75,9 @@ struct asm_rules {
 DECLARE_ALLOCATOR(asm_rules);
 
 struct instruction {
-	unsigned opcode:8,
-		 size:24;
+	unsigned opcode:7;
+	unsigned warned:1;
+	unsigned size:24;
 	struct basic_block *bb;
 	struct position pos;
 	struct symbol *type;
-- 
2.13.0

