From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/7] builtin: can be initialized later
Date: Wed, 10 Jun 2020 22:27:29 +0200
Message-ID: <20200610202735.84968-2-luc.vanoostenryck@gmail.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgFJU1p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Jun 2020 16:27:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2EC03E96B
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o15so4037859ejm.12
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:44 -0700 (PDT)
In-Reply-To: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The itialization of the buitins can be done later,
after that the types have been initialized.

So move the call to init_builtins() to just before declare_builtins().
This will allow some other small improvements.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c    | 1 +
 symbol.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 8f071bfe96ef..aa1c1d656b9d 100644
--- a/lib.c
+++ b/lib.c
@@ -1595,6 +1595,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 
 		predefined_macros();
 		create_builtin_stream();
+		init_builtins(0);
 		declare_builtins();
 
 		list = sparse_initial();
diff --git a/symbol.c b/symbol.c
index 7044ab3f78ce..6ee521ba48d8 100644
--- a/symbol.c
+++ b/symbol.c
@@ -783,7 +783,6 @@ void init_symbols(void)
 #include "ident-list.h"
 
 	init_parser(stream);
-	init_builtins(stream);
 }
 
 // For fix-sized types
-- 
2.27.0
