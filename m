From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH] nios2: add declaration for __builtin_{rd,wr}ctl()
Date: Tue,  9 Jun 2020 20:45:21 +0200
Message-ID: <20200609184521.47758-1-luc.vanoostenryck@gmail.com>
References: <20200609151329.GU23011@xsang-OptiPlex-9020>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFISpa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 Jun 2020 14:45:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C9C05BD1E
        for <linux-sparse@vger.kernel.org>; Tue,  9 Jun 2020 11:45:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o15so23521948ejm.12
        for <linux-sparse@vger.kernel.org>; Tue, 09 Jun 2020 11:45:29 -0700 (PDT)
In-Reply-To: <20200609151329.GU23011@xsang-OptiPlex-9020>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Era Mayflower <mayflowerera@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, kbuild test robot <lkp@intel.com>

These 2 are used for the kernel and the lack of a
declaration is causing problems.

So add the declarations for these 2 builtins.
At the same time also add one for '__builtin_custom_ini()'
since this one may also be used in the kernel.

Note: a better fix should be to move this to target-nios2.c

Link: https://lore.kernel.org/lkml/20200609151329.GU23011@xsang-OptiPlex-9020/
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin.c b/builtin.c
index debc22c036ec..5ed17700d422 100644
--- a/builtin.c
+++ b/builtin.c
@@ -613,4 +613,9 @@ void declare_builtins(void)
 	declare_builtin("__builtin_bfin_csync", &void_ctype, 0, NULL);
 	declare_builtin("__builtin_bfin_ssync", &void_ctype, 0, NULL);
 	declare_builtin("__builtin_bfin_norm_fr1x32", &int_ctype, 0, &int_ctype, NULL);
+
+	// Nios-II-specific
+	declare_builtin("__builtin_rdctl", &int_ctype, 0, &int_ctype, NULL);
+	declare_builtin("__builtin_wrctl", &void_ctype, 0, &int_ctype, &int_ctype, NULL);
+	declare_builtin("__builtin_custom_ini", &int_ctype, 0, &int_ctype, NULL);
 }
-- 
2.27.0
