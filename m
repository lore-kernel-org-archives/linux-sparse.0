From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 27/27] llvm: reduce scope of 'bb_nr'
Date: Sat, 11 Mar 2017 10:07:06 +0100
Message-ID: <20170311090706.17171-28-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36480 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbdCKJHv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:51 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so14058085wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:50 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 831a56207..70a495267 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1071,8 +1071,6 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	function.builder = LLVMCreateBuilder();
 
-	static int nr_bb;
