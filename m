From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/15] options: add a small helper: handle_switch_finalize()
Date: Sun,  5 Jul 2020 15:02:15 +0200
Message-ID: <20200705130220.26230-11-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGENCj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4FC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so39552924ejn.10
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:38 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is just to isolate the details about which switch need an
extra 'finalization' in a separate function in preparation
to moving all the parsing code in a separate file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index b3bacb180cac..a56efcaa64fd 100644
--- a/lib.c
+++ b/lib.c
@@ -1220,6 +1220,12 @@ static char **handle_switch(char *arg, char **next)
 	return next;
 }
 
+static void handle_switch_finalize(void)
+{
+	handle_switch_v_finalize();
+	handle_switch_W_finalize();
+}
+
 ////////////////////////////////////////////////////////////////////////////////
 // Predefines
 
@@ -1576,8 +1582,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		}
 		add_ptr_list(filelist, arg);
 	}
-	handle_switch_W_finalize();
-	handle_switch_v_finalize();
+	handle_switch_finalize();
 
 	// Redirect stdout if needed
 	if (dump_macro_defs || preprocess_only)
-- 
2.27.0
