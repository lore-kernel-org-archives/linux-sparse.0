From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 04/51] llvm: reduce scope of 'bb_nr'
Date: Sat, 25 Mar 2017 00:20:10 +0100
Message-ID: <20170324232057.15033-5-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35739 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934607AbdCXXXc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id u108so605253wrb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:31 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
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
