From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] give a type to builtin functions
Date: Tue,  2 Jan 2018 16:11:15 +0100
Message-ID: <20180102151116.22060-2-luc.vanoostenryck@gmail.com>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
 <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40121 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeABPL3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Jan 2018 10:11:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id f206so61277292wmf.5
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jan 2018 07:11:29 -0800 (PST)
In-Reply-To: <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: foobar <foobar@redchan.it>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When creating builtin functions via init-builtins(), it shouldn't
really be needed to give them a type because their purpose is only
as a placeholder for the symbol->op->{evaluate,expand,..}. Also,
they should be part of the builtin_scope and never be visible.

However, currently the global scope is the same as the builtin_scope
and these symbols are thus visible via global_scope->symbols where
the missing type can be a problem.

Fix this to giving to the builtin functions which hadn't a type
the same phony type as the other functions had.

Reported-by: foobar <foobar@redchan.it>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin.c b/builtin.c
index 9f90926cb..acb2fabe9 100644
--- a/builtin.c
+++ b/builtin.c
@@ -240,9 +240,9 @@ static struct sym_init {
 	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
 	{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
 	{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
-	{ "__builtin_bswap16", NULL, MOD_TOPLEVEL, &bswap_op },
-	{ "__builtin_bswap32", NULL, MOD_TOPLEVEL, &bswap_op },
-	{ "__builtin_bswap64", NULL, MOD_TOPLEVEL, &bswap_op },
+	{ "__builtin_bswap16", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
+	{ "__builtin_bswap32", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
+	{ "__builtin_bswap64", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
 	{ NULL,		NULL,		0 }
 };
 
-- 
2.15.0

