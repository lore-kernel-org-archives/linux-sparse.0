From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] attribute: sort the table of modifier names
Date: Mon, 18 May 2020 01:31:17 +0200
Message-ID: <20200517233122.1872-2-luc.vanoostenryck@gmail.com>
References: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXb2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:31:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747AC061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so9663884wrp.12
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:28 -0700 (PDT)
In-Reply-To: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It easier to search an item if sorted and this avoid needless
conflict when new items are always added at the end of the table.

So, sort the table but keep the storage modifers first so
that show_typename() & friends still display types as usual.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 show-parse.c                 | 26 +++++++++++++-------------
 validation/cond_expr2.c      |  2 +-
 validation/function-redecl.c |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index 8a145b887914..0c4b9ec27645 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -119,28 +119,28 @@ const char *modifier_string(unsigned long mod)
 
 	static struct mod_name mod_names[] = {
 		{MOD_AUTO,		"auto"},
+		{MOD_EXTERN,		"extern"},
 		{MOD_REGISTER,		"register"},
 		{MOD_STATIC,		"static"},
-		{MOD_EXTERN,		"extern"},
+		{MOD_INLINE,		"inline"},
 		{MOD_CONST,		"const"},
-		{MOD_VOLATILE,		"volatile"},
 		{MOD_RESTRICT,		"restrict"},
-		{MOD_ATOMIC,		"[atomic]"},
-		{MOD_SIGNED,		"[signed]"},
-		{MOD_UNSIGNED,		"[unsigned]"},
-		{MOD_TLS,		"[tls]"},
-		{MOD_INLINE,		"inline"},
+		{MOD_VOLATILE,		"volatile"},
 		{MOD_ADDRESSABLE,	"[addressable]"},
+		{MOD_ASSIGNED,		"[assigned]"},
+		{MOD_ATOMIC,		"[atomic]"},
+		{MOD_BITWISE,		"[bitwise]"},
+		{MOD_EXPLICITLY_SIGNED,	"[explicitly-signed]"},
 		{MOD_NOCAST,		"[nocast]"},
 		{MOD_NODEREF,		"[noderef]"},
-		{MOD_TOPLEVEL,		"[toplevel]"},
-		{MOD_ASSIGNED,		"[assigned]"},
-		{MOD_SAFE,		"[safe]"},
-		{MOD_USERTYPE,		"[usertype]"},
 		{MOD_NORETURN,		"[noreturn]"},
-		{MOD_EXPLICITLY_SIGNED,	"[explicitly-signed]"},
-		{MOD_BITWISE,		"[bitwise]"},
 		{MOD_PURE,		"[pure]"},
+		{MOD_SAFE,		"[safe]"},
+		{MOD_SIGNED,		"[signed]"},
+		{MOD_TLS,		"[tls]"},
+		{MOD_TOPLEVEL,		"[toplevel]"},
+		{MOD_UNSIGNED,		"[unsigned]"},
+		{MOD_USERTYPE,		"[usertype]"},
 	};
 
 	for (i = 0; i < ARRAY_SIZE(mod_names); i++) {
diff --git a/validation/cond_expr2.c b/validation/cond_expr2.c
index 5e974cfaffb3..a5d965764a6f 100644
--- a/validation/cond_expr2.c
+++ b/validation/cond_expr2.c
@@ -16,7 +16,7 @@ cond_expr2.c:6:11: warning: incorrect type in assignment (different modifiers)
 cond_expr2.c:6:11:    expected void volatile *extern [addressable] [toplevel] q
 cond_expr2.c:6:11:    got void const volatile *
 cond_expr2.c:8:11: warning: incorrect type in assignment (different modifiers)
-cond_expr2.c:8:11:    expected int volatile *extern [addressable] [toplevel] [assigned] r
+cond_expr2.c:8:11:    expected int volatile *extern [addressable] [assigned] [toplevel] r
 cond_expr2.c:8:11:    got int const volatile *
  * check-error-end
  */
diff --git a/validation/function-redecl.c b/validation/function-redecl.c
index 0315135932ab..d0d844a5422a 100644
--- a/validation/function-redecl.c
+++ b/validation/function-redecl.c
@@ -51,11 +51,11 @@ void arg_vararg(int a, ...) { }			/* check-should-fail */
 function-redecl.c:5:6: error: symbol 'ret_type' redeclared with different type (different base types):
 function-redecl.c:5:6:    void extern [addressable] [toplevel] ret_type( ... )
 function-redecl.c:4:5: note: previously declared as:
-function-redecl.c:4:5:    int extern [signed] [addressable] [toplevel] ret_type( ... )
+function-redecl.c:4:5:    int extern [addressable] [signed] [toplevel] ret_type( ... )
 function-redecl.c:9:11: error: symbol 'ret_const' redeclared with different type (different modifiers):
-function-redecl.c:9:11:    int extern const [signed] [addressable] [toplevel] ret_const( ... )
+function-redecl.c:9:11:    int extern const [addressable] [signed] [toplevel] ret_const( ... )
 function-redecl.c:8:5: note: previously declared as:
-function-redecl.c:8:5:    int extern [signed] [addressable] [toplevel] ret_const( ... )
+function-redecl.c:8:5:    int extern [addressable] [signed] [toplevel] ret_const( ... )
 function-redecl.c:13:13: error: symbol 'ret_as' redeclared with different type (different address spaces):
 function-redecl.c:13:13:    void <asn:1> *extern [addressable] [toplevel] ret_as( ... )
 function-redecl.c:12:6: note: previously declared as:
-- 
2.26.2
