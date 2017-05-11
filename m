From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/3] introduce REPEAT_CFG_CLEANUP
Date: Fri, 12 May 2017 00:26:19 +0200
Message-ID: <20170511222621.88420-2-luc.vanoostenryck@gmail.com>
References: <CANeU7QnpFci3ViG9dP1g5x1wPKnR=dAXCiLwnD4buD9t1NyaeA@mail.gmail.com>
 <20170511222621.88420-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36572 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754689AbdEKW0a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 18:26:30 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so5377830wrc.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 15:26:29 -0700 (PDT)
In-Reply-To: <20170511222621.88420-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/flow.h b/flow.h
index 31ed80d40..b592ad4d3 100644
--- a/flow.h
+++ b/flow.h
@@ -7,6 +7,7 @@ extern unsigned long bb_generation;
 
 #define REPEAT_CSE		1
 #define REPEAT_SYMBOL_CLEANUP	2
+#define REPEAT_CFG_CLEANUP	3
 
 struct entrypoint;
 struct instruction;
-- 
2.12.2

