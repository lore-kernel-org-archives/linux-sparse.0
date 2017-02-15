From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] remove unused field 'multijmp' in struct statement
Date: Wed, 15 Feb 2017 23:13:56 +0100
Message-ID: <20170215221358.68400-3-luc.vanoostenryck@gmail.com>
References: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36243 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdBOWOI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 17:14:08 -0500
Received: by mail-wr0-f193.google.com with SMTP id k90so32697863wrc.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 14:14:07 -0800 (PST)
In-Reply-To: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/parse.h b/parse.h
index 195f0fdf3..f2463f5fd 100644
--- a/parse.h
+++ b/parse.h
@@ -108,11 +108,6 @@ struct statement {
 			struct expression *bb_conditional;
 			struct symbol *bb_target;
 		};
-		struct /* multijmp */ {
-			struct expression *multi_from;
-			struct expression *multi_to;
-			struct symbol *multi_target;
-		};
 		struct /* asm */ {
 			struct expression *asm_string;
 			struct expression_list *asm_outputs;
-- 
2.11.0

