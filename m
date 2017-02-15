From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] remove unused field 'goto_bb' in struct statement
Date: Wed, 15 Feb 2017 23:13:57 +0100
Message-ID: <20170215221358.68400-4-luc.vanoostenryck@gmail.com>
References: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34714 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdBOWOJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 17:14:09 -0500
Received: by mail-wr0-f194.google.com with SMTP id c4so7321097wrd.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 14:14:08 -0800 (PST)
In-Reply-To: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/parse.h b/parse.h
index f2463f5fd..a2b3e3889 100644
--- a/parse.h
+++ b/parse.h
@@ -104,10 +104,6 @@ struct statement {
 			struct expression *goto_expression;
 			struct symbol_list *target_list;
 		};
-		struct /* goto_bb */ {
-			struct expression *bb_conditional;
-			struct symbol *bb_target;
-		};
 		struct /* asm */ {
 			struct expression *asm_string;
 			struct expression_list *asm_outputs;
-- 
2.11.0

