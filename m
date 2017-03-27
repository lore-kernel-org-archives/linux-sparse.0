From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 04/52] llvm: reduce scope of 'bb_nr'
Date: Mon, 27 Mar 2017 23:23:28 +0200
Message-ID: <20170327212416.18536-5-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36429 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbdC0V0g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:36 -0400
Received: by mail-wr0-f194.google.com with SMTP id u1so17115564wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:34 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 68bd94181..51fd6a96a 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -958,9 +958,8 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	function.builder = LLVMCreateBuilder();
 
-	static int nr_bb;
