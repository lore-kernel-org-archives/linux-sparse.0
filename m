From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 09/30] llvm: reduce scope of 'bb_nr'
Date: Sun, 19 Mar 2017 02:42:06 +0100
Message-ID: <20170319014227.8833-10-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36142 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdCSBms (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id l37so13792031wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:47 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
