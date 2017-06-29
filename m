From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/7] diet: remove unused struct symbol::arg_count
Date: Thu, 29 Jun 2017 07:16:43 +0200
Message-ID: <20170629051646.35988-5-luc.vanoostenryck@gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36127 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdF2FTC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:19:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id y5so340709wmh.3
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:19:02 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not used, it's never set and .. it seems has never been used.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/symbol.h b/symbol.h
index 327449611..ac3fd8bf0 100644
--- a/symbol.h
+++ b/symbol.h
@@ -164,7 +164,6 @@ struct symbol {
 			unsigned long	offset;
 			int		bit_size;
 			unsigned int	bit_offset:8,
-					arg_count:10,
 					variadic:1,
 					initialized:1,
 					examined:1,
-- 
2.13.0

