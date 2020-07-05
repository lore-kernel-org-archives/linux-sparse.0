From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/15] options: make Wsparse_error less special
Date: Sun,  5 Jul 2020 15:02:09 +0200
Message-ID: <20200705130220.26230-5-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A01C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a8so30993232edy.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:32 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-Wsparse-error should not be enabled with -Wsparse-all, this is
special cased in the condition in loop handling -Wsparse-all.

However, the condition already handle warnings forced to off.
So instead of explicitly checking for &Wsparse_error, it's enough
to force Wsparse_error off.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 43d55a0648ee..9acdc60fc416 100644
--- a/lib.c
+++ b/lib.c
@@ -276,7 +276,6 @@ int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
 int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
-int Wsparse_error = 0;
 int Wmemcpy_max_count = 1;
 int Wnewline_eof = 1;
 int Wnon_pointer_null = 1;
@@ -296,6 +295,7 @@ int Wshadow = 0;
 int Wshift_count_negative = 1;
 int Wshift_count_overflow = 1;
 int Wsizeof_bool = 0;
+int Wsparse_error = WARNING_FORCE_OFF;
 int Wstrict_prototypes = 1;
 int Wtautological_compare = 0;
 int Wtransparent_union = 0;
@@ -793,7 +793,7 @@ static char **handle_switch_W(char *arg, char **next)
 	if (!strcmp(arg, "Wsparse-all")) {
 		int i;
 		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
+			if (*warnings[i].flag != WARNING_FORCE_OFF)
 				*warnings[i].flag = WARNING_ON;
 		}
 	}
-- 
2.27.0
