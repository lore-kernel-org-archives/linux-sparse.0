From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 16/63] llvm: reduce scope of 'bb_nr'
Date: Tue, 21 Mar 2017 01:15:20 +0100
Message-ID: <20170321001607.75169-17-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33052 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbdCUAQi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11so267589wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:37 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
