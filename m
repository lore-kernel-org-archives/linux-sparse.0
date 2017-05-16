From: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] Makefile: remove SMATCH_DATA smatch_data/kernel.balanced_funcs item
Date: Tue, 16 May 2017 18:43:08 +0100
Message-ID: <20170516174308.27102-1-kerolasa@iki.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33507 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdEPRnM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 May 2017 13:43:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so39916528wmh.0
        for <linux-sparse@vger.kernel.org>; Tue, 16 May 2017 10:43:11 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>

File was removed recently.  Removal commit missed Makefile clean up.

Reference: cbaabe0a71f079030baa406b3e1fe9e0ca7e785a
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e7f66070..4b7afe68 100644
--- a/Makefile
+++ b/Makefile
@@ -78,7 +78,7 @@ SMATCH_FILES=smatch_flow.o smatch_conditions.o smatch_slist.o smatch_states.o \
 	smatch_return_to_param.o smatch_passes_array_size.o
 
 SMATCH_CHECKS=$(shell ls check_*.c | sed -e 's/\.c/.o/')
-SMATCH_DATA=smatch_data/kernel.allocation_funcs smatch_data/kernel.balanced_funcs \
+SMATCH_DATA=smatch_data/kernel.allocation_funcs \
 	smatch_data/kernel.frees_argument smatch_data/kernel.puts_argument \
 	smatch_data/kernel.dev_queue_xmit smatch_data/kernel.returns_err_ptr \
 	smatch_data/kernel.dma_funcs smatch_data/kernel.returns_held_funcs \
-- 
2.13.0

