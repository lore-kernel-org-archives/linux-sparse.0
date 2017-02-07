From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] add an helper for common predefined macros
Date: Tue,  7 Feb 2017 21:04:23 +0100
Message-ID: <20170207200425.34189-3-luc.vanoostenryck@gmail.com>
References: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34563 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbdBGUGe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:06:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so30346519wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:06:33 -0800 (PST)
In-Reply-To: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Eventually, most of what GCC predefine (gcc -E -dM)
should be defined here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 3996c5673..018fa145e 100644
--- a/lib.c
+++ b/lib.c
@@ -802,6 +802,11 @@ static char **handle_switch(char *arg, char **next)
 	return next;
 }
 
+static void predefined_macros(void)
+{
+	add_pre_buffer("#define __CHECKER__ 1\n");
+}
+
 void declare_builtin_functions(void)
 {
 	/* Gaah. gcc knows tons of builtin <string.h> functions */
@@ -1154,7 +1159,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		init_ctype();
 
 		create_builtin_stream();
-		add_pre_buffer("#define __CHECKER__ 1\n");
+		predefined_macros();
 		if (!preprocess_only)
 			declare_builtin_functions();
 
-- 
2.11.0

