From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove unused fields in struct instruction
Date: Thu,  8 Dec 2016 04:13:27 +0100
Message-ID: <20161208031327.1631-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35421 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932972AbcLHD1n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 22:27:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so692743wme.2
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 19:27:42 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The fields 'begin' & 'end' (multijmp) are unused since commit
0b67ecb622146f71aa6e43379f526d11bdd48b37 which introduced
the field 'multijmp_list'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/linearize.h b/linearize.h
index 61fbd831..e3e67dde 100644
--- a/linearize.h
+++ b/linearize.h
@@ -106,9 +106,6 @@ struct instruction {
 			pseudo_t base;
 			unsigned from, len;
 		};
-		struct /* multijump */ {
-			int begin, end;
-		};
 		struct /* setval */ {
 			pseudo_t symbol;		/* Subtle: same offset as "src" !! */
 			struct expression *val;
-- 
2.10.2

