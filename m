From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove unused field 'multijump' in struct instruction
Date: Tue, 22 Nov 2016 17:43:30 +0100
Message-ID: <20161122164330.3953-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36569 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbcKVRBS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 12:01:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so5114961wma.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 09:00:24 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This field was introduced (I think) for OP_SWITCH but is
not needed anymore as OP_SWITCH has its own entry with a field
fOr multijump list.
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

